//
//  DataService.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import Foundation
import Combine


protocol DataServiceProtocol {
    var session: URLSession { get set }
    var urlBuilder: UrlBuilderProtocol { get set }
    func getTrending(tag: String) -> AnyPublisher<[ProjectItem], HTTPError>
}

final class DataService: DataServiceProtocol {
    var session: URLSession
    var urlBuilder: UrlBuilderProtocol
    
    init(session: URLSession, urlBuilder: UrlBuilderProtocol) {
        self.session = session
        self.urlBuilder = urlBuilder
    }
    
    func getTrending(tag: String) -> AnyPublisher<[ProjectItem], HTTPError> {
        guard let url = urlBuilder.build(tag: tag) else {
            return Fail<[ProjectItem], HTTPError>(error: HTTPError.wrongUrl).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { (data, urlResponse) -> Data in
                guard let response = urlResponse as? HTTPURLResponse else {
                    throw HTTPError.statusCode(-1)
                }
                
                guard (200..<300).contains(response.statusCode) else {
                    throw HTTPError.statusCode(response.statusCode)
                }
                
                return data
            }
            .decode(type: BERepoData.self, decoder: JSONDecoder())
            .tryMap { beRepoData in
                beRepoData.items
            }
            .mapError { error -> HTTPError in
                guard let httpError = error as? HTTPError else {
                    if [URLError.notConnectedToInternet.rawValue, URLError.cannotConnectToHost.rawValue]
                        .contains((error as? URLError)?.code.rawValue ?? -1) {
                        return HTTPError.serverDown
                    }
                    
                    print("❗️ failure: \(error.localizedDescription)")
                    return HTTPError.unknown(error)
                }
                
                return httpError
            }
            .eraseToAnyPublisher()
    }
}
