//
//  DismissDialogUserInterface.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 03/06/2022.
//
import UIKit

protocol DismissDialogUserInterface {
    func didTapOnCloseButton()
}

extension DismissDialogUserInterface where Self: UIView {
    func didTapOnCloseButton() {
        self.parentViewController?.dismiss(animated: false, completion: nil)
    }
}
