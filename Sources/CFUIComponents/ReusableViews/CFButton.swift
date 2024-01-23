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
