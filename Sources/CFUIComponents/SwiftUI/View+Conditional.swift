//
//  View+ConditionalModifiers.swift
//  UICompanent
//
//  Created by CuongFinal on 8/3/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI
// swiftlint:disable large_tuple identifier_name multiline_parameters line_length

// MARK: - Frame
public extension View {
    @inlinable
    func frameIf(_ condition: Bool, _ width: CGFloat, _ height: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: condition ? width : nil, height: condition ? height : nil, alignment: alignment)
    }
    
    @inlinable
    func frameIfNot(_ condition: Bool, _ width: CGFloat, _ height: CGFloat, alignment: Alignment = .center) -> some View {
        frameIf(!condition, width, height, alignment: alignment)
    }
    
    @inlinable
    func frameIf(_ condition: Bool, _ size: CGFloat, alignment: Alignment = .center) -> some View {
        frameIf(condition, size, size, alignment: alignment)
    }
    
    @inlinable
    func frameIfNot(_ condition: Bool, _ size: CGFloat, alignment: Alignment = .center) -> some View {
        frameIf(!condition, size, alignment: alignment)
    }
    
    @inlinable
    func frameIf(_ condition: Bool, _ size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: condition ? size.width : nil, height: condition ? size.height : nil, alignment: alignment)
    }
    
    @inlinable
    func frameIfNot(_ condition: Bool, _ size: CGSize, alignment: Alignment = .center) -> some View {
        frameIf(!condition, size, alignment: alignment)
    }
    
    @inlinable
    func widthIf(_ condition: Bool, _ width: CGFloat, alignment: Alignment = .center) -> some View {
        frame(width: condition ? width : nil, alignment: alignment)
    }
    
    @inlinable
    func widthIfNot(_ condition: Bool, _ width: CGFloat, alignment: Alignment = .center) -> some View {
        widthIf(!condition, width, alignment: alignment)
    }
    
    @inlinable
    func heightIf(_ condition: Bool, _ height: CGFloat, alignment: Alignment = .center) -> some View {
        frame(height: condition ? height : nil, alignment: alignment)
    }
    
    @inlinable
    func heightIfNot(_ condition: Bool, _ height: CGFloat, alignment: Alignment = .center) -> some View {
        heightIf(!condition, height, alignment: alignment)
    }
}

// MARK: - Corner radius
public extension View {
    @inlinable
    func cornerRadiusIf(_ condition: Bool, _ radius: CGFloat, antialiased: Bool = true) -> some View {
        cornerRadius(condition ? radius : 0, antialiased: antialiased)
    }
    
    @inlinable
    func cornerRadiusIfNot(_ condition: Bool, _ radius: CGFloat, antialiased: Bool = true) -> some View {
        cornerRadiusIf(!condition, radius, antialiased: antialiased)
    }
}

// MARK: - Padding
public extension View {
    @inlinable
    func paddingIf(_ condition: Bool, _ edge: Edge.Set = .all, _ lenght: CGFloat) -> some View {
        padding(condition ? edge : [], lenght)
    }
    
    @inlinable
    func paddingIfNot(_ condition: Bool, _ edge: Edge.Set = .all, _ lenght: CGFloat) -> some View {
        paddingIf(!condition, edge, lenght)
    }
}

// MARK: - Offset
public extension View {
    @inlinable
    func offsetIf(_ condition: Bool, _ x: CGFloat, _ y: CGFloat) -> some View {
        offset(x: condition ? x : 0, y: condition ? y : 0)
    }
    
    @inlinable
    func offsetIfNot(_ condition: Bool, _ x: CGFloat, _ y: CGFloat) -> some View {
        offsetIf(!condition, x, y)
    }
    
    @inlinable
    func xOffsetIf(_ condition: Bool, _ xOffset: CGFloat) -> some View {
        self.xOffset(condition ? xOffset : 0)
    }
    
    @inlinable
    func xOffsetIfNot(_ condition: Bool, _ xOffset: CGFloat) -> some View {
        xOffsetIf(!condition, xOffset)
    }
    
    @inlinable
    func yOffsetIf(_ condition: Bool, _ yOffset: CGFloat) -> some View {
        self.yOffset(condition ? yOffset : 0)
    }
    
    @inlinable
    func yOffsetIfNot(_ condition: Bool, _ yOffset: CGFloat) -> some View {
        yOffsetIf(!condition, yOffset)
    }
}

// MARK: - Opacity
public extension View {
    @inlinable
    func opacityIf(_ condition: Bool, _ opacity: Double) -> some View {
        self.opacity(condition ? opacity : 1)
    }
    
    @inlinable
    func opacityIfNot(_ condition: Bool, _ opacity: Double) -> some View {
        opacityIf(!condition, opacity)
    }
}

// MARK: - Hue rotation
public extension View {
    @inlinable
    func hueRotationIf(_ condition: Bool, _ angle: Angle) -> some View {
        hueRotation(condition ? angle : Angle(degrees: 0))
    }
    
    @inlinable
    func hueRotationIfNot(_ condition: Bool, _ angle: Angle) -> some View {
        hueRotationIf(!condition, angle)
    }
}

// MARK: - Foreground
public extension View {
    @inlinable
    func foregroundColorIf(_ condition: Bool, _ color: Color, _ clearColor: Color? = nil) -> some View {
        //TODO: it now not work on iOS 16???, re-check after OS final release
        foregroundColor(condition ? color : clearColor)
    }
    
    @inlinable
    func foregroundColorIfNot(_ condition: Bool, _ color: Color) -> some View {
        foregroundColorIf(!condition, color)
    }
}

// MARK: - Background
public extension View {
    
    @inlinable
    func backgroundIf<T: View>(_ condition: Bool, _ content: T, alignment: Alignment = .center) -> some View {
        RenderIf(condition) {
            self.background(content, alignment: alignment)
        }.elseRender {
            self
        }
    }
    
    @inlinable
    func backgroundColorIf(_ condition: Bool, _ color: Color, _ clearColor: Color? = nil, alignment: Alignment = .center) -> some View {
        self.background(condition ? color : clearColor, alignment: alignment)
    }
    
    @inlinable
    func backgroundColorIfNot(_ condition: Bool, _ color: Color, alignment: Alignment = .center) -> some View {
        backgroundIf(!condition, color, alignment: alignment)
    }
}

// MARK: - Overlay
public extension View {
    @inlinable
    func overlayIf<T: View>(_ condition: Bool, _ content: T, alignment: Alignment = .center) -> some View {
        RenderIf(condition) {
            self.overlay(content, alignment: alignment)
        }.elseRender {
            self
        }
    }
    
    @inlinable
    func overlayIfNot<T: View>(_ condition: Bool, _ content: T, alignment: Alignment = .center) -> some View {
        overlayIf(!condition, content, alignment: alignment)
    }
    
    @inlinable
    func overlayColorIf(_ condition: Bool, _ color: Color, alignment: Alignment = .center) -> some View {
        overlayIf(condition, color, alignment: alignment)
    }
    
    @inlinable
    func overlayColorIfNot(_ condition: Bool, _ color: Color, alignment: Alignment = .center) -> some View {
        overlayIf(!condition, color, alignment: alignment)
    }
}

// MARK: - Border
public extension View {
    @inlinable
    func borderIf<SS: ShapeStyle>(_ condition: Bool, _ shapeStyle: SS) -> some View {
        RenderIf(condition) {
            self.border(shapeStyle)
        }.elseRender {
            self
        }
    }
    
    @inlinable
    func borderIfNot<SS: ShapeStyle>(_ condition: Bool, _ shapeStyle: SS) -> some View {
        borderIf(!condition, shapeStyle)
    }

    @inlinable
    func borderColorIf(_ condition: Bool, _ color: Color, _ width: CGFloat = 0) -> some View {
        border(condition ? color : Color.clear, width: width)
    }
    
    @inlinable
    func borderColorIfNot(_ condition: Bool, _ color: Color, _ width: CGFloat = 0) -> some View {
        borderColorIf(!condition, color)
    }
}

// MARK: - Rotation
public extension View {
    @inlinable
    func rotateIf(_ condition: Bool, _ rotation: Angle, anchor: UnitPoint = .center) -> some View {
        rotate(condition ? rotation : Angle(degrees: 0), anchor: anchor)
    }
    
    @inlinable
    func rotateIfNot(_ condition: Bool, _ rotation: Angle, anchor: UnitPoint = .center) -> some View {
        rotateIf(!condition, rotation, anchor: anchor)
    }
    
    @inlinable
    func rotate3DIf(_ condition: Bool, _ rotation: Angle, axis: (x: CGFloat, y: CGFloat, z: CGFloat),
                    anchor: UnitPoint = .center, anchorZ: CGFloat = 0, perspective: CGFloat = 1) -> some View {
        rotate3D(condition ? rotation : Angle(degrees: 0), axis, anchor: anchor, anchorZ: anchorZ)
    }
    
    @inlinable
    func rotate3DIfNot(_ condition: Bool, _ rotation: Angle, axis: (x: CGFloat, y: CGFloat, z: CGFloat),
                       anchor: UnitPoint = .center, anchorZ: CGFloat = 0, perspective: CGFloat = 1) -> some View {
        rotate3DIf(!condition, rotation, axis: axis, anchor: anchor, anchorZ: anchorZ)
    }
}

// MARK: - Scale
public extension View {
    @inlinable
    func scaleIf(_ condition: Bool, _ scaleX: CGFloat, _ scaleY: CGFloat, anchor: UnitPoint = .center) -> some View {
        scaleEffect(condition ? CGSize(width: scaleX, height: scaleY) : CGSize(width: 1, height: 1), anchor: anchor)
    }
    
    @inlinable
    func scaleIfNot(_ condition: Bool, _ scaleX: CGFloat, _ scaleY: CGFloat, anchor: UnitPoint = .center) -> some View {
        scaleIf(!condition, scaleX, scaleY, anchor: anchor)
    }
    
    @inlinable
    func xScaleIf(_ condition: Bool, _ scaleX: CGFloat, anchor: UnitPoint = .center) -> some View {
        xScale(condition ? scaleX : 1, anchor: anchor)
    }
    
    @inlinable
    func xScaleIfNot(_ condition: Bool, _ scaleX: CGFloat, anchor: UnitPoint = .center) -> some View {
        xScaleIf(!condition, scaleX, anchor: anchor)
    }
    
    @inlinable
    func yScaleIf(_ condition: Bool, _ scaleY: CGFloat, anchor: UnitPoint = .center) -> some View {
        yScale(condition ? scaleY : 1, anchor: anchor)
    }

    @inlinable
    func yScaleIfNot(_ condition: Bool, _ scaleY: CGFloat, anchor: UnitPoint = .center) -> some View {
        yScaleIf(!condition, scaleY, anchor: anchor)
    }
}

// MARK: - Animation
public extension View {
    @inlinable
    func animationIf(_ condition: Bool, _ theAnimation: Animation? = .default) -> some View {
        transaction {
            if condition {
                $0.animation = theAnimation
            }
        }
    }
    
    @inlinable
    func animationIfNot(_ condition: Bool, _ theAnimation: Animation? = .default) -> some View {
        animationIf(!condition, theAnimation)
    }
}

// MARK: - Disabled
public extension View {
    @inlinable
    func disabledIf(_ condition: Bool) -> some View {
        disabled(condition)
    }
    
    @inlinable
    func disabledIfNot(_ condition: Bool) -> some View {
        disabledIf(!condition)
    }
}

#endif
