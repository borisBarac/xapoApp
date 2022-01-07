//
//  MainUseCase.swift
//  XapoTest
//
//  Created by Boris Barac on 03.01.2022.
//

import Foundation
import Combine

class GetAndCashDataUseCase {
    let projectRepository: ProjectRepository
    let dataService: DataServiceProtocol

    init(projectRepository: ProjectRepository, dataService: DataServiceProtocol) {
        self.projectRepository = projectRepository
        self.dataService = dataService
    }

    func with(tag: String) -> AnyPublisher<[ProjectItem], HTTPError> {
        self.dataService.getTrending(tag: tag)
            .map { items in
                self.projectRepository.save(projects: items)
                return items
            }.eraseToAnyPublisher()
    }

    #if DEBUG
    /// used for mocking in the swiftUI preview
    func previewList() -> AnyPublisher<[ProjectItem], HTTPError>  {
        var items = [ProjectItem]()
        for id in 0..<100 {
            items.append(ProjectItem(id: Int64(id),
                                     full_name: "TEST TEST",
                                     description: "TEST DESCRIPTION",
                                     owner: BERepoData.Owner(id: id, login: "OWNER TEST", avatar_url: ""),
                                     url: "",
                                     homepage: nil,
                                     forks: id))
        }

        return Future { promise in
            promise(.success(items))
        }.eraseToAnyPublisher()
    }
    #endif
}
