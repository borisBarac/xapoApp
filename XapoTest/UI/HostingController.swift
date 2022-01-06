//
//  HostingController.swift
//  XapoTest
//
//  Created by Boris Barac on 06.01.2022.
//

import Foundation
import SwiftUI

class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
