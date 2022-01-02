//
//  HttpErrorTests.swift
//  XapoTestTests
//
//  Created by Boris Barac on 02.01.2022.
//

import XCTest
@testable import XapoTest

class _HttpErrorTests: XCTestCase {

    func testErrorTextForCode() throws {
        let codes = [499, 599, -1]
        let expectedMessages = ["Wrong params are send", "We can not reach the server", "Something went wrong"]

        for (index, val) in codes.enumerated() {
            XCTAssertEqual(HTTPError.statusCode(val).failureReason, expectedMessages[index], "HttpErrorTests: Wrong failure reason")
        }
    }

    func testWrongUrlError() throws {
        XCTAssertEqual(HTTPError.wrongUrl.failureReason, "Wrong URL used", "HttpErrorTests: Wrong failure reason")
    }

}
