//
//  UIFont+Utilities.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 26/08/2021.
//

import UIKit
import SwiftUI

public enum FontWeight: String {
    case semibold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    case bold = "Bold"
    case italic = "Italic"
}

public enum AvenirSize: CGFloat {
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

public enum FontType: String {
    case AvenirNext = "AvenirNext-"
    
    case defaultFontRegular        = "AvenirNext-Regular"
    case defaultFontItalic    = "AvenirNext-Italic"
    
    case defaultFontMedium      = "AvenirNext-Medium"
    case defaultFontMediumItalic      = "AvenirNext-MediumItalic"
    
    case defaultFontUltraLight     = "AvenirNext-UltraLight"
    case defaultFontUltraLightItalic     = "AvenirNext-UltraLightItalic"
    
    case defaultFontDemiBold      = "AvenirNext-DemiBold"
    case defaultFontDemiBoldItalic        = "AvenirNext-DemiBoldItalic"

    case defaultFontBold     = "AvenirNext-Bold"
    case defaultFontBoldItalic    = "AvenirNext-BoldItalic"
}

public enum AvenirNext {
    public static func regular(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontRegular.rawValue, size: size)
    }
    
    public static func italic(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontItalic.rawValue, size: size)
    }
    
    public static func medium(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontMedium.rawValue, size: size)
    }
    
    public static func mediumItalic(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontMediumItalic.rawValue, size: size)
    }
    
    public static func ultraLight(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontUltraLight.rawValue, size: size)
    }
    
    public static func ultraLightItalic(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontUltraLightItalic.rawValue, size: size)
    }
    
    public static func demiBold(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontDemiBold.rawValue, size: size)
    }
    
    public static func demiBoldItalic(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontDemiBoldItalic.rawValue, size: size)
    }
    
    public static func bold(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontBold.rawValue, size: size)
    }
    
    public static func boldItalic(size: CGFloat) -> UIFont {
        return UIFont.CustomFont(fontType: FontType.defaultFontBoldItalic.rawValue, size: size)
    }
}

extension UIFont {
    static func CustomFont(fontType: String, size: CGFloat) -> UIFont {
        if let font = UIFont.init(name: fontType, size: size) {
            return font
        }
        print("Can't load custom font")
        return UIFont.systemFont(ofSize: size)
    }
}

extension Font {
    private static func applyFont(name: String, size: CGFloat) -> Font {
        if #available(iOS 14.0, *) {
            return custom(name, fixedSize: size)
        } else {
            return custom(name, size: size)
        }
    }
    
    public static func avenir(weight: FontWeight = .bold, size: AvenirSize) -> Font {
        return avenir(weight: weight, lenght: size.rawValue)
    }
    
    public static func avenir(weight: FontWeight = .bold, lenght: CGFloat) -> Font {
        let fontName: String = FontType.AvenirNext.rawValue + weight.rawValue
        return self.applyFont(name: fontName, size: lenght)
    }
    
    public static func sfPro(weight: Font.Weight, size: SfSize) -> Font {
        return sfPro(weight: weight, lenght: size.rawValue)
    }
    
    public static func sfPro(weight: Font.Weight, lenght: CGFloat) -> Font {
        return .system(size: lenght, weight: weight)
    }
}
