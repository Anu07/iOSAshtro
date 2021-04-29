//
//  ForgetVC.swift
//  Astroshub
//
//  Created by Kriscent on 21/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class ForgetVC: UIViewController {
    
    @IBOutlet weak var img_Header: UIImageView!
    @IBOutlet weak var txt_otp: UITextField!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var view_otp: UIView!
    @IBOutlet weak var view_back: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view_back.layer.cornerRadius = 10
//        let btnlayer = CAGradientLayer()
        
//        btnlayer.frame = CGRect(x: 0.0, y: 0.0, width: btn_Submit.frame.size.width, height: btn_Submit.frame.size.height)
////        btnlayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
//        btnlayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        btnlayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//
//
//        btn_Submit.layer.addSublayer(btnlayer)
        
        
        //txt_otp.setIcon(UIImage(named: "ic_phone")!)
        
        self.view.layoutIfNeeded()
        
        
        view_otp.layer.cornerRadius = 10
        view_otp.layer.borderWidth = 1
        view_otp.layer.borderColor = (UIColor .darkGray).cgColor
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        // Do any additional setup after loading the view.
    }
    
    func forgetApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"email":txt_otp.text as Any] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("sendforgotPasswordOtp", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
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
    
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        
        if (sender.direction == .right)
        {
            print("Swipe Right")
            
            for controller in self.navigationController!.viewControllers as Array {
                //if #available(iOS 13.0, *) {
                    if controller.isKind(of: LoginVC.self) {
                        _ =  self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
               // }
                else {
                    // Fallback on earlier versions
                }
            }
            
            // show the view from the left side
        }
    }
    
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_SubmitAction(_ sender: Any)
    {
        if Validate.shared.validateforgetpassword(vc: self)
        {
            self.forgetApiCallMethods()
        }
        
    }
    
    
    
}
