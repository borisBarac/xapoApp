//
//  TestingView.swift
//  XapoTest
//
//  Created by Boris Barac on 06.01.2022.
//

import Foundation
import SwiftUI
import UIKit



struct TestView: View {

    @State var showingDetails = true
    private var animation: Animation {
        .easeIn(duration: 0.3)
    }

    var body: some View {
        ZStack {

            Color.xapobackgroundWithOpacity.edgesIgnoringSafeArea(.all).zIndex(0)

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

struct TestView_Previews : PreviewProvider {
    static var previews: some View {
        TestView()
            .previewInIphone12()
    }
}
