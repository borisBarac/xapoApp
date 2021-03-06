//
//  _DataServiceTests.swift
//  XapoTestTests
//
//  Created by Boris Barac on 02.01.2022.
//

import XCTest
import Combine
import Mocker
@testable import XapoTest

class _DataServiceTests: XCTestCase {
    let tag = "swift"
    var dataService: DataService!
    var mockError: Mock!

    override func setUp() {
        super.setUp()
        dataService = DataService(session: URLSession.shared, urlBuilder: UrlBuilder())
    }

    override func tearDown() {
        Mocker.removeAll()
        Mocker.mode = .optout
        super.tearDown()
    }

    func testNormalRequest() throws {
        mockSucessfullApiCall()

        let pub = dataService.getTrending(tag: tag)
        let result = try awaitCompletion(of: pub)

        XCTAssertNotNil(result)
        XCTAssertGreaterThan(result.first?.count ?? -1, 0, "No elements have been parsed")
    }

    func testNoInternet() throws {
        mockApiError()

        let pub = DataService(session: URLSession.shared, urlBuilder: UrlBuilder()).getTrending(tag: tag)

        do {
            let res = try awaitCompletion(of: pub)
            XCTAssertEqual(res.count, 0)
        } catch(let error) {
            guard let httpError = error as? HTTPError else {
                XCTFail("Wrong error type")
                return
            }

            switch httpError {
            case .serverDown:
                // passed :)
                // XCTest needs XCTPass()
                break
            default:
                XCTFail("Wrong error type")
            }
        }
    }
}

class _CachedDataService: _DataServiceTests {
    func testCashing() throws {
        mockSucessfullApiCall()

        let repository = InMemoryProjectRepository()
        dataService = CachedDataService(session: URLSession.shared, urlBuilder: UrlBuilder(), repository: repository)

        let pub = dataService.getTrending(tag: tag)
        let result = try awaitCompletion(of: pub)

        XCTAssertNotNil(result)
        XCTAssertGreaterThan(repository.listAll().count, 0, "Caching failed")
    }
}

private extension _DataServiceTests {
    func mockSucessfullApiCall() {
        let url = UrlBuilder().build(tag: tag)!
        Mock(url: url, dataType: .json, statusCode: 200, data: [
            .get : try! Data(contentsOf: MockedData.exampleJSON) // Data containing the JSON response
        ]).register()
    }

    func mockApiError() {
        let url = UrlBuilder().build(tag: tag)!
        Mock(url: url, dataType: .json, statusCode: 500, data: [.get: Data()],
             requestError: URLError(URLError.cannotConnectToHost)).register()

    }
}
