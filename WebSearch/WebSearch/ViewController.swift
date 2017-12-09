//
//  ViewController.swift
//  WebSearch
//
//  Created by PinguMac on 2017/11/26.
//  Copyright © 2017年 PinguMac. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate, UISearchBarDelegate {

  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let urlString: String = "https://www.google.com.tw/"
    let url: URL = URL(string: urlString)!
    let urlRequest: URLRequest = URLRequest(url: url)
    webView.load(urlRequest)
    
    searchBar.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    
    var text = searchBar.text
    text = text!.replacingOccurrences(of: " ", with: "+")
    
    let url: URL = URL(string: "https://www.google.com.tw/search?q=\(text!)")!
    print(url)
    let urlRequest: URLRequest = URLRequest(url: url)
    webView.load(urlRequest)
  }
}

