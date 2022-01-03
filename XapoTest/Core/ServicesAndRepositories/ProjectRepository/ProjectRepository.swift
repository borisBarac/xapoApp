//
//  AppRepository.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import Foundation
import Combine

enum SaveStatus {
    case success
    case failure
}

protocol ProjectRepository {
    var lastSyncDate: CurrentValueSubject<Date?, Never> { get set }

    func findProject(id: String) -> ProjectItem?
    func listAll() -> AnyCollection<ProjectItem>
    func removeAllApps()
    func save(projects: [ProjectItem]) -> AnyPublisher<Void, Never>
}

final class InMemoryProjectRepository: ProjectRepository {
    private var allProjects: [String: ProjectItem] = [:]
    var lastSyncDate = CurrentValueSubject<Date?, Never>(nil)

    func findProject(id: String) -> ProjectItem? {
        return allProjects[id]
    }

    func listAll() -> AnyCollection<ProjectItem> {
        let sortedApps = allProjects.map { $0.value }.sorted { $0 > $1 }
        return AnyCollection(sortedApps)
    }

    func removeAllApps() {
        allProjects.removeAll(keepingCapacity: true)
        lastSyncDate.value = nil
    }

    func save(projects: [ProjectItem]) -> AnyPublisher<Void, Never> {
        return Future<Void, Never> { promise in
            projects.forEach {
                self.allProjects[$0.id.string] = $0
            }
            self.lastSyncDate.value = Date()
        }.eraseToAnyPublisher()
    }
}
