//
//  Model.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import Foundation

extension Int64 {
    var string: String {
        return String(self)
    }
}

/// Created from BE object, to avoid BE shema dependency
/// In this simple case is the same object basically, but those 2 should be separate
typealias ProjectItem = BERepoData.Item

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



