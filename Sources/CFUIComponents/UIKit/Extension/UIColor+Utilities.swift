//
//  UIColor+Utilities.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 26/08/2021.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, opacity: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: opacity)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff, opacity:alpha)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    static let BlueText: UIColor = UIColor(named: "BlueText")!
    static let BlueTextLight: UIColor = UIColor(named: "BlueTextLight")!
    static let GrayDark: UIColor = UIColor(named: "GrayDark")!
    static let GrayLight: UIColor = UIColor(named: "GrayLight")!
    static let GreenTea: UIColor = UIColor(named: "GreenTea")!
    static let GreenTeaLight: UIColor = UIColor(named: "GreenTeaLight")!
    static let PrimaryColorOrange: UIColor = UIColor(named: "PrimaryColorOrange")!
    static let PrimaryColorRed: UIColor = UIColor(named: "PrimaryColorRed")!
    static let PrimaryColorRedLight: UIColor = UIColor(named: "PrimaryColorRedLight")!
    static let PrimaryColorYellow: UIColor = UIColor(named: "PrimaryColorYellow")!
    static let PrimaryColorYellowLight: UIColor = UIColor(named: "PrimaryColorYellowLight")!
    static let Sky: UIColor = UIColor(named: "Sky")!
    static let SkyLight: UIColor = UIColor(named: "SkyLight")!
    static let TextBlack: UIColor = UIColor(named: "TextBlack")!
    static let PrimaryPurpleLinear: UIColor = UIColor(named: "PrimaryPurpleLinear")!
    static let SecondaryPurpleLinear: UIColor = UIColor(named: "SecondaryPurpleLinear")!
}
