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
        super.viewDidLoad();
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(open))
        let url = URL(string: "https://www.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func open() {
        let actionController = UIAlertController(title: "Open Link", message: nil, preferredStyle: .actionSheet)
        actionController.addAction(UIAlertAction(title: "www.yahoo.com", style: .default, handler: openTheLink))
        actionController.addAction(UIAlertAction(title: "www.apple.com", style: .default, handler: openTheLink))
        actionController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(actionController, animated: true)
    }
    
    func openTheLink(action: UIAlertAction) {
        let url = URL(string: "https://\(action.title!)")!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

