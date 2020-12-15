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
    var progressView: UIProgressView!
    
    override func loadView() {
        webView.navigationDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

