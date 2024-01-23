//
//  ActionSheet.swift
//  UICompanent
//
//  Created by CuongFinal on 22/4/21.
//  Copyright © All rights reserved.
//

import SwiftUI

public func actionSheetGenerator<T>(_ title: String,
                                    _ subTitle: String = "",
                                    items: [T],
                                    mapItem: @escaping (T) -> String,
                                    selectedItem: @escaping (T) -> Void) -> ActionSheet {
    var buttons: [ActionSheet.Button] = items.map { item in
        .default(Text(mapItem(item))) { selectedItem(item) }
    }
    buttons.append(.cancel())
    
    return ActionSheet(title: Text(title), message: Text(subTitle), buttons: buttons)
}

public func actionSheetGenerator(title: String,
                                 subTitle: String = "",
                                 confText: String = "btn_yes".localized,
                                 confirm: @escaping () -> Void) -> ActionSheet {
    return ActionSheet(title: Text(title),
                       message: Text(subTitle),
                       buttons: [ .default(Text(confText)) { confirm() }, .cancel()])
}
