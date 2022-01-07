//
//  _TrendingViewModelTests.swift
//  XapoTestTests
//
//  Created by Boris Barac on 07.01.2022.
//

import XCTest
import Combine
@testable import XapoTest

class _TrendingViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    func testViewModelLoad() throws {
        let trendingViewModel = makeViewModelWith(dataService: MockDataService())
        let expectation = XCTestExpectation(description: "Get data expectation")

        trendingViewModel.$state.sink { completion in
            guard case .finished = completion else {
                XCTFail("Stream error")
                return
            }

        } receiveValue: { loadingState in
            switch loadingState {
            case .loaded(let items):
                XCTAssertGreaterThan(items.count, 0)

                // we need t fulfill here because the publisher stream is not gonna be over until object is alive
                expectation.fulfill()
            default:
                break
            }
        }.store(in: &cancellables)

        trendingViewModel.load()
        wait(for: [expectation], timeout: 0.5)
    }


    func testViewModelLoadError() throws {
        let httpError = HTTPError.serverDown
        let trendingViewModel = makeViewModelWith(dataService: MockDataServiceWithError(error: httpError))
        let expectation = XCTestExpectation(description: "Get data expectation")

        trendingViewModel.$state.sink { completion in
            guard case .finished = completion else {
                XCTFail("Stream error")
                return
            }

        } receiveValue: { loadingState in
            switch loadingState {
            case .failed(let error):
                let hError = error as? HTTPError
                XCTAssertNotNil(hError)
                XCTAssertEqual(hError, .serverDown)

                // we need t fulfill here because the publisher stream is not gonna be over until object is alive
                expectation.fulfill()
            default:
                break
            }
        }.store(in: &cancellables)

        trendingViewModel.load()
        wait(for: [expectation], timeout: 0.5)
    }

    private func makeViewModelWith(dataService: DataServiceProtocol) -> TrendingViewModel {
        let repository = InMemoryProjectRepository()
        let useCase = GetAndCashDataUseCase(projectRepository: repository, dataService: dataService)
        return TrendingViewModel(useCaseLoader: useCase)
    }

}
