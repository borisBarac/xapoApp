//
//  Model.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import Foundation

/// Created from BE object, to avoid BE shema dependency
/// In this simple case is the same object basically, but those 2 should be separate
typealias ProjectItem = BERepoData.Item

extension BERepoData.Item: Comparable {
    static func < (lhs: BERepoData.Item, rhs: BERepoData.Item) -> Bool {
        lhs.forks < rhs.forks
    }

    static func == (lhs: BERepoData.Item, rhs: BERepoData.Item) -> Bool {
        lhs.id == rhs.id
    }

    
}

/// BE JSON object representation, gonna get mapped to the obect used in the app
struct BERepoData: Codable {
    let total_count: Int
    let items: [Item]
}

extension BERepoData {
    struct Item: Codable {
        let id: Int64
        let full_name: String
        let description: String
        let owner: Owner
        let url: String
        let homepage: String?
        let forks: Int
    }

    struct Owner: Codable {
        let id: Int
        let login: String
        let avatar_url: String
    }
    
}



