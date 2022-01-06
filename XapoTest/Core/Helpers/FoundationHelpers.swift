//
//  FoundationHelpers.swift
//  XapoTest
//
//  Created by Boris Barac on 03.01.2022.
//

import Foundation
import UIKit

extension Int64 {
    var string: String {
        return String(self)
    }
}

extension UIDevice {
    static func isIpad() -> Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    static func isIphone() -> Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
