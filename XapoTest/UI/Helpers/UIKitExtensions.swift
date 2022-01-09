//
//  UIKitExtensions.swift
//  XapoTest
//
//  Created by Boris Barac on 08.01.2022.
//

import Foundation
import UIKit
import SwiftUI
import SafariServices

extension UIWindow {
    func replaceRoot(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        self.switch(rootViewController: viewController, animated: true) {
            debugPrint("🔴 Root changed")
            completion?()
        }
    }
}


struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}
