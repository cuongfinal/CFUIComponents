//
//  CGFloat+Utilities.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 26/08/2021.
//

import UIKit

public extension CGFloat {
    public static func sizeRatioDeviceWidth(size: CGFloat) -> CGFloat {
        let roundedFloat = size * (UIScreen.main.bounds.size.width / MainSize.width.rawValue)
        return roundedFloat.roundTo(places: 1)
    }
    
    public static func sizeBasedOnPercentage(size: CGFloat, percent: CGFloat) -> CGFloat {
        return size * percent
    }
    
    public func roundTo(places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}

