//
//  GrowingArcIndicatorView.swift
//  UICompanent
//
//  Created by Cuong Le on 12/30/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI

struct GrowingArcIndicatorView: View {
    let color: Color
    let lineWidth: CGFloat
    @State private var animatableParameter: Double = 0
    let animation = Animation.easeIn(duration: 2).repeatForever(autoreverses: false)

    public var body: some View {
         GrowingArc(p: animatableParameter)
            .stroke(color, lineWidth: lineWidth)
            .animation(animation)
            .onAppear {
                animatableParameter = 1
            }
    }
}
// swiftlint:disable identifier_name
struct GrowingArc: Shape {

    var maxLength = 2 * Double.pi - 0.7
    var lag = 0.35
    var p: Double

    var animatableData: Double {
        get { return p }
        set { p = newValue }
    }

    func path(in rect: CGRect) -> Path {

        let h = p * 2
        var length = h * maxLength
        if h > 1 && h < lag + 1 {
            length = maxLength
        }
        if h > lag + 1 {
            let coeff = 1 / (1 - lag)
            let n = h - 1 - lag
            length = (1 - n * coeff) * maxLength
        }

        let first = Double.pi / 2
        let second = 4 * Double.pi - first

        var end = h * first
        if h > 1 {
            end = first + (h - 1) * second
        }

        let start = end + length

        var p = Path()
        p.addArc(center: CGPoint(x: rect.size.width / 2, y: rect.size.width / 2),
                 radius: rect.size.width / 2,
                 startAngle: Angle(radians: start),
                 endAngle: Angle(radians: end),
                 clockwise: true)
        return p
    }
}

#if DEBUG
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GrowingArcIndicatorView(color: .red, lineWidth: 4)
                .size(30)
        }
    }
}
#endif
#endif
