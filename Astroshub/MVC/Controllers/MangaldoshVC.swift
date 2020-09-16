//
//  MangaldoshVC.swift
//  Astroshub
//
//  Created by Kriscent on 11/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import WebKit
class MangaldoshVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var buttonBack: UIButton!
    var isReport = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        var fileName = ""
        if isReport {
            self.buttonBack.setTitle("  Sample Report", for: .normal)
            fileName = "sample_reports"
        } else {
            fileName = "sample_query"
            self.buttonBack.setTitle("  Sample Query", for: .normal)
        }

       if let pdfUrl = Bundle.main.url(forResource: "\(fileName)", withExtension: "pdf", subdirectory: nil, localization: nil) {
           do {
               let data = try Data(contentsOf: pdfUrl)
            ActivityIndicator.shared.startLoading()
            webView.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: pdfUrl.deletingLastPathComponent())
           }
           catch {
               print("failed to open pdf")
           }
           return
       }
    }
    

     //****************************************************
     // MARK: - Custom Method
     //****************************************************
     
     
     

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
extension MangaldoshVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityIndicator.shared.stopLoader()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ActivityIndicator.shared.stopLoader()
    }
    
}
