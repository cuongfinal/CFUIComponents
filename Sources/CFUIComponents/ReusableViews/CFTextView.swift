//
//  EKTextView.swift
//  
//
//  Created by Cuong Le on 20/2/21.
//

#if canImport(SwiftUI) && os(iOS)
import SwiftUI
// swiftlint:disable nesting
// swiftlint:disable line_length

/// Resizable TextView
public struct CFTextView: View {
    private var placeholder: String
    private var onCommit: (() -> Void)?
    private let font: UIFont
    private let textColor: Color
    private let placeholderColor: Color
    @Binding private var text: String
    private var minHeight: CGFloat
    
    @State private var viewHeight: CGFloat = 100
    @State private var shouldShowPlaceholder: Bool
    
    /// Creates resizable TextView
    /// - Parameters:
    ///   - placeholder: text of preview label
    ///   - text: A ``Binding`` to the variable containing the text to edit.
    ///   - minHeight: minimum height of text view
    ///   - font: font of text view
    ///   - textColor: color of textview texts
    ///   - placeholderColor: color of label
    ///   - onCommit: closure for done action
    public init(_ placeholder: String = "",
                text: Binding<String>,
                minHeight: CGFloat,
                font: UIFont = .systemFont(ofSize: 16),
                textColor: Color = .black,
                placeholderColor: Color = .init(.placeholderText),
                onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.minHeight = minHeight
        self.font = font
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        
        self.onCommit = onCommit
        self._shouldShowPlaceholder = .init(initialValue: text.wrappedValue.isEmpty)
    }
    public var body: some View {
        let actualHeight = minHeight > viewHeight ? minHeight : viewHeight
        return Representable(font: font,
                             textColor: textColor,
                             text: $text,
                             calculatedHeight: $viewHeight,
                             shouldShowPlaceholder: $shouldShowPlaceholder,
                             onDone: onCommit)
            .frame(minHeight: minHeight)
            .height(actualHeight)
            .background(placeholderView, alignment: .topLeading)
    }
    
    var placeholderView: some View {
        RenderIf(shouldShowPlaceholder) {
            CFText(placeholder, .init(self.font), color: placeholderColor)
                .topPadding(8)
                .leftPadding(4)
        }
    }
}

extension CFTextView {
    private struct Representable: UIViewRepresentable {
        let font: UIFont
        let textColor: Color
        @Binding var text: String
        @Binding var calculatedHeight: CGFloat
        @Binding var shouldShowPlaceholder: Bool
        
        var onDone: (() -> Void)?
        
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.delegate = context.coordinator
            textView.isEditable = true
            textView.isSelectable = true
            textView.isUserInteractionEnabled = true
            textView.isScrollEnabled = false
            textView.backgroundColor = UIColor.clear
            textView.textColor = textColor.uiColor
            textView.font = font
            if onDone != nil {
                textView.returnKeyType = .done
            }
            textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            return textView
        }
        
        func updateUIView(_ textView: UITextView, context _: Context) {
            self.recalculateHeight(field: textView, result: $calculatedHeight)
        }
        
        private func recalculateHeight(field: UIView, result: Binding<CGFloat>) {
            let newSize = field.sizeThatFits(CGSize(width: field.frame.size.width, height: .greatestFiniteMagnitude))
            if result.wrappedValue != newSize.height {
                DispatchQueue.main.async {
                    result.wrappedValue = newSize.height
                }
            }
        }
        
        func makeCoordinator() -> Coordinator {
            .init(self)
        }
        
        final class Coordinator: NSObject, UITextViewDelegate {
            private let parent: Representable
            
            public init(_ parent: Representable) {
                self.parent = parent
            }
            public func textViewDidChange(_ textView: UITextView) {
                parent.shouldShowPlaceholder = textView.text.isEmpty
                parent.text = textView.text
            }
            func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
                if let onDone = parent.onDone, text == "\n" {
                    textView.resignFirstResponder()
                    onDone()
                    return false
                }
                return true
            }
        }
    }
}
#endif
