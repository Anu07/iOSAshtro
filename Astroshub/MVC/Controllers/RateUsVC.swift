//
//  RateUsVC.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 25/05/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import Cosmos

class RateUsVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var viewStar: CosmosView!
    @IBOutlet weak var viewTxtView: UIView!
    @IBOutlet weak var txtView: UITextView!
    var astroId = ""
    var navigation: UINavigationController?
    var completionHandler : (()->())?
    var strForCloseDisable = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewTxtView.layer.cornerRadius = 5
        self.viewTxtView.layer.borderColor = UIColor.gray.cgColor
        self.viewTxtView.layer.borderWidth = 1
        self.txtView.text = "Enter Review"
        self.txtView.textColor = UIColor.lightGray
        self.txtView.delegate = self
        if strForCloseDisable == "Astro"{
            closeButton.isHidden = false
        } else{
            closeButton.isHidden = true
        }
    }
    
    func rateAstroApi() {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id,"review_for_id":astroId,"review_rating":"\(Int(viewStar.rating))","review_comment":"\(txtView.text ?? "")"]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.addReviews.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            self.dismiss(animated: true, completion:nil)
                                            if let handler = self.completionHandler {
                                                handler()
                                            }
                                        }
                                        else
                                        {
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
                                        
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    
    @IBAction func buttonSubmit(_ sender: Any) {
        if self.viewStar.rating <= 0 {
            CommenModel.showDefaltAlret(strMessage: "Please enter Rating", controller: self)
            return
        } else if self.txtView.text.count == 0 || self.txtView.textColor == UIColor.lightGray {
            CommenModel.showDefaltAlret(strMessage: "Please enter Review", controller: self)
            return
        }
        self.rateAstroApi()
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        if strForCloseDisable == "Astro"{
       self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Review"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
