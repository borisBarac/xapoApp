//
//  _MainUseCaseTests.swift
//  XapoTestTests
//
//  Created by Boris Barac on 04.01.2022.
//

import XCTest
@testable import XapoTest

class _GetAndCashDataUseCase: XCTestCase {
    func testCashing() throws {
        let tag = "does not matter, it is mocked"
        let repository = InMemoryProjectRepository()
        let dataService = MockDataService()

        let useCase = GetAndCashDataUseCase(projectRepository: repository, dataService: dataService)
        let pub = useCase.with(tag: tag)
        let result = try awaitCompletion(of: pub)

        XCTAssertNotNil(result)
        XCTAssertGreaterThan(repository.listAll().count, 0, "Caching failed")
    }
}
