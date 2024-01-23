//
//  NavigationBarModifier.swift
//  UICompanent
//
//  Created by Order Tiger on 8/4/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI
import UIKit

public enum NavigationBarBG {
    case transparent
    case opaque
    case `default`
}

public struct NavigationBarModifier {
    public static func setNavigationBarStyle(backgroundColor: UIColor? = Color.appColor(\.bg).uiColor,
                                             titleColor: UIColor? = Color.appColor(\.navText).uiColor,
                                             tintColor: UIColor? = Color.appColor(\.navText).uiColor,
                                             bgType: NavigationBarBG = .default) {
        let appearance = UINavigationBarAppearance()
        switch bgType {
        case .transparent:
            appearance.configureWithTransparentBackground()
        case .opaque:
            appearance.configureWithOpaqueBackground()
        case .default:
            appearance.configureWithDefaultBackground()
        }
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = tintColor
    }
}

#endif
