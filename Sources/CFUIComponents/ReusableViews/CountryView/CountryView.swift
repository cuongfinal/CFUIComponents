//
//  CountryView.swift
//  UICompanent
//
//  Created by Cuong Le on 25/5/21.
//  Copyright © All rights reserved.
//
#if canImport(SwiftUI) && os(iOS)
import SwiftUI

public struct CountryView: View {
    @ObservedObject var viewModel: CountryViewModel
    @Environment(\.presentationMode) var presentationMode
    private var onSelect: ((Country) -> Void)?
    
    public init(viewModel: CountryViewModel, onSelect: ((Country) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onSelect = onSelect
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerView
                ForEach(viewModel.countriesDictionary, id: \.key) {  section in
                    LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                        Section(header: sectionHeader(title: section.key) ) {
                            ForEach(section.value, id: \.id) { row in
                                VStack(spacing: 0) {
                                    listCell(row: row)
                                    Divider()
                                }
                            }
                        }
                    }.hPadding(24).backgroundColor(.white)
                }
            }
        }.background(Color.appColor(.bg))
    }
    
    func sectionHeader(title: String) -> some View {
        CFText(title, .sfPro(weight: .bold, size: .h4), color: Color.black.opacity(0.4))
            .infinityFrame(.leading)
            .backgroundColor(.white)
            .height(40)
    }
    
    func listCell(row: Country) -> some View {
        HStack {
            Image(row.cc)
                .resizable()
                .size(width: 20, height: 15)
            CFText(row.localizeName, .sfPro(weight: .semibold, size: .h4), color: .init(hex: "#414e5b"))
            Spacer()
            CFText("+" + row.dialCode, .sfPro(weight: .semibold, size: .h4), color: .black)
        }.height(60).backgroundColor(.white)
            .onTapGesture {
                onSelect?(row)
                self.presentationMode.wrappedValue.dismiss()
            }
    }
    
    private var headerView: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2.5)
                .frame(35, 5)
                .foregroundColor(Color.black.opacity(0.4))
            CFText("countries".localized, .sfPro(weight: .bold, size: .h3), color: .black)
                .topPadding(8)
            Divider()
                .topPadding(16).bottomPadding(20)
            
            VStack {
                CFSearchBar(text: $viewModel.searchText, placeholder: "search_countries".localized)
                    .vPadding(5).hPadding(5)
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.1), lineWidth: 0.8)
            )
        }.vPadding(10).hPadding(25).backgroundColor(.white)
    }
}

#if DEBUG
struct CountryView_Previews: PreviewProvider {
    static let viewModel = CountryViewModel()
    static var previews: some View {
        CountryView(viewModel: viewModel) { selected in
            print(selected)
        }
    }
}
#endif
#endif
