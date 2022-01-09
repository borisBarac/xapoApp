//
//  TrendingContainer.swift
//  XapoTest
//
//  Created by Boris Barac on 07.01.2022.
//

import Foundation
import SwiftUI
import Combine

struct TrendingContainerView: View {
    @ObservedObject var viewModel = TrendingViewModel(useCaseLoader: GetAndCashDataUseCase(projectRepository: InMemoryProjectRepository(),
                                                                                           dataService: DataService(session: URLSession.shared,
                                                                                                                    urlBuilder: UrlBuilder())))

    var body: some View {
        AsyncContentView(source: viewModel) { list in
            if UIDevice.isIphone() {
                TrendingView(model: TrendingModel(items: list))
            } else {
                // setting the detailView to fist item so we do not empty sceen before we select a item in the MasterDetail view
                TrendingViewIPad(model: TrendingModel(items: list, detailViewitem: list.first))
            }
        }
    }

}
