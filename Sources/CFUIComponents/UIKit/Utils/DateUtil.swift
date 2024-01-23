//
//  DateUtil.swift
//  TeacherAssistant
//
//  Created by Duong Tran Anh Thoai(ThoaiDTA) on 09/07/2022.
//

import Foundation

public func convertString2Date(dateStr: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = COMMON_DATE_FORMAT
    
    do {
        return formatter.date(from: dateStr)
    } catch {
        print("error")
        return nil
    }
}

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

