//
//  WebViewVC.swift
//  
//
//  Created by Duong Tran Anh Thoai(ThoaiDTA) on 01/09/2022.
//

import UIKit
import WebKit

public class WebViewVC: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    public var fileName: String?
    
    public init() {
        super.init(nibName: "WebViewVC", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "html") else {
            return
        }
        let request = URLRequest.init(url: url)
        self.webview.load(request)
    }
}
