//
//  File.swift
//  
//
//  Created by Cuong Le on 9/17/22.
//

import Foundation
import FirebaseAnalytics

enum GooggleAnalyticsKey: String {
    case openCategory = "openCategory"
    case openExam = "openExam"
    case finishedExam = "finishedExam"
    case deleteData = "deleteData"
    case openBookMark = "openBookMark"
    case openWrongQuestion = "openWrongQuestion"
    case doShare = "doShare"
    case adloadedFailed = "adloadedFailed"
    case iapRestored = "iapRestored"
    case iapFailed = "iapFailed"
}


public class GAHelper {
    public static var shared: GAHelper = .init()
    
    private init() { }
    
    public func openCategory(catId: Int) {
        Analytics.logEvent(.openCategory, parameters: [
            AnalyticsParameterItemID: "Email"
        ])
    }
    
    public func openExam(examId: Int) {
        Analytics.logEvent(.openExam, parameters: [
            AnalyticsParameterItemID: examId
        ])
    }
    
    public func finishedExam() {
        Analytics.logEvent(.finishedExam, parameters: nil)
    }
    
    public func deleteData() {
        Analytics.logEvent(.deleteData, parameters: nil)
    }
    
    public func openBookMark() {
        Analytics.logEvent(.openBookMark, parameters: nil)
    }
    
    public func openWrongQuestion() {
        Analytics.logEvent(.openWrongQuestion, parameters: nil)
    }
    
    public func doShare() {
        Analytics.logEvent(.doShare, parameters: nil)
    }
    
    public func adloadedFailed(error: String) {
        Analytics.logEvent(.adloadedFailed, parameters: [
            "ads_eror": error
        ])
    }
    
    public func iapRestored() {
        Analytics.logEvent(.iapRestored, parameters: nil)
    }
    
    public func iapFailed(error: String) {
        Analytics.logEvent(.iapFailed, parameters: [
            "iap_eror": error
        ])
    }
}

extension Analytics {
    static func logEvent(_ event: GooggleAnalyticsKey, parameters: [String: Any]? = nil) {
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
}
