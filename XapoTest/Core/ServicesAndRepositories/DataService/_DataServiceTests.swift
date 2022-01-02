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

    var dataService: DataService!
    var mockError: Mock!

    override func setUp() {
        super.setUp()
        dataService = DataService(session: URLSession.shared, urlBuilder: UrlBuilder())
    }

    override class func tearDown() {
        super.tearDown()
    }

    func testNormalRequestV2() throws {
        let tag = "swift"
        let url = UrlBuilder().build(tag: tag)!
        Mock(url: url, dataType: .json, statusCode: 200, data: [
            .get : try! Data(contentsOf: MockedData.exampleJSON) // Data containing the JSON response
        ]).register()

        let pub = dataService.getTrending(tag: "swift")
        let result = try awaitCompletion(of: pub)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.first?.total_count, 253)
    }

    func testNoInternet() throws {
        let tag = "NoData"
        let url = UrlBuilder().build(tag: tag)!
        Mock(url: url, dataType: .json, statusCode: 500, data: [.get: Data()],
             requestError: URLError(URLError.cannotConnectToHost)).register()

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
                // passed :) XC needs XCTPass()
                break
            default:
                XCTFail("Wrong error type")
            }
        }
    }

}
