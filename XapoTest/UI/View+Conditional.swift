//
//  View+Conditional.swift
//  XapoTest
//
//  Created by Boris Barac on 05.01.2022.
//

import SwiftUI

extension View {

    @ViewBuilder
    func transformIf<ContentView: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> ContentView) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }

    @ViewBuilder
    func conditionallyShow(_ condition: @autoclosure () -> Bool) -> some View {
        transformIf(!condition()) { _ in EmptyView() }
    }
}
