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
        
        //        https://astroshubh.in/babyname.php
        //        https://astroshubh.in/fastivel.php
        //        https://astroshubh.in/kundali_matching.php
        //        https://astroshubh.in/panchang.php
        //        https://astroshubh.in/tearms.php
        //        https://astroshubh.in/numerology.php
        self.wkWebView.navigationDelegate = self
        AutoBcmLoadingView.show("Loading......")
        switch value {
        case 0:
            self.btntop.setTitle("  Panchang", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/panchang.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
//        case 1:
//            self.btntop.setTitle("  Kundali Matching", for: .normal)
//            let url = URL (string: "https://www.astroshubh.in/kundali_matching.php")
//            let requestObj = URLRequest(url: url!)
//            self.wkWebView.load(requestObj)
        case 1:
            self.btntop.setTitle("  Numerology", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/numerology.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        case 2:
            self.btntop.setTitle("  Baby Name", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/babyname.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        case 3:
            self.btntop.setTitle("  Festival", for: .normal)
            let url = URL (string: "https://www.astroshubh.in/fastivel.php")
            let requestObj = URLRequest(url: url!)
            self.wkWebView.load(requestObj)
        default:
            print("hello")
        }
//
//        if FreeservicesPdf == "numerology"
//        {
//            let headername = "  Numerology"
//            btntop.setTitle(headername,for: .normal)
//            //            let pdfLoc = NSURL(fileURLWithPath:Bundle.main.path(forResource: "OUR FREE SERVICES ASTROSHUBH DATA", ofType:"pdf")!)
//            //            let request = NSURLRequest(url: pdfLoc as URL);
//            //            self.webView.loadRequest(request as URLRequest);
//
//            let url = URL (string: "http://kriscenttechnohub.com/demo/astroshubh/admin/numerology.php")
//            let requestObj = URLRequest(url: url!)
//            self.wkWebView.load(requestObj)
//        }
//        if FreeservicesPdf == "baby"
//        {
//            let headername = "  Baby Name Analysis"
//            btntop.setTitle(headername,for: .normal)
//            //            let pdfLoc = NSURL(fileURLWithPath:Bundle.main.path(forResource: "Baby name by nakshtra", ofType:"pdf")!)
//            //            let request = NSURLRequest(url: pdfLoc as URL);
//            //            self.webView.loadRequest(request as URLRequest);
//
//            let url = URL (string: "http://kriscenttechnohub.com/demo/astroshubh/admin/babyname.php")
//            let requestObj = URLRequest(url: url!)
//            self.wkWebView.load(requestObj)
//
//
//
//        }
//        if FreeservicesPdf == "festival"
//        {
//            let headername = "  Festival 2020"
//            btntop.setTitle(headername,for: .normal)
//            //            let pdfLoc = NSURL(fileURLWithPath:Bundle.main.path(forResource: "FESTIVALS Services", ofType:"pdf")!)
//            //            let request = NSURLRequest(url: pdfLoc as URL);
//            //            self.webView.loadRequest(request as URLRequest);
//
//            let url = URL (string: "http://kriscenttechnohub.com/demo/astroshubh/admin/fastivel.php")
//            let requestObj = URLRequest(url: url!)
//            self.wkWebView.load(requestObj)
//        }
        
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
    
    
    
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
}
