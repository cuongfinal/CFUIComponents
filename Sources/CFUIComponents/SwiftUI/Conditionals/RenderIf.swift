//
//  RenderIf.swift
//  UICompanent
//
//  Created by CuongFinal on 8/3/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI
// swiftlint:disable attributes
// swiftlint:disable line_length

public struct RenderIf<IfContent: View>: View {
    public let render: Bool
    public let ifContent: () -> IfContent

    public init(_ render: Bool, @ViewBuilder content ifContent: @escaping () -> IfContent) {
        self.render = render
        self.ifContent = ifContent
    }

    @inlinable
    public var body: some View {
        if render {
            return IfContent?.some(ifContent())
        } else {
            return IfContent?.none
        }
    }
    
    @inlinable
    public func elseRender<ElseContent: View>(@ViewBuilder content elseContent: @escaping () -> ElseContent) -> some View {
        RenderIfBuilder {
            if self.render {
                ifContent()
            } else {
                elseContent()
            }
        }
    }
}

public struct RenderIfBuilder<Content: View>: View {
    
    var content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
    }
}
#endif
