//
//  SwiftUIView.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 06/11/2023.
//

import SwiftUI

struct DarkModeViewModifier: ViewModifier {

    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("isHomeScreen") var isHomeScreen: Bool = false

    func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light) // tint on status bar
    }
}
