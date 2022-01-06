//
//  View+Conditional.swift
//  XapoTest
//
//  Created by Boris Barac on 05.01.2022.
//

import SwiftUI

// MARK: - Conditional show

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

// MARK: - Preview helpers

extension View {
    var isRunningIsPreviewMode: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    var isNotRunningIsPreviewMode: Bool {
        !isRunningIsPreviewMode
    }

    func previewInIphone12() -> some View {
        modifier(PreviewInIphone12())
    }
}

struct PreviewInIphone12: ViewModifier {
    func body(content: Content) -> some View {
        content
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}