//
//  _UrlBuilderTests.swift
//  XapoTestTests
//
//  Created by Boris Barac on 02.01.2022.
//

import XCTest
@testable import XapoTest

class _UrlBuilderTests: XCTestCase {

    func testWrongTag() throws {
        let url = UrlBuilder().build(tag: "")
        XCTAssertEqual(url, nil)
    }

    func testUrlTag() throws {
        let url = UrlBuilder().build(tag: "iOS")
        XCTAssertEqual(url?.absoluteString, "https://api.github.com/search/repositories?q=iOS&per_page=50")
    }

}
