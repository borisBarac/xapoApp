//
//  TestingView.swift
//  XapoTest
//
//  Created by Boris Barac on 06.01.2022.
//

import Foundation
import SwiftUI
import UIKit

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()

    }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

struct TestView: View {

    var body: some View {
        UITableView.appearance().backgroundColor = .clear

        return ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)
            List {
                ForEach(0 ..< 100) { index in
                    Text(String(index))
                        .listRowBackground(Color.red)
                }
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
