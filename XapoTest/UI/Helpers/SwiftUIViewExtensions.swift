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

    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

extension Image {
    static var xapoLogo: Image {
        Image("xapo-logo")
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
        modifier(PreviewIn(device: "iPhone 12"))
    }

    func previewInIpadPro11inch() -> some View {
        modifier(PreviewIn(device: "iPad Pro (9.7-inch)"))
    }
}

struct PreviewIn: ViewModifier {

    let device: String

    func body(content: Content) -> some View {
        content
            .previewDevice(PreviewDevice(rawValue: device))
            .previewDisplayName(device)
    }
}
