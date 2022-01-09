//
//  ViewController.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import SwiftUI
import UIKit

struct TrendingModel {
    var items: [ProjectItem] {
        didSet {
            detailViewitem = items.first
        }
    }

    var detailViewitem: ProjectItem?
}

struct TrendingView: View {

    @State
    var model: TrendingModel

    @State
    var showingDetails: Bool = false

    private var animation: Animation {
        .easeIn(duration: 0.3)
    }

    private var dragGesture: _EndedGesture<DragGesture> {
        DragGesture()
            .onEnded { _ in
                close()
            }
    }

    var body: some View {
        ZStack {
            Color
                .xapobackgroundWithOpacity
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)

            if showingDetails == false {
                ProjectList(items: model.items,
                            cellTap: { item in
                    model.detailViewitem = item
                    withAnimation(animation) {
                        showingDetails.toggle()
                    }
                })
                    .zIndex(1)
            } else {
                DetailView(item: $model.detailViewitem, xButtonClick: {
                    close()
                })
                    .gesture(dragGesture)
                    .zIndex(2)
                    .transition(.stripes(number: 11))
            }
        }
    }

    func close() {
        withAnimation(animation) {
            showingDetails.toggle()
        }
    }

}

// MARK: - Previews

#if DEBUG

struct TrendingView_Previews : PreviewProvider {
    static var previews: some View {
        TrendingView(model: TrendingModel(items: previewList))
            .previewInIphone12()
    }
}

#endif

