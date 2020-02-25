//
//  pdfViewController.swift
//  exameaze
//
//  Created by admin on 27/06/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit
import PDFKit
import WebKit


class pdfViewController: UIViewController,WKNavigationDelegate
{
    
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        loading.startAnimating()
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
        loading.hidesWhenStopped = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        
        
        let url : NSURL! = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/exameaze-a38b6.appspot.com/o/PDF%2FOS_PDF.pdf?alt=media&token=45d70367-fbe5-4bbc-a74a-b71916aca578")
        webView.load(NSURLRequest(url: url as URL) as URLRequest)
        
    }
    
    @IBAction func back(_ sender: UIButton)
    {
        
    }
    
    
}
