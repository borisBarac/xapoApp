//
//  MainUseCase.swift
//  XapoTest
//
//  Created by Boris Barac on 03.01.2022.
//

import Foundation
import Combine

class GetAndSaveDataUseCase {
    let projectRepository: ProjectRepository
    let dataService: CachedDataService

    init(projectRepository: ProjectRepository, dataService: CachedDataService) {
        self.projectRepository = projectRepository
        self.dataService = dataService
    }

    func with(tag: String) -> AnyPublisher<[ProjectItem], HTTPError> {
        self.dataService.getTrending(tag: tag)
    }
}


