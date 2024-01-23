//
//  TAStackView.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 10/09/2021.
//

import Foundation
import UIKit

internal class TAStackViewTapGesture: UITapGestureRecognizer {
    var viewIndex = 0
}

internal protocol TAStackViewDelegate: AnyObject {
    func didTapOnView(index: Int)
}

internal class TAStackView: UIStackView {
    
    weak var delegate: TAStackViewDelegate?
    
    func setUp(items: [UIView]) {
        removeAllArrangedSubviews()
        let widthView = items.count > 0 ? items.first!.frame.width : 0
        let heightView = items.count > 0 ? items.first!.frame.height : 0
        for item in items {
            item.widthAnchor.constraint(equalToConstant: widthView).isActive = true
            item.heightAnchor.constraint(equalToConstant: CGFloat.sizeRatioDeviceWidth(size: heightView)).isActive = true
            
            let tapGesture = TAStackViewTapGesture(target: self, action: #selector(handleTap(sender:)))
            tapGesture.viewIndex = items.firstIndex(of: item) ?? 0
            item.addGestureRecognizer(tapGesture)
            addArrangedSubview(item)
        }
    }
    
    @objc func handleTap(sender: TAStackViewTapGesture) {
        if let delegate = delegate {
            delegate.didTapOnView(index: sender.viewIndex)
        }
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
