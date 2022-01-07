//
//  TrendingViewModel.swift
//  XapoTest
//
//  Created by Boris Barac on 08.01.2022.
//

import Foundation
import Combine

class TrendingViewModel: LoadableObject {
    let trendingTag = "swift"

    @Published private(set) var state = LoadingState<[ProjectItem]>.idle
    private let useCaseLoader: GetAndCashDataUseCase
    private var trendingCancelable: AnyCancellable?

    init(useCaseLoader: GetAndCashDataUseCase) {
        self.useCaseLoader = useCaseLoader
    }

    func load() {
        state = .loading

        trendingCancelable = useCaseLoader.with(tag: trendingTag).sink { completion in
            switch completion {
            case .failure(let httpError):
                self.state = .failed(httpError)
            case .finished:
                break
            }
        } receiveValue: { items in
            self.state = .loaded(items)
        }
    }
}
