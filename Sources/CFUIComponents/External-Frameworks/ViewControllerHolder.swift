//
//  ViewControllerHolder.swift
//  UICompanent
//
//  Created by CuongFinal on 27/7/21.
//  Copyright © All rights reserved.
//
// swiftlint:disable identifier_name
import UIKit
import SwiftUI

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

public extension EnvironmentValues {
    var rootVC: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

public extension UIViewController {
    func popUpView<Content: View>(draggable: Bool = false,
                                  @ViewBuilder content: @escaping (_ vc: PopUpViewController) -> Content) {
        let vc: PopUpViewController = PopUpViewControllerImpl(draggable: draggable)
        vc.modalPresentationStyle = .custom
        
        let head = UIHostingController(rootView: content(vc))
    
        head.view.backgroundColor = .clear
        
        vc.container.addSubview(head.view)
        head.view.translatesAutoresizingMaskIntoConstraints = false
        
        vc.topMargin = UIScreen.mainHeight - head.view.intrinsicContentSize.height

        self.present(vc, animated: false, completion: nil)
    }
    
    func alertInput(title: String,
                    message: String? = nil,
                    placeholder: String? = nil,
                    keyboardType: UIKeyboardType = .numberPad,
                    completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.keyboardType = keyboardType
            textField.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil)
        let apply = UIAlertAction(title: "apply".localized, style: .default) { [weak alert] (_) in
            completion(alert?.textFields?.first?.text ?? "")
        }
        alert.addAction(cancel)
        alert.addAction(apply)
        
        self.present(alert, animated: true, completion: nil)
    }
}
