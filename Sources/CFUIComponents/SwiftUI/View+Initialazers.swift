//
//  View+Initialazers.swift
//  UICompanent
//
//  Created by Order Tiger on 8/3/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI

// MARK: - EKText
@inlinable
public func EKText<S: StringProtocol>(_ content: S?,
                                      _ font: Font = .system(size: 15)) -> Text {
    Text(content ?? "")
        .apply(font)
}


@inlinable
public func EKText<S: StringProtocol>(_ content: S,
                                      _ font: Font = .system(size: 15)) -> Text {
    Text(content)
        .apply(font)
}

@inlinable
public func EKText<S: StringProtocol>(_ content: S,
                                      _ font: Font = .system(size: 15),
                                      color: Color? = .appColor(\.textPrimary)) -> Text {
    Text(content)
        .apply(font, color)
}

@inlinable
public func EKText<S: StringProtocol>(_ content: S,
                                      _ font: Font = .system(size: 15),
                                      weight: Font.Weight? = nil) -> Text {
    Text(content)
        .apply(font, nil, weight)
}

@inlinable
public func EKText<S: StringProtocol>(_ content: S,
                                      _ font: Font = .system(size: 15),
                                      color: Color? = .appColor(\.textPrimary),
                                      weight: Font.Weight? = nil) -> Text {
    Text(content)
        .apply(font, color, weight)
}

// MARK: - Attribute Text
public struct EKAttributesString: UIViewRepresentable {
    let attributeedString: NSMutableAttributedString
    
   public init(attribute: NSMutableAttributedString) {
        self.attributeedString = attribute
    }
    
    public func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.autoresizesSubviews = true
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return label
    }
    public func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributeedString
    }
}

#endif
