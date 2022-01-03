//
//  UIKitHelpers.swift
//  XapoTest
//
//  Created by Boris Barac on 03.01.2022.
//

import Foundation
import UIKit

extension UIWindow {
    func `switch`(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard animated else {
            self.rootViewController = rootViewController
            return
        }
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = rootViewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
            completion?()
        })
    }
}
