//
//  Transitions.swift
//  XapoTest
//
//  Created by Boris Barac on 04.01.2022.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static func stripes(number: Int) -> AnyTransition {
        return AnyTransition.asymmetric(
            insertion: AnyTransition.modifier(
                active: ShapeClipModifier(shape: StripesShape(percentage: 1, stripes: number)),
                identity: ShapeClipModifier(shape: StripesShape(percentage: 0, stripes: number))),
            removal: AnyTransition.modifier(
                active: ShapeClipModifier(shape: StripesShape(percentage: 1, stripes: number)),
                identity: ShapeClipModifier(shape: StripesShape(percentage: 0, stripes: number))))
    }
}

struct ShapeClipModifier<S: Shape>: ViewModifier {
    let shape: S

    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

struct StripesShape: Shape {
    var percentage: CGFloat
    let stripes: Int

    var animatableData: CGFloat {
        get { percentage }
        set { percentage = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let stripeWidth = rect.width / CGFloat(stripes)
        for i in 0..<(stripes) {
            let j = CGFloat(i)
            path.addRect(CGRect(x: j * stripeWidth, y: 0, width: stripeWidth * (1-percentage), height: rect.height))
        }

        return path
    }
}
