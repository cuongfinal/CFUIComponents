//
//  BaseButton.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 30/08/2021.
//

import Foundation
import UIKit


@IBDesignable public class BaseButton: UIButton {
    @IBInspectable var bgColorNormal: UIColor = .PrimaryColorRed
    @IBInspectable var bgColorDisable: UIColor = .PrimaryColorRedLight

    public override var isEnabled: Bool {
        didSet {
            reloadBGColor()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        // for InterfaceBuilder
        setup()
    }
    
    private func setup() {
//        cornerRadius = -1
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .disabled)
        self.titleLabel?.font = AvenirNext.demiBold(size: 16)
        reloadBGColor()
    }
    
    private func reloadBGColor() {
        backgroundColor = isEnabled ? bgColorNormal : bgColorDisable
    }
}
