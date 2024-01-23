//
//  SRSegmentView.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 25/10/2023.
//

import SwiftUI

public struct CFSegmentView: View {
    private let activeSegmentColor: Color
    private let activeTextColor: Color
    private let backgroundColor: Color
    private let inActiveTextColor: Color
    private let titleFont: Font
    private let cornerRadius: CGFloat
    private let pickerPadding: CGFloat
    private let animationDuration: Double = 0.1
    private let items: [String]
    
    @Binding private var selection: Int
    @State private var viewRects: [Int: CGRect] = [:]
    
    public init(items: [String],
                selection: Binding<Int>,
                activeSegmentColor: Color = .appColor(.navBg),
                activeTextColor: Color = .appColor(.navText),
                backgroundColor: Color = .white,
                inActiveTextColor: Color = .appColor(.navText),
                titleFont: Font = .poppins(weight: .medium, size: .h7),
                cornerRadius: CGFloat = 20,
                pickerPadding: CGFloat = 2) {
        self._selection = selection
        self.items = items
        self.activeSegmentColor = activeSegmentColor
        self.activeTextColor = activeTextColor
        self.backgroundColor = backgroundColor
        self.inActiveTextColor = inActiveTextColor
        self.titleFont = titleFont
        self.cornerRadius = cornerRadius
        self.pickerPadding = pickerPadding
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            self.activeIndicatorView
            HStack(spacing: 0) {
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.getTextView(for: index)
                        .geometryReader { proxy in
                            self.viewRects[index] = proxy.frame(in: .named("SRSegmentView"))
                        }
                }
            }
        }
        .coordinateSpace(name: "EKSegmentView")
        .padding(pickerPadding)
        .backgroundColor(backgroundColor)
        .infinityFrame()
        .cornerRadius(20)
    }

    private var activeIndicatorView: AnyView {
        guard let bounds = self.viewRects[selection] else {
            return EmptyView().asAnyView()
        }
        return RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundColor(activeSegmentColor)
            .size(width: bounds.width, height: bounds.height)
            .offset(x: bounds.origin.x-34, y: 0)
            .animation(Animation.linear(duration: animationDuration))
            .asAnyView()
    }
    
    private func getTextView(for index: Int) -> some View {
        let isSelected = self.selection == index
        return CFText(items[index], titleFont)
            .foregroundColorIf(isSelected, activeTextColor, inActiveTextColor)
            .lineLimit(1)
            .infinityFrame()
            .onTapGesture { self.selection = index }
    }
}

struct SRSegmentViewTest: View {
    @State var selection: Int = 0
    private let items: [String] = ["Info", "Reviews"]
    
    var body: some View {
        CFSegmentView(items: self.items, selection: self.$selection)
            .padding([.trailing, .leading], 33)
            .padding([.top, .bottom], 2)
            .frame(height: 55)
            .backgroundColor(Color.gray)
    }
}

//struct SRSegmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SRSegmentViewTest()
//    }
//}
