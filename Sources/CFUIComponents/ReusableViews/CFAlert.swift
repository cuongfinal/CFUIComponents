//
//  SRAlert.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 24/10/2023.
//

import Foundation
import UIKit

public class CFAlert {
    public static func alert(title: String,
                             message: String? = nil,
                             sumbitTitle: String = "ok".localized,
                             submitAction: @escaping (UIAlertAction) -> Void) {
        
        if let vc = UIScreen.visibleViewController() {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: sumbitTitle, style: .default, handler: submitAction))
            
            DispatchQueue.main.async {
                vc.present(alert, animated: true)
            }
        }
    }
    
    public static func confirmAlert(title: String,
                                    message: String? = nil,
                                    cancelTitle: String = "cancel".localized,
                                    submitTitle: String = "ok".localized,
                                    cancelAction: @escaping (UIAlertAction) -> Void,
                                    submitAction: @escaping (UIAlertAction) -> Void) {
        
        if let vc = UIScreen.visibleViewController() {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction))
            alert.addAction(UIAlertAction(title: submitTitle, style: .destructive, handler: submitAction))
            
            DispatchQueue.main.async {
                vc.present(alert, animated: true)
            }
        }
    }
}
