//
//  Preview+Extensions.swift
//  UICompanent
//
//  Created by CuongFinal on 8/3/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public enum PreviewDeviceName: String, CaseIterable {
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneSE = "iPhone SE"
    case iPhoneX = "iPhone X"
    case iPhoneXS = "iPhone Xs"
    case iPhoneXSMax = "iPhone Xs Max"
    case iPhoneXR = "iPhone Xʀ"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
}
// MARK: - With device
public extension View {
    
    @inlinable
    func previewDevice(_ previewDeviceName: PreviewDeviceName) -> some View {
        previewDevice(previewDeviceName, displayName: previewDeviceName.rawValue)
    }
    
    @inlinable
    func previewDevice(_ previewDeviceName: PreviewDeviceName, displayName: String) -> some View {
        previewDevice(PreviewDevice(rawValue: previewDeviceName.rawValue))
            .previewDisplayName(displayName)
    }
}

// MARK: - Layout
public extension View {
    @inlinable
    func previewSizeThatFits(displayName: String = "") -> some View {
        previewLayout(.sizeThatFits)
            .previewDisplayName(displayName)
    }
    
    @inlinable
    func previewFixedSize(_ size: CGSize, displayName: String = "") -> some View {
        previewLayout(.fixed(width: size.width, height: size.height))
            .previewDisplayName(displayName)
    }
    
    @inlinable
    func previewFixedSize(_ width: CGFloat, _ height: CGFloat, displayName: String = "") -> some View {
        previewLayout(.fixed(width: width, height: height))
            .previewDisplayName(displayName)
    }
    
    @inlinable
    func previewFixedSize(_ lenght: CGFloat, displayName: String = "") -> some View {
        previewLayout(.fixed(width: lenght, height: lenght))
            .previewDisplayName(displayName)
    }
}

#endif
