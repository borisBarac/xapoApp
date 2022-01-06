//
//  HostingController.swift
//  XapoTest
//
//  Created by Boris Barac on 06.01.2022.
//

import Foundation
import SwiftUI

class StatusBarConfigurator: ObservableObject {
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            hostingController?.setNeedsStatusBarAppearanceUpdate()
        }
    }

    private var hostingController: UIViewController?

    func hostingController<T: View>(rootView: T) -> UIViewController {
        let hc = HostingController(rootView: rootView.environmentObject(self))
        hc.configurator = self
        hostingController = hc
        return hc
    }

    private class HostingController<T>: UIHostingController<T> where T: View {
        weak var configurator: StatusBarConfigurator!
        override var preferredStatusBarStyle: UIStatusBarStyle { configurator.statusBarStyle }
    }
}

class HostingController<T>: UIHostingController<T> where T: View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
