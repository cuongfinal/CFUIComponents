//
//  EKButtonNew.swift
//  UICompanent
//
//  Created by Cuong Le on 12/30/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public enum CFButtonState: Equatable {
    case enabled, disabled //, applePay
    case loading(strokeColor: Color = .red, indicatorSize: CGFloat = 24)
}

public extension CFButton {
    func state(_ state: CFButtonState) -> some View {
        self.buttonStyle(CFButtonStateModifier(state: state))
    }
}

// MARK: - Modifiers
public struct CFButtonStateModifier: PrimitiveButtonStyle {
    var state: CFButtonState
    
    public init(state: CFButtonState) {
        self.state = state
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            switch state {
            case .enabled:
                configuration.label
                    .infinityFrame().contentShape(Rectangle())
                    .onTapGesture(perform: configuration.trigger)
            case .disabled:
                configuration.label.opacity(0.8)
            case .loading(let strokeColor, let indSize):
                GrowingArcIndicatorView(color: strokeColor, lineWidth: 3)
                    .size(indSize)
//            case .applePay: break
//                ApplePaymentButton().onTapGesture(perform: configuration.trigger)
            }
        }.infinityFrame().animation(.easeIn, value: state)
    }
}

#endif
