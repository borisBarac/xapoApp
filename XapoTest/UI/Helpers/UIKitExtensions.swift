//
//  UIKitExtensions.swift
//  XapoTest
//
//  Created by Boris Barac on 08.01.2022.
//

import Foundation
import UIKit

extension UIWindow {
    func replaceRoot(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        self.switch(rootViewController: viewController, animated: true) {
            debugPrint("🔴 Root changed")
            completion?()
        }
    }
}
