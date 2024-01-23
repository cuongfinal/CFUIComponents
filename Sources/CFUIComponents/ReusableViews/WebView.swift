//
//  WebView.swift
//  SocialRepost
//
//  Created by Le Quang Tuan Cuong(CuongLQT) on 31/10/2023.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // 1
    let url: URL
    let htmlFileName: String?
    
    // 2
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    // 3
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let htmlFileName = htmlFileName {
            webView.load(htmlFileName)
        } else {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}


extension WKWebView {
    func load(_ htmlFileName: String) {
        guard !htmlFileName.isEmpty else {
            return  print("Empty File")
        }
        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
            return  print("Empty File path")
        }
        
        let url = URL(fileURLWithPath: filePath)
        
        do {
            let htmlString = try String(contentsOfFile: filePath, encoding: .utf8)
            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath))
        } catch {
            print("error here")
        }
    }
}
