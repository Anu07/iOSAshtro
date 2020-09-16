//
//  RechargeVC.swift
//  Astroshub
//
//  Created by Kriscent on 28/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//



import UIKit

class RechargeVC: UIViewController {
    
    @IBOutlet weak var btn_recharge: ZFRippleButton!
    @IBOutlet weak var txt_Amount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let btnayer = CAGradientLayer()
        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: btn_recharge.frame.size.width, height: btn_recharge.frame.size.height)
        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        btn_recharge.layer.insertSublayer(btnayer, at: 1)
     // Do any additional setup after loading the view.
    }
    
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_rechargeamount() {
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id ,"amount":txt_Amount.text ?? "nil"] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("addCustomerWalletRecharge", params: setparameters as [String : AnyObject],headers: nil,
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
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_rechargeAction(_ sender: Any)
    {
        if Validate.shared.validateRecharge(vc: self)
        {
            self.func_rechargeamount()
        }
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
    
}
