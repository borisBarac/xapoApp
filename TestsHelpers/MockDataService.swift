//
//  MockDataService.swift
//  XapoTestTests
//
//  Created by Boris Barac on 03.01.2022.
//

import Foundation
import Combine
@testable import XapoTest

/// returns 100 fake elements
class MockDataService: DataServiceProtocol {
    var session: URLSession = URLSession.shared
    var urlBuilder: UrlBuilderProtocol = UrlBuilder()

    func getTrending(tag: String) -> AnyPublisher<[ProjectItem], HTTPError> {
        var items = [ProjectItem]()
        for id in 0..<100 {
            items.append(ProjectItem(id: Int64(id),
                                     full_name: "TEST TEST",
                                     description: "TEST DESCRIPTION",
                                     owner: BERepoData.Owner(id: id, login: "OWNER TEST", avatar_url: ""),
                                     url: "",
                                     html_url: "",
                                     homepage: nil,
                                     forks: id))
        }

        return Future { promise in
            promise(.success(items))
        }.eraseToAnyPublisher()
    }
}

class MockDataServiceWithError: DataServiceProtocol {
    var session: URLSession = URLSession.shared
    var urlBuilder: UrlBuilderProtocol = UrlBuilder()

    let error: HTTPError

    init(error: HTTPError) {
        self.error = error
    }

    func getTrending(tag: String) -> AnyPublisher<[ProjectItem], HTTPError> {
        return Future { promise in
            promise(.failure(self.error))
        }.eraseToAnyPublisher()
    }
}
