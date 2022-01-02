//
//  Model.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import Foundation

/// BE JSON object representation, gonna get mapped to the obect used in the app
struct BERepoData: Codable {
    let total_count: Int
}

/// Created from BE object, to avoid BE shema dependency
/// In this simple case is the same object basically
struct RepoData: Codable {
    let total_count: Int
}
