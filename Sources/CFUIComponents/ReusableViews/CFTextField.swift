//
//  SRTextField.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 20/10/2023.
//

import Foundation
import SwiftUI

public struct CFTextField: View {
    private var placeholder: String
    @Binding private var text: String
    private var onCommit: (() -> Void)
    private var beginEditing: (() -> Void)?
    
    public init(text: Binding<String>,
                placeholder: String? = "",
                onCommit: @escaping (() -> Void) = { },
                beginEditing: (() -> Void)? = nil) {
        self._text = text
        self.placeholder = placeholder ?? text.wrappedValue
        self.onCommit = onCommit
        self.beginEditing = beginEditing
    }
    
    public var body: some View {
        TextField(placeholder, text: $text, onEditingChanged: { isChanged in
            if isChanged {
                beginEditing?()
            }
        }, onCommit: onCommit)
    }
}
