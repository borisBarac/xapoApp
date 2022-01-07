//
//  AsyncContentView.swift
//  XapoTest
//
//  Created by Boris Barac on 07.01.2022.
//

import Foundation
import SwiftUI
import Combine

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

struct AsyncContentView<Source: LoadableObject, Content: View>: View {

    var source: Source
    var content: ((Source.Output) -> Content)

    init(source: Source,
         @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .idle:
            Color.xapobackgroundWithOpacity
                .onAppear(perform: source.load)
        case .loading:
            LoadingView()
        case .failed(let error):
            VStack {
                Text("ERROR")
                Text(error.localizedDescription)
            }
        case .loaded(let output):
            content(output)
        }
    }
}

