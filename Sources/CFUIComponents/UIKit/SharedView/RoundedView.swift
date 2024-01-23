//
//  RoundedView.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 26/08/2021.
//

import UIKit

@IBDesignable
internal class RoundedView: UIView {
    
    private var corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    
    @IBInspectable var topLeft: Bool = true {
        didSet {
            setCorner(newValue: topLeft, for: .layerMinXMinYCorner)
        }
    }
    
    @IBInspectable var topRight: Bool = true {
        didSet {
            setCorner(newValue: topRight, for: .layerMaxXMinYCorner)
        }
    }
    
    @IBInspectable var bottomLeft: Bool = true {
        didSet {
            setCorner(newValue: bottomLeft, for: .layerMinXMaxYCorner)
        }
    }
    
    @IBInspectable var bottomRight: Bool = true {
        didSet {
            setCorner(newValue: bottomRight, for: .layerMaxXMaxYCorner)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundCorners()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        roundCorners()
    }

    func setCorner(newValue: Bool, for corner: CACornerMask) {
        newValue ? addRectCorner(corner: corner) : removeRectCorner(corner: corner)
        setNeedsDisplay()
    }
    
    func addRectCorner(corner: CACornerMask) {
        if !corners.contains(corner) {
            corners.insert(corner)
        }
    }
    
    func removeRectCorner(corner: CACornerMask) {
        if corners.contains(corner) {
            corners.remove(corner)
        }
    }
    
    func roundCorners() {
        self.layer.maskedCorners = corners
    }
}
