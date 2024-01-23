//
//  View+Modifiers.swift
//  UICompanent
//
//  Created by CuongFinal on 8/3/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI
// swiftlint:disable identifier_name
// swiftlint:disable large_tuple
// swiftlint:disable line_length

// MARK: - Then
public extension View {
    @inlinable
    func then(_ body: (inout Self) -> Void) -> Self {
        var result = self
        body(&result)
        return result
    }
}

// MARK: - OnAppear delay
public extension View {
    @inlinable
    func onAppear(delay: TimeInterval, perform action: @escaping () -> Void) -> some View {
       return self.onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: action)
       }
    }
}

// MARK: - Type erasure
public extension View {
    func asAnyView() -> AnyView {
        AnyView(self)
    }
}

// MARK: - Foreground color
public extension View {
    @inlinable
    func foregroundColor(_ colorName: String) -> some View {
        foregroundColor(Color(colorName))
    }
}

// MARK: - Backgorund
public extension View {
    
    @inlinable
    func backgroundColor(_ color: Color, alignment: Alignment = .center) -> some View {
        background(color, alignment: alignment)
    }
    
    @inlinable
    func backgroundColor(_ colorName: String, alignment: Alignment = .center) -> some View {
        background(Color(colorName), alignment: alignment)
    }
}

// MARK: - Size
public extension View {
    @inlinable
    func size(_ lenght: CGFloat) -> some View {
        frame(width: lenght, height: lenght)
    }
    @inlinable
    func size(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        frame(width: width, height: height)
    }
    @inlinable
    func size(_ size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }
}

// MARK: - Frame
public extension View {
    // native type
    @inlinable
    func frame(_ size: CGSize, _ alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }
    
    @inlinable
    func width(_ width: CGFloat, _ alignment: Alignment = .center) -> some View {
        frame(width: width, alignment: alignment)
    }
    
    @inlinable
    func height(_ height: CGFloat, _ alignment: Alignment = .center) -> some View {
        frame(height: height, alignment: alignment)
    }
    
    @inlinable
    func frame(_ width: CGFloat, _ height: CGFloat, _ alignment: Alignment = .center) -> some View {
        frame(width: width, height: height, alignment: alignment)
    }
    
    @inlinable
    func frame(_ size: CGFloat, _ alignment: Alignment = .center) -> some View {
        frame(width: size, height: size, alignment: alignment)
    }
    
    // inginity
    @inlinable
    func infinityWidth(_ alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @inlinable
    func infinityHeight(_ alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @inlinable
    func infinityFrame(_ alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}

// MARK: - Offset
public extension View {
    @inlinable
    func xOffset(_ x: CGFloat) -> some View {
        offset(x: x)
    }
    
    @inlinable
    func yOffset(_ y: CGFloat) -> some View {
        offset(y: y)
    }
}

// MARK: - Padding
public extension View {
    
    @inlinable
    func hPadding() -> some View {
        padding(.horizontal)
    }
    
    @inlinable
    func vPadding() -> some View {
        padding(.vertical)
    }
    @inlinable
    func hPadding(_ horizontalPadding: CGFloat) -> some View {
        padding(.horizontal, horizontalPadding)
    }
    
    @inlinable
    func vPadding(_ verticalPadding: CGFloat) -> some View {
        padding(.vertical, verticalPadding)
    }
    
    @inlinable
    func leftPadding(_ leftPadding: CGFloat) -> some View {
        padding(.leading, leftPadding)
    }
    
    @inlinable
    func rightPadding(_ rightPadding: CGFloat) -> some View {
        padding(.trailing, rightPadding)
    }
    
    @inlinable
    func topPadding(_ topPadding: CGFloat) -> some View {
        padding(.top, topPadding)
    }
    
    @inlinable
    func bottomPadding(_ bottomPadding: CGFloat) -> some View {
        padding(.bottom, bottomPadding)
    }
}

// MARK: - Rotation
public extension View {
    
    @inlinable
    func rotate(_ angle: Angle, anchor: UnitPoint = .center) -> some View {
        rotationEffect(angle, anchor: anchor)
    }
    
    @inlinable
    func rotate3D(_ angle: Angle, _ axis: (x: CGFloat, y: CGFloat, z: CGFloat), anchor: UnitPoint = .center, anchorZ: CGFloat = 0, perspective: CGFloat = 1) -> some View {
        rotation3DEffect(angle, axis: axis, anchor: anchor, anchorZ: anchorZ, perspective: perspective)
    }
}

// MARK: - Scale
public extension View {
    @inlinable
    func scale(_ scaleFactor: CGFloat, anchor: UnitPoint = .center) -> some View {
        scaleEffect(scaleFactor, anchor: anchor)
    }
    
    @inlinable
    func scale(_ scaleSize: CGSize, anchor: UnitPoint = .center) -> some View {
        scaleEffect(scaleSize, anchor: anchor)
    }
    
    @inlinable
    func scale(_ scaleX: CGFloat, _ scaleY: CGFloat, anchor: UnitPoint = .center) -> some View {
        scaleEffect(x: scaleX, y: scaleY, anchor: anchor)
    }
    
    @inlinable
    func xScale(_ scaleX: CGFloat, anchor: UnitPoint = .center) -> some View {
        scaleEffect(x: scaleX, y: 1, anchor: anchor)
    }
    
    @inlinable
    func yScale(_ scaleY: CGFloat, anchor: UnitPoint = .center) -> some View {
        scaleEffect(x: 1, y: scaleY, anchor: anchor)
    }
}

// MARK: - Environment
public extension View {
    
    @inlinable
    func envDarkMode() -> some View {
        environment(\.colorScheme, .dark)
    }
    
    @inlinable
    func envLightMode() -> some View {
        environment(\.colorScheme, .light)
    }
    
    @inlinable
    func envColorScheme(_ scheme: ColorScheme) -> some View {
        environment(\.colorScheme, scheme)
    }
}

// MARK: - Geometry reader
public extension View {
    
    @inlinable
    func geometryReader(_ geoCallback: @escaping (GeometryProxy) -> Void) -> some View {
        geometryReader(id: 1, geoCallback)
    }
    
    @inlinable
    func geometryReader<T: Hashable>(id: T, _ geoCallback: @escaping (GeometryProxy) -> Void) -> some View {
        overlay(GeometryReader { (geo: GeometryProxy) in
            Color.clear.onAppear {
                geoCallback(geo)
            }
            .id(id)
        })
    }
}
#endif
