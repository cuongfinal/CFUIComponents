//
//  EKRadioButton.swift
//  SocialRepost
//
//  Created by Duong Tran Anh Thoai(ThoaiDTA) on 27/10/2023.
//

import SwiftUI

public struct CFRadioButton<Label>: View where Label: View {
    private let selectedColor: Color
    private let unSelected: Color
    @Binding private var isOn: Bool
    private var label: (Bool, AnyView) -> Label
    
    public init(_ isOn: Binding<Bool>,
                selectedColor: Color = Color.init(hex: "#a29bfe"),
                unSelected: Color = .init(hex: "DFE0E1"),
                @ViewBuilder label: @escaping (Bool, AnyView) -> Label) {
        _isOn = isOn
        self.selectedColor = selectedColor
        self.unSelected = unSelected
        self.label = label
    }
    
    public var body: some View {
        Button(action: {
            self.isOn.toggle()
        }, label: {
            label(isOn, radioBTView)
        })
    }
    
    private var radioBTView: AnyView {
        ZStack {
            if isOn {
                Circle().fill()
                    .foregroundColor(selectedColor)
                    .padding(3)
            }
            Circle()
                .strokeBorder(unSelected, lineWidth: 1)
        }.size(width: 17, height: 17)
        .asAnyView()
    }
}

//struct EKRadioButton_Previews: PreviewProvider {
////    @State var isOn =  true
////    static var previews: some View {
////        EKRadioButton(self.$isOn, label: {_,_ in
////            Text("Example")
////        })
////    }
//}
