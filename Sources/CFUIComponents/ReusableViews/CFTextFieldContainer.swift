//
//  EKTextFieldContainer.swift
//  UICompanent
//
//  Created by Cuong Le on 25/5/21.
//  Copyright © All rights reserved.
//

#if canImport(SwiftUI) && os(iOS)
import SwiftUI
import Combine

public protocol CFFieldDesignable {
    init ()
    var font: Font { get }
    var color: Color { get }
    var titleFont: Font { get }
    var titleColor: Color { get }
    var errorFont: Font { get }
    var errorColor: Color { get }
}

public struct CFFieldDesignableDefault: CFFieldDesignable {
    public init() {}
    public var font: Font { .system(size: 17) }
    public var color: Color { .appColor(.textPrimary) }
    public var titleFont: Font { .system(size: 15) }
    public var titleColor: Color { .init(hex: "373737") }
    public var errorFont: Font { .system(size: 12) }
    public var errorColor: Color { .init(hex: "EA4335") }
}

public enum TextFieldValidator: Equatable {
    case success
    case error(msg: String)
    case idle
}

public extension Publisher {
    func validate(using validator: @escaping (Output) -> TextFieldValidator) -> Publishers.Map<Self, TextFieldValidator> {
        map { output in
            return validator(output)
        }
    }
}

public typealias RexValidator = (rex: String.ValidationType, rexErrorText: String)

public func validator(validator: inout TextFieldValidator,
                      value: String,
                      _ rexValidator: RexValidator? = nil,
                      emptyTitle: String = "cant_empty".localized) {
    
    if value.isEmpty {
        validator = .error(msg: emptyTitle)
        return
    }
    if let rexValue = rexValidator {
        validator = value.isValid(rexValue.rex) ? .success : .error(msg: rexValue.rexErrorText)
        return
    }
    validator = .success
}

public struct CFTextFieldContainer<Content: View>: View {
    private let title: String
    private var validtionChecker: TextFieldValidator
    private let content: Content
    private let fieldDesign: CFFieldDesignable
    
    public init(title: String,
                validator: TextFieldValidator,
                @ViewBuilder content: @escaping () -> Content,
                fieldDesing: CFFieldDesignable = CFFieldDesignableDefault()) {
        self.title = title
        self.validtionChecker = validator
        self.content = content()
        self.fieldDesign = fieldDesing
    }
    
    public var body: some View {
        let validatorIsValid = (validtionChecker == .success || validtionChecker == .idle)
        return VStack(alignment: .leading, spacing: 0) {
            CFText(validatorIsValid ? title : "*\(title)", fieldDesign.titleFont)
                .opacityIf(validatorIsValid, 0.4)
                .foregroundColor(validatorIsValid ? fieldDesign.titleColor : fieldDesign.errorColor)
            content
                .foregroundColor(fieldDesign.color)
                .font(fieldDesign.font)
                .height(36)
            Divider()
            if case .error(let msg) = validtionChecker {
                CFText(msg, fieldDesign.errorFont, color: fieldDesign.errorColor)
                    .topPadding(4)
            }
        }.height(72).animation(.default)
    }
}

#endif
