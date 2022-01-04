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
}


