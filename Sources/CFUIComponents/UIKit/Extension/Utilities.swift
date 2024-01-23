//
//  Utilities.swift
//  TeacherAssistant
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 26/08/2021.
//

import Foundation
import UIKit

public func localizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: key)
}

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public func onMainThread(_ execute: @escaping () -> Void) {
    DispatchQueue.main.async {() -> Void in
        execute()
    }
}

public func viewController(storyboard: String, id: String) -> UIViewController {
    let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: id)
}
