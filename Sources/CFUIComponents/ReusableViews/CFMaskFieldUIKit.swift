//
//  EKMaskField.swift
//  UICompanent
//
//  Created by Cuong Le on 17/5/21.
//  Copyright © All rights reserved.
//
// swiftlint:disable line_length
// swiftlint:disable force_try

#if canImport(SwiftUI) && os(iOS)
import SwiftUI
import Combine

fileprivate extension UIView {
    func shake(duration: Double = 0.07, repeatCount: Float = 2, offset: CGFloat = 2) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - offset, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + offset, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

fileprivate extension UITextField {
    func moveCaret(to position: Int) {
        guard let caretPosition = self.position(from: self.beginningOfDocument, offset: position) else {
            return
        }
        self.selectedTextRange = self.textRange(from: caretPosition, to: caretPosition)
    }
}

public class CFMaskFieldUIKit: UITextField, UITextFieldDelegate {
    private var formatter: EKMaskFormatter?
    private var onCommit: (() -> Void)?

    // MARK: - Enums
    enum FieldEvent {
        case delete, insert
    }
        
    public init(onCommit:(() -> Void)? = nil) {
        self.onCommit = onCommit
        super.init(frame: .zero)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setFormatter(_ formatter: EKMaskFormatter) {
        guard self.formatter?.pattern != formatter.pattern || self.formatter?.mask != formatter.mask else {
            return
        }
        self.formatter = formatter
        if isFirstResponder {
            textFieldDidBeginEditing(self)
        }
    }
    
    private func detectTextFieldAction(range: NSRange, string: String) -> FieldEvent {
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        return isBackSpace == -92 ? .delete : .insert
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var formatter = self.formatter else { return true }
        
        do {
            var position: Int
            switch detectTextFieldAction(range: range, string: string) {
            case .insert:
                let tmpPosition = try formatter.insert(contentsOf: Array(string), from: range.location)
                position = tmpPosition.next ?? (tmpPosition.current + 1)
            case .delete:
                if formatter.status == .clear {
                    self.shake()
                    Haptic.notification(style: .error).impact()
                    return false
                }
                position = try formatter.delete(at: range.location).current
            }
            self.text = formatter.text
            sendActions(for: .editingChanged)
            textField.moveCaret(to: position)
        } catch EKFormatterThrows.canNotFindEditableNode {
            if formatter.status == .clear {
                self.text = nil
                sendActions(for: .editingChanged)
            } else {
                Haptic.notification(style: .error).impact()
            }
        } catch {}
        
        return false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if let caretPosition = formatter?.firstEditableNodeIndex {
            DispatchQueue.main.async {
                self.text = self.formatter?.text
                textField.moveCaret(to: caretPosition)
            }
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return super.resignFirstResponder()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if formatter?.status == .clear {
            self.text = nil
            sendActions(for: .editingChanged)
        }
        onCommit?()
    }
}
#endif
