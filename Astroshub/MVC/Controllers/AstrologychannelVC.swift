//
//  AstrologychannelVC.swift
//  Astroshub
//
//  Created by Kriscent on 02/03/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import WebKit

class AstrologychannelVC: UIViewController , WKNavigationDelegate {

    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var viewWeb: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AutoBcmLoadingView.show("Loading......")
        self.wkWebView.navigationDelegate = self
        let url = URL (string: "https://www.youtube.com/channel/UCBiPxANFb4hVQE0lwtMeTAw/")
        let requestObj = URLRequest(url: url!)
        self.wkWebView.load(requestObj)
//        self.webView.loadRequest(requestObj)

        // Do any additional setup after loading the view.
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AutoBcmLoadingView.dismiss()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("started")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        AutoBcmLoadingView.dismiss()
    }
    

    //****************************************************
    // MARK: - API Methods
    //****************************************************
    
    
    

    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
       self.navigationController?.popViewController(animated: true)
    }
}
