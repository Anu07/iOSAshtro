//
//  BabypdfviewVC.swift
//  Astroshub
//
//  Created by Kriscent on 25/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import WebKit

class BabypdfviewVC: UIViewController , WKNavigationDelegate {
    
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var btntop: UIButton!
    var value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wkWebView.navigationDelegate = self
        AutoBcmLoadingView.show("Loading......")
        switch value {
        case 0:
            self.btntop.setTitle("  Panchang", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/panchang.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        case 1:
            self.btntop.setTitle("  Kundali Matching", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/kundali_matching.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        case 2:
            self.btntop.setTitle("  Numerology", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/numerology.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        case 3:
            self.btntop.setTitle("  Baby Name", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/babyname.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        case 4:
            self.btntop.setTitle("  Festival", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/festivals.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        case 5:
            self.btntop.setTitle("  Daily Horoscope", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/daily_horoscope.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
            
        case 8:
            self.btntop.setTitle("  Chart Making", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/staging/chart_making.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        default:
            print("hello")
        }
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
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
