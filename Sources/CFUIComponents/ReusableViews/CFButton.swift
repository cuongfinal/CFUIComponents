//
//  SRButton.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 20/10/2023.
//

import Foundation
import SwiftUI

public struct CFButton<Label>: View where Label: View {
    let label: Label
    let action: () -> Void
    
    public init(label: Label, action: @escaping () -> Void) where Label == Text {
        self.label = label
        self.action = action
    }
    
    public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            label.infinityFrame().contentShape(Rectangle())
        }
    }
}


public extension View {
    func setCornerRadius(value: CGFloat? = nil) -> some View {
        self.cornerRadius(value ?? 12)
    }
    
    func defaultButton() -> some View {
        self.backgroundColor(.appColor(.bgButton)).foregroundColor(.appColor(.btText))
    }
    
    func grayButton() -> some View {
        self.backgroundColor(.appColor(.bgSecdButton)).foregroundColor(.appColor(.btSecdText))
    }
}

public struct CFButtonIcon: View {
    private let icon: String
    private let action: () -> Void
    private let iconSize: CGSize
    private let backgroundColor: Color
    
    public init(icon: String,
                iconSize: CGSize = .init(width: 28.36, height: 28.36),
                backgroundColor: Color = .green,
                action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
        self.iconSize = iconSize
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        Button(action: action, label: {
            ZStack {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize.width, height: iconSize.height, alignment: .center)
            }
            .infinityFrame()
            .backgroundColor(backgroundColor)
        })
            .cornerRadius(15)
    }
}
