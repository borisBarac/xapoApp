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

    func findProject(id: String) -> RepoData.Item?
    func listAll() -> AnyCollection<RepoData.Item>
    func removeAllApps()
    func save(apps: [RepoData.Item]) -> AnyPublisher<Void, Never>
}

final class InMemoryProjectRepository: ProjectRepository {
    private var allProjects: [String: RepoData.Item] = [:]
    var lastSyncDate = CurrentValueSubject<Date?, Never>(nil)

    func findProject(id: String) -> RepoData.Item? {
        return allProjects[id]
    }

    func listAll() -> AnyCollection<RepoData.Item> {
        let sortedApps = allProjects.map { $0.value }.sorted { $0.forks < $1.forks }
        return AnyCollection(sortedApps)
    }

    func removeAllApps() {
        allProjects.removeAll(keepingCapacity: true)
    }

    func save(apps: [RepoData.Item]) -> AnyPublisher<Void, Never> {
        return Future<Void, Never> { promise in
            apps.forEach {
                self.allProjects[$0.id] = $0
            }
            self.lastSyncDate.value = Date()
        }.eraseToAnyPublisher()
    }
}
