//
//  EKSearchBar.swift
//  Example
//
//  Created by Cuong Le on 26/5/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public struct CFSearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    private let placeholder: String
    private let font: Font
    private let backgroundColor: Color
    private let textColor: Color
    private let cornerRadius: CGFloat
    private let searchIconColor: Color
    private let clearIconColor: Color
    
    public init(text: Binding<String>,
                  placeholder: String,
                  font: Font = .sfPro(weight: .semibold, size: .h4),
                  backgroundColor: Color = .clear,
                  textColor: Color = Color.black.opacity(0.4),
                  cornerRadius: CGFloat = 8,
                  searchIconColor: Color = .gray,
                  clearIconColor: Color = .gray) {
        self._text = text
        self.placeholder = placeholder
        self.font = font
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.cornerRadius = cornerRadius
        self.searchIconColor = searchIconColor
        self.clearIconColor = clearIconColor
    }
    
    public var body: some View {
        TextField(placeholder, text: $text)
            .font(font)
            .foregroundColor(textColor)
            .padding(7)
            .hPadding(30)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(searchIconColor)
                        .leftPadding(10)
                    Spacer()
                    if !text.isEmpty {
                        Button {
                            self.text = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(clearIconColor)
                                .rightPadding(10)
                        }
                    }
                }
            )
    }
}
#endif
