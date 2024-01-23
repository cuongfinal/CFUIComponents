//
//  Keyboard+Observer.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 20/10/2023.
//

import Foundation
import Combine
import SwiftUI

public enum KeyboardState {
    case show(keyboardHeight: CGRect)
    case hide
    
    public var rect: CGRect {
        switch self {
        case let .show(rect): return rect
        case .hide: return .zero
        }
    }
    
    public var height: CGFloat {
        rect.height
    }
}

public extension Publishers {
    static var keyboardObserver: AnyPublisher<KeyboardState, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { KeyboardState.show(keyboardHeight: $0.keyboardFrame) }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in KeyboardState.hide }
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardFrame: CGRect {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) ?? .zero
    }
}

public extension UIResponder {
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }
    
    private static weak var _currentFirstResponder: UIResponder?
    
    @objc func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
    
    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}

/// Note that the `KeyboardAdaptive` modifier wraps your view in a `GeometryReader`,
/// which attempts to fill all the available space, potentially increasing content view size.
struct KeyboardAdaptive: ViewModifier {
    @State private var bottomOffset: CGFloat = 0
    private var bottomPadding: CGFloat
    
    init(bottomPadding: CGFloat) {
        self.bottomPadding = bottomPadding
    }
    
    func body(content: Content) -> some View {
        content
            .bottomPadding(bottomOffset)
            .animation(.easeOut(duration: 0.3))
            .onReceive(Publishers.keyboardObserver) { keyboardState in
                switch keyboardState {
                case .show(let rect):
                    guard let currentRespoderFrame = UIResponder.currentFirstResponder?.globalFrame else {
                        return
                    }
                    let offset = rect.minY - currentRespoderFrame.maxY - currentRespoderFrame.height
                    DispatchQueue.main.async {
                        self.bottomOffset = min(0, offset - bottomPadding)
                    }
                default:
                    DispatchQueue.main.async {
                        self.bottomOffset = 0
                    }
                }
            }
    }
}

public extension View {
    func keyboardAdaptive(_ bottomPadding: CGFloat = 20) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive(bottomPadding: bottomPadding))
    }
}
