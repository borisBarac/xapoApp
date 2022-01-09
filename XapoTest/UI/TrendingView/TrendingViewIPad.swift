//
//  ContentViewIpad.swift
//  XapoTest
//
//  Created by Boris Barac on 06.01.2022.
//

import SwiftUI
import UIKit

struct TrendingViewIPad: View {
    @State
    var model: TrendingModel

    var body: some View {
        NavigationView {
            MasterViewIpad(model: $model)
            DetailViewIpad(item: $model.detailViewitem)
        }
        .navigationViewStyle(.automatic)
        .accentColor(.white)

    }
}

struct MasterViewIpad: View {

    @Binding
    var model: TrendingModel

    var body: some View {
        ZStack {
            Color
                .xapobackgroundWithOpacity
                .edgesIgnoringSafeArea(.all)
            ProjectList(items: model.items,
                        cellTap: { item in
                model.detailViewitem = item
            })
                .navigationBarTitle("Trending")
        }.foregroundColor(.white)
    }
}

struct DetailViewIpad: View {
    @Binding
    var item: ProjectItem?

    var body: some View {
        ZStack {
            Color
                .xapobackgroundWithOpacity
                .edgesIgnoringSafeArea(.all)
            DetailView(item: $item)
        }.foregroundColor(.white)
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15.0, *)
struct TrendingViewIPad_Previews : PreviewProvider {
    static var previews: some View {
        TrendingViewIPad(model: TrendingModel(items: previewList))
            .previewInIpadPro11inch()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

#endif


