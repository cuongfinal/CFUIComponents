//
//  EKFieldViews.swift
//  UICompanent
//
//  Created by Cuong Le on 25/5/21.
//  Copyright © All rights reserved.
//
// swiftlint:disable superfluous_disable_command
#if canImport(SwiftUI) && os(iOS)
import SwiftUI
import Combine

// MARK: - EKSecureTextField
public struct CFSecureTextField: View {
    private var placeholder: String
    @Binding private var text: String
    @State private var isSecureTextEntry: Bool = true
    private var onCommit: (() -> Void)
    
    public init(text: Binding<String>,
                placeholder: String = "",
                onCommit: @escaping () -> Void = {}) {
        self._text = text
        self.placeholder = placeholder
        self.onCommit = onCommit
    }
    
    public var body: some View {
        HStack {
            if isSecureTextEntry {
                SecureField(placeholder, text: $text, onCommit: onCommit)
            } else {
                CFTextField(text: $text, placeholder: placeholder, onCommit: onCommit)
            }
            Spacer()
            Button(action: {
                withAnimation {
                    self.isSecureTextEntry.toggle()
                }
            }, label: {
                Image(systemName: self.isSecureTextEntry ? "eye.slash.fill" : "eye.fill" )
                    .size(20)
                    .foregroundColor(.init(hex: "C6C7CA"))
                    .rightPadding(8)
            })
        }
    }
}
// MARK: - EKTextField
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


// MARK: - EKMaskField
public class CFMaskFieldViewModel: ObservableObject {
    @Published public var formatter: EKMaskFormatter
    @Published public var text: String?
    
    public init(text: String? = nil, formatter: EKMaskFormatter) {
        self.text = text
        self.formatter = formatter
    }
}

public struct CFMaskField: UIViewRepresentable {
    @ObservedObject private var viewModel: CFMaskFieldViewModel
    private var textColor: UIColor
    private var placeholder: String?
    private var plecaholderColor: UIColor
    private var font: UIFont
    private var keyboardType: UIKeyboardType
    
    private var onCommit: (() -> Void)?
    private var textField: CFMaskFieldUIKit
    
    public init(viewModel: CFMaskFieldViewModel,
                placeholder: String? = nil,
                textColor: Color = .appColor(.textPrimary),
                plecaholderColor: Color = .init(hex: "C6C7CA"),
                font: UIFont = .boldSystemFont(ofSize: 15),
                keyboardType: UIKeyboardType = .default,
                onCommit:(() -> Void)? = nil) {
        self.viewModel = viewModel
        self.textColor = textColor.uiColor
        self.placeholder = placeholder
        self.plecaholderColor = plecaholderColor.uiColor
        self.font = font
        self.keyboardType = keyboardType
        self.onCommit = onCommit
        self.textField = CFMaskFieldUIKit(onCommit: onCommit)
    }
    
    public func makeUIView(context: Context) -> CFMaskFieldUIKit {
        textField.text = viewModel.text
        textField.font = font
        textField.textColor = textColor
        textField.keyboardType = keyboardType
        return textField
    }
    
    public func updateUIView(_ uiView: CFMaskFieldUIKit, context: Context) {
        uiView.setFormatter(viewModel.formatter)
        if let placeholder = self.placeholder {
            uiView.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                              attributes: [.foregroundColor: plecaholderColor])
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(textField: self.textField, text: self.$viewModel.text)
    }
    
    public class Coordinator: NSObject {
        @Binding var text: String?
        init(textField: UITextField, text: Binding<String?>) {
            self._text = text
            super.init()
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
        @objc
        func textFieldDidChange(_ textField: UITextField) {
            self.text = textField.text
        }
    }
}

// MARK: - EKPhoneNumberField
public class CFPhoneNumberViewModel: CFMaskFieldViewModel {
    @Published public var phoneNumberValidator: TextFieldValidator = .idle
    
    private(set) var selectedCountry: Country {
        didSet {
            do {
                self.formatter = try EKMaskFormatter(pattern: selectedCountry.pattern, mask: selectedCountry.mask)
            } catch {
                
                preconditionFailure("Failed to load config CountryCodes.json file")
            }
        }
    }
    
    let countryViewModel: CountryViewModel
    
    public init(relatedCountries: [String]?, defaultValue: String? = nil) {
        self.countryViewModel = .init()
        
        if let items = relatedCountries {
            countryViewModel.setRelattedCountries(relatedList: items)
        }
        
        var country: Country?
    
        if let defaultValue = defaultValue {
            country = countryViewModel.country(value: defaultValue)
        }
        
        /// In case default value has wrong format -> set country = current locale to prevent crash
        if country == nil { country = countryViewModel.localeCountry() }
        
        if let country = country {
            self.selectedCountry = country
            do {
                let formatter = try EKMaskFormatter(pattern: country.pattern, mask: country.mask)
                super.init(text: "", formatter: formatter)
                self.text = defaultValue
            } catch {
                preconditionFailure("Failed to load config CountryCodes.json file")
            }
        } else {
            preconditionFailure("Failed to load config CountryCodes.json file")
        }
    }
    
    func setCountry(_ country: Country) {
        self.selectedCountry = country
    }
    
    public func validateNumber() {
        switch formatter.status {
        case .clear: phoneNumberValidator = .error(msg: "enter_phone_number".localized)
        case .complete: phoneNumberValidator = .success
        case .incomplete: phoneNumberValidator = .error(msg: "fill_in_phone_number".localized)
        }
    }
}

public struct CFPhoneNumberField: View {
    @ObservedObject private var viewModel: CFPhoneNumberViewModel
    private var title: String
    private var placeholder: String?
    private var textColor: Color
    private var plecaholderColor: Color
    private var font: UIFont
    
    @State private var showingSheet = false
    
    public init(viewModel: CFPhoneNumberViewModel,
                title: String = "phone_number".localized,
                placeholder: String? = nil,
                textColor: Color = .appColor(.textPrimary),
                plecaholderColor: Color = .init(hex: "C6C7CA"),
                font: UIFont = .boldSystemFont(ofSize: 15)) {
        self.viewModel = viewModel
        self.title = title
        self.placeholder = placeholder
        self.textColor = textColor
        self.plecaholderColor = plecaholderColor
        self.font = font
    }
    
    public var body: some View {
        CFTextFieldContainer(title: title, validator: viewModel.phoneNumberValidator) {
            HStack(spacing: 11) {
                Image(viewModel.selectedCountry.cc)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0.0, y: 0.0)
                    .onTapGesture {
                        showingSheet.toggle()
                    }.sheet(isPresented: $showingSheet) {
                        CountryView(viewModel: viewModel.countryViewModel) { country in
                            viewModel.setCountry(country)
                        }
                    }
                CFMaskField(viewModel: viewModel,
                            placeholder: placeholder ?? viewModel.selectedCountry.mask,
                            textColor: textColor,
                            plecaholderColor: plecaholderColor,
                            font: font, keyboardType: .phonePad,
                            onCommit: viewModel.validateNumber)
            }
        }
    }
}


#endif
