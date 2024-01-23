//
//  Color+Extension.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 20/10/2023.
//

#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public enum AssetsColor: String {
    case darkGreySecondary = "darkGreySecondaryColor"
    case star = "starColor"
    case bg = "backgroundColor"
    case bgSecondary = "backgroundSecondaryColor"
    case bgSplash = "backgroundSplashColor"
    case discountBanner = "discountBannerColor"
    
    // MARK: - Text
    case textPrimary = "textPrimaryColor"
    case textSecondary = "textSecondaryColor"
    case textPriceColor = "priceColor"
    case textLink = "textLinkColor"
    
    // MARK: - Tabbar
    public enum TabbarColor: String {
        case bgTabBar = "backgroundTabBarColor"
        case activeTabBar = "activeTabBarColor"
        case tintTabBar = "tintTabBarColor"
    }
   
    // MARK: - Category
    public enum CategoryColor: String {
        case bgCategory = "backgroundCategoryColor"
        case textCategory = "textCategoryColor"
    }
    
    // MARK: - State
    public enum StateColor: String {
        case active = "activeColor"
    }
    
    // MARK: - Handling
    public enum HandlingColor: String {
        case error = "errorColor"
        case warning = "warningColor"
        case success = "successColor"
    }
    // MARK: - Button
    public enum ButtonColor: String {
        case btText = "textButtonColor"
        case btSecdText = "textSecondaryButtonColor"
        case bgButton = "backgroundButtonColor"
        case bgSecdButton = "backgroundSecondaryButtonColor"
        case bgBtnColor3 = "bgBtnColor3"
        case bgBtnColor4 = "bgBtnColor4"
        case bgBtnColor5 = "bgBtnColor5"
    }
    
    // MARK: - Navigation bar
    public enum NavigationBarColor: String {
        case navBg = "backgroundNabbarColor"
        case lightNavBg = "lightBackgroundNabbarColor"
        case navText = "textNavbarColor"
    }
    
    // MARK: - Status
    public enum StatusColor: String {
        case closeStatus = "errorColor"
        case preOrderStatus = "warningColor"
        case openStatus = "successColor"
    }
}

public extension Color {
    static func appColor(_ name: AssetsColor) -> Color {
        colorByString(name: name.rawValue)
    }
    static func appColor(_ name: AssetsColor.TabbarColor) -> Color {
        colorByString(name: name.rawValue)
    }
    static func appColor(_ name: AssetsColor.CategoryColor) -> Color {
        colorByString(name: name.rawValue)
    }
    static func appColor(_ name: AssetsColor.StateColor) -> Color {
        colorByString(name: name.rawValue)
    }
    static func appColor(_ name: AssetsColor.HandlingColor) -> Color {
        colorByString(name: name.rawValue)
    }
    static func appColor(_ name: AssetsColor.ButtonColor) -> Color {
        colorByString(name: name.rawValue)
    }
    static func appColor(_ name: AssetsColor.NavigationBarColor) -> Color {
        colorByString(name: name.rawValue)
    }
    static func appColor(_ name: AssetsColor.StatusColor) -> Color {
        colorByString(name: name.rawValue)
    }
    static var random: Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
    static func colorByString(name: String) -> Color {
        name.starts(with: "#") ? Color(hex: name) : Color(name)
    }
}

public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (1, 1, 1, 0)
        }
        
        self.init(.sRGB, red: Double(red) / 255, green: Double(green) / 255,
                  blue: Double(blue) / 255, opacity: Double(alpha) / 255)
    }
}

public extension Color {
    var uiColor: UIColor {
        if #available(iOS 14.0, *) {
            return UIColor(self)
        }
        
        let scanner = Scanner(string: description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        
        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            red = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
            green = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
            blue = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
            alpha = CGFloat(hexNumber & 0x000000FF) / 255
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

#endif
