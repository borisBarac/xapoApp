//
//  ViewController.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import SwiftUI
import UIKit

struct TrendingView: View {

    // no need fo @state or something, view is gonna get recreated on changes anyway
    var items: [ProjectItem]
    @State var showingDetails: Bool = false

    private var animation: Animation {
        .easeIn(duration: 0.3)
    }

    var body: some View {
        ZStack {
            Color
                .xapobackgroundWithOpacity
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)

            if showingDetails == false {
                ProjectList()
                    .onTapGesture {
                        withAnimation(animation) {
                            showingDetails.toggle()
                        }
                    }
                    .zIndex(1)
            } else {
                DetailView()
                    .gesture(
                        DragGesture()
                            .onEnded { _ in
                                withAnimation(animation) {
                                    showingDetails.toggle()
                                }
                            }
                    )
                    .zIndex(2)
                    .transition(.stripes(number: 11))
            }
        }
    }

}

// MARK: - Previews

#if DEBUG

struct TrendingView_Previews : PreviewProvider {
    static var previews: some View {
        TrendingView(items: previewList)
            .previewInIphone12()
    }
}

#endif

