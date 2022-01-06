//
//  ContentViewIpad.swift
//  XapoTest
//
//  Created by Boris Barac on 06.01.2022.
//

import SwiftUI
import UIKit

struct TrendingViewIPad: View {
    var body: some View {
        NavigationView {
            MasterViewIpad()
            DetailViewIpad()
        }.accentColor(.white)

    }
}

struct MasterViewIpad: View {
    var body: some View {
        ZStack {
            Color
                .xapobackgroundWithOpacity
                .edgesIgnoringSafeArea(.all)
            ProjectList()
                .navigationBarTitle("Trending")
        }.foregroundColor(.white)
    }
}

struct DetailViewIpad: View {
    var body: some View {
        ZStack {
            Color
                .xapobackgroundWithOpacity
                .edgesIgnoringSafeArea(.all)
            DetailView()
        }.foregroundColor(.white)
    }
}


// MARK: - Previews

#if DEBUG
@available(iOS 15.0, *)
struct TrendingViewIPad_Previews : PreviewProvider {
    static var previews: some View {
        TrendingViewIPad()
            .previewInIpadPro11inch()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

#endif


