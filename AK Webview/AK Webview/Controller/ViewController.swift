//
//  ViewController.swift
//  AK Webview
//
//  Created by Akshay Ramesh on 12/13/20.
//

import UIKit
import WebKit

class ViewController: UITableViewController {
    
    let websites = ["apple.com", "yahoo.com"]
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webViewController = storyboard?.instantiateViewController(identifier: "webDetailView") as! WebViewController
        webViewController.urlPassed = websites[indexPath.row]
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

