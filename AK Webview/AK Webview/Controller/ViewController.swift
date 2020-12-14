//
//  ViewController.swift
//  AK Webview
//
//  Created by Akshay Ramesh on 12/13/20.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    let webView = WKWebView()
    
    override func loadView() {
        webView.navigationDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
            let url = URL(string: "https://www.google.com")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
    }
}

