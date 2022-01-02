//
//  UrlBuilder.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import Foundation

protocol UrlBuilderProtocol {
    func build(tag: String) -> URL?
}

/// this should be something fancy in a normal project
/// in general i like keeping a URL shema on some cloud, and make it from there when the app starts
/// or just use OpenApi spec and generate it
class UrlBuilder: UrlBuilderProtocol {
    func build(tag: String) -> URL? {
        guard tag.count > 0 else {
            return nil
        }

        return URL(string: "https://api.github.com/search/repositories?q=\(tag)&per_page=50")!
    }
}
