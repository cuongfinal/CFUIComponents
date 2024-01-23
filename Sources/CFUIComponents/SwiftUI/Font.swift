//
//  Font.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 20/10/2023.
//

import Foundation
import SwiftUI
import UIKit

public enum FontType: String {
    case poppins = "Poppins-"
}

public enum FontWeight: String {
    case semibold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    case bold = "Bold"
    case italic = "Italic"
}

 public enum PoppinsSize: CGFloat {
    case h1 = 28
    case h2 = 24
    case h3 = 20
    case h4 = 18
    case h5 = 17
    case h6 = 16
    case h7 = 15
    case h8 = 14
    case h9 = 13
    case h10 = 12
    case h11 = 10
     case h12 = 9
 }

public enum SfSize: CGFloat {
   case h1 = 36
   case h2 = 20
   case h3 = 18
   case h4 = 16
   case h5 = 15
   case h6 = 14
   case h7 = 12
   case h8 = 10
}

extension Font {
    private static func applyFont(name: String, size: CGFloat) -> Font {
        if #available(iOS 14.0, *) {
            return custom(name, fixedSize: size)
        } else {
            return custom(name, size: size)
        }
    }
    
    public static func poppins(weight: FontWeight = .bold, size: PoppinsSize) -> Font {
        return poppins(weight: weight, lenght: size.rawValue)
    }
    
    public static func poppins(weight: FontWeight = .bold, lenght: CGFloat) -> Font {
        let fontName: String = FontType.poppins.rawValue + weight.rawValue
        return self.applyFont(name: fontName, size: lenght)
    }
    
    public static func sfPro(weight: Font.Weight, size: SfSize) -> Font {
        return sfPro(weight: weight, lenght: size.rawValue)
    }
    
    public static func sfPro(weight: Font.Weight, lenght: CGFloat) -> Font {
        return .system(size: lenght, weight: weight)
    }
}
