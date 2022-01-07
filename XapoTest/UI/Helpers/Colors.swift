//
//  Colors.swift
//  XapoTest
//
//  Created by Boris Barac on 05.01.2022.
//

import SwiftUI

extension Color {
    static let xapobackground = Color(red: 34/255, green: 42/255, blue: 56/255)
    static let xapobackgroundWithOpacity = Color.xapobackground.opacity(0.8)

    func uiColor() -> UIColor {

            if #available(iOS 14.0, *) {
                return UIColor(self)
            }

            let components = self.components()
            return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
        }

        private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

            let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
            var hexNumber: UInt64 = 0
            var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

            let result = scanner.scanHexInt64(&hexNumber)
            if result {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
            }
            return (r, g, b, a)
        }
}
