//
//  WebViewController.swift
//  AK Webview
//
//  Created by Akshay Ramesh on 12/19/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var urlPassed: String?
    let webView = WKWebView()
    var progressView: UIProgressView!
    let websites = ["apple.com", "yahoo.com"]
    
    override func loadView() {
        webView.navigationDelegate = self
        self.view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let backPage = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let frontPage = UIBarButtonItem(barButtonSystemItem: .play, target: webView, action: #selector(webView.goForward))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [backPage,spacer,frontPage,progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(open))
        let url = URL(string: "https://\(urlPassed!)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func open() {
        let actionController = UIAlertController(title: "Open Link", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            actionController.addAction(UIAlertAction(title: website, style: .default, handler: openTheLink))
        }
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        let alert = UIAlertController(title: "URL Blocked!", message: "\(url!) is blocked!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        decisionHandler(.cancel)
    }



}
