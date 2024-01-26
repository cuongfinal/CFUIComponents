//
//  Haptic.swift
//  UICompanent
//
//  Created by Cuong Le on 17/5/21.
//  Copyright © All rights reserved.
//

import UIKit

public enum Haptic {
    case impact(style: UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(style: UINotificationFeedbackGenerator.FeedbackType)
    case selection
    
    func impact() {
        switch self {
        case .impact(style: let style):
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
        case .notification(style: let style):
            let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
            notificationFeedbackGenerator.notificationOccurred(style)
        default:
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
}
