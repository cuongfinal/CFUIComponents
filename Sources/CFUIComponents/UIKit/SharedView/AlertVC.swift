//
//  AlertVC.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 20/06/2022.
//

import Foundation
import UIKit

public  typealias CompletedClosure = (() -> Void)?
public  typealias ConfirmClosure = (() -> Void)?

public  class AlertVC: UIAlertController {
    static let shared = AlertVC()
  
    func warningAlert(_ title: String?, message: String?, cancelTitle: String, completedClosure: CompletedClosure) -> UIAlertController {
        let alertVC = UIAlertController.init(title: title,
                                             message: message,
                                             preferredStyle: .alert)
        let titleFont = [NSAttributedString.Key.font: AvenirNext.demiBold(size: 16)]
        let messageFont = [NSAttributedString.Key.font: AvenirNext.regular(size: 13), .foregroundColor: UIColor.TextBlack]
        if let title = title, let message = message {
            let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
            let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
            alertVC.setValue(titleAttrString, forKey: "attributedTitle")
            alertVC.setValue(messageAttrString, forKey: "attributedMessage")
        }
        let action = UIAlertAction(title: cancelTitle, style: .default) { (_) in
            completedClosure?()
        }
        alertVC.addAction(action)
        alertVC.view.tintColor = UIColor.TextBlack
        return alertVC
    }
    
    func confirmAlert(_ title: String?, message: String?, cancelTitle: String, confirmTitle: String, completedClosure: CompletedClosure, confirmClosure: ConfirmClosure) -> UIAlertController {
        let alertVC = UIAlertController.init(title: title,
                                             message: message,
                                             preferredStyle: .alert)
        let titleFont = [NSAttributedString.Key.font: AvenirNext.demiBold(size: 16)]
        let messageFont = [NSAttributedString.Key.font: AvenirNext.regular(size: 13), .foregroundColor: UIColor.TextBlack]
        if let title = title, let message = message {
            let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
            let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
            alertVC.setValue(titleAttrString, forKey: "attributedTitle")
            alertVC.setValue(messageAttrString, forKey: "attributedMessage")
        }
        let actionCancel = UIAlertAction(title: cancelTitle, style: .default) { (_) in
            completedClosure?()
        }
        actionCancel.setValue(UIColor.TextBlack, forKey: "titleTextColor")
        let actionConfirm = UIAlertAction(title: confirmTitle, style: .default) { (_) in
            confirmClosure?()
        }
        alertVC.addAction(actionCancel)
        alertVC.addAction(actionConfirm)
        alertVC.view.tintColor = UIColor.PrimaryColorRed
        return alertVC
    }
}
