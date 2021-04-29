//
//  ChangePassVC.swift
//  SearchDoctor
//
//  Created by Kriscent on 08/11/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController
class ChangePassVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_changepass: UITableView!
    var old = ""
    var new = ""
    var confirm = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    func textFieldDidBeginEditing(_ textField: UITextField)
    {    //delegate method
        
        
        if (textField.tag==1)
        {
            old=textField.text!
            
        }
        else if (textField.tag==2)
        {
            
            new=textField.text!
        }
        else if (textField.tag==3)
        {
            
            confirm=textField.text!
        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        
        if (textField.tag==1)
        {
            old=textField.text!
            
        }
        else if (textField.tag==2)
        {
            
            new=textField.text!
        }
        else if (textField.tag==3)
        {
            
            confirm=textField.text!
        }
        // return YES;
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
    // It is called each time user type a character by keyboard
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print(string)
        if (textField.tag==1)
        {
            old=textField.text!
            
        }
        else if (textField.tag==2)
        {
            
            new=textField.text!
        }
        else if (textField.tag==3)
        {
            
            confirm=textField.text!
        }
        return true
    }
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func ChangepassApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id,"email":user_Email,"old_password":old,"new_password":new,"c_password":confirm]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.CHANGE_PASS.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            let keyyyy = tempDict["user_api_key"] as! String
                                            UserDefaults.standard.setValue(keyyyy, forKey:"userKey")
                                            
                                            user_apikey = UserDefaults.standard.value(forKey: "userKey") as! String
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
    // MARK: - Tableview Method
    //****************************************************
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 771
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "changepasssCell", for: indexPath) as! changepasssCell
        cell_Add.btn_Signin.layer.cornerRadius = 10
        // cell_Add.btn_createaccount.layer.cornerRadius = 6
        
        cell_Add.view_changepass.layer.cornerRadius = 10
        cell_Add.view_old.layer.cornerRadius = 10
        cell_Add.view_old.layer.borderWidth = 1
        cell_Add.view_old.layer.borderColor = (UIColor .darkGray).cgColor
        
        cell_Add.view_newpassword.layer.cornerRadius = 10
        cell_Add.view_newpassword.layer.borderWidth = 1
        cell_Add.view_newpassword.layer.borderColor = (UIColor .darkGray).cgColor
        
        cell_Add.view_cnfpassword.layer.cornerRadius = 10
        cell_Add.view_cnfpassword.layer.borderWidth = 1
        cell_Add.view_cnfpassword.layer.borderColor = (UIColor .darkGray).cgColor
        
        cell_Add.btn_Signin.setTitle("Update", for: .normal)
        
        // cell_Add.btn_createaccount.tag = indexPath.row
        // cell_Add.btn_createaccount.addTarget(self, action: #selector(self.btn_CreateAction(_:)), for: .touchUpInside)
        
        cell_Add.btn_Signin.tag = indexPath.row
        cell_Add.btn_Signin.addTarget(self, action: #selector(self.btn_UpdateAction(_:)), for: .touchUpInside)
        
        cell_Add.txt_old.delegate = (self as UITextFieldDelegate)
        cell_Add.txt_newPassword.delegate = (self as UITextFieldDelegate)
        cell_Add.txt_cnfPassword.delegate = (self as UITextFieldDelegate)
        
        
//        let btnayer = CAGradientLayer()
//        
//        
//        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: cell_Add.btn_Signin.frame.size.width, height: cell_Add.btn_Signin.frame.size.height)
//        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
//        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        
//        cell_Add.btn_Signin.layer.insertSublayer(btnayer, at: 1)
        
        
        
        //cell_Add.txt_Email.setIcon(UIImage(named: "ic_phone")!)
        
        self.view.layoutIfNeeded()
        
        
        return cell_Add
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    @objc func btn_UpdateAction(_ sender: UIButton)
    {
        
        
        if Validate.shared.validateChangePassword(vc: self)
        {
            self.ChangepassApiCallMethods()
        }
        
        
    }
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
class changepasssCell: UITableViewCell {
    
    @IBOutlet weak var img_Header: UIImageView!
    @IBOutlet weak var txt_old: UITextField!
    @IBOutlet weak var txt_newPassword: UITextField!
    @IBOutlet weak var txt_cnfPassword: UITextField!
    @IBOutlet weak var btn_Signin: ZFRippleButton!
    @IBOutlet weak var view_changepass: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var view_old: UIView!
    @IBOutlet weak var view_newpassword: UIView!
    @IBOutlet weak var view_cnfpassword: UIView!
    
}
