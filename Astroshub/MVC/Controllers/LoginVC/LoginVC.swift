//
//  LoginVC.swift
//  BloomKart
//
//  Created by Kriscent on 24/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController
import FirebaseAuth
import Firebase
import Crashlytics
import Firebase
import Crashlytics
import ADCountryPicker
import FBSDKCoreKit
class LoginVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet var tbl_login: UITableView!
    var Email = ""
    var Password = ""
    var City = ""
    var countryCode = "+1"
    var visibilityonoff = ""
    var isChecked: Bool = false
    
    private var viewModels: [DPArrowMenuViewModel] = []
    var NameArray = NSArray()
    var arr1 = [[String:Any]]()
    var returnResponse = [[String:Any]]()
    var arrstatecity = [[String:Any]]()
    
    
    
    var msglength: NSNumber = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCountryCode()
        self.navigationController?.isNavigationBarHidden = true
        City = userCountrycode
        tbl_login.reloadData()
        self.scrollToBottom()
        AppEvents.logEvent(AppEvents.Name(rawValue: "Login"))

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
    }
    
    
    func validateMethod () -> Bool
    {
        guard  !(self.Email).isBlank  else{
            CommenModel.showDefaltAlret(strMessage: "Please enter Mobile No.", controller: self)
            return false
        }
        guard  !(self.Password).isBlank  else{
            CommenModel.showDefaltAlret(strMessage: "Please enter Password", controller: self)
            return false
        }
        return  true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {    //delegate method
        if (textField.tag==1)
        {
            Email=textField.text!
        }
        else if (textField.tag==2)
        {
            Password=textField.text!
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if (textField.tag==1)
        {
            Email=textField.text!
        }
        else if (textField.tag==2)
        {
            Password=textField.text!
        }
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
            Email=textField.text!
        }
        else if (textField.tag==2)
        {
            Password=textField.text!
        }
        return true
    }
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    
    
    func getCountryCode() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("country_code", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            if let arrtimeslot = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrstatecity = arrtimeslot
                                            }
                                            print("arrTimeList is:- ",self.arrstatecity)
                                            self.getCountryCodeId()
                                            for j in 0..<self.arrstatecity.count
                                            {
                                            
                                                let dict2 = self.arrstatecity[j] as NSDictionary
                                                
                                                 let phonecode1 = dict2["phonecode"] as! String
        
                                                 if phonecode1 == LocationCountrycode
                                                 {
                                                    userCountrycode = phonecode1
                                                    //self.SignupCountrycode = userCountrycode
                                                    LocationCountrycodeID = dict2["id"] as! String
                                                    return
                                                 }
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

    func getCountryCodeId() {
        if self.arrstatecity.count > 0 {
            if let number = Int(countryCode.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                for value in self.arrstatecity {
                    if let phoneCode = value["phonecode"] as? String {
                        if String(number) == phoneCode {
                            print(countryCode, number, phoneCode)
                            countrycodeID = value["id"] as? String ?? ""
                            return
                        }
                    }
                }
            }
        }
    }

    
    func loginApiCallMethods()
    {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let defaults = UserDefaults.standard
        let fcm = defaults.string(forKey: "FcmToken")
        print(fcm ?? "")
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"phone":Email,"password":Password,"country_id":countrycodeID,"user_token":fcm ?? ""]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        
        AppHelperModel.requestPOSTURL(MethodName.CUSTOMERLOGIN.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            str_ContNo_CounCode = "+91"+self.Email
                                            dictloginnn = [
                                                "userName":self.Email,
                                                "userPWD":self.Password
                                            ]
                                            dictloginData = (tempDict["data"] as! NSDictionary) as! [String : Any]
                                            let dict_Data = tempDict["data"] as! NSDictionary
                                            print("dict_Data is:-",dict_Data)
                                            let keyyyy = tempDict["user_api_key"] as! String
                                            UserDefaults.standard.setValue(keyyyy, forKey:"userKey")
                                            
                                            //user_apikey = dict_Data["user_api_key"] as! String
                                            
                                            let data_Dict_IsUserData = NSKeyedArchiver.archivedData(withRootObject: dict_Data)
                                            UserDefaults.standard.setValue(data_Dict_IsUserData, forKey: "isUserData")
                                            PhoneAuthProvider.provider().verifyPhoneNumber(str_ContNo_CounCode, uiDelegate: nil) { (verificationID, error) in
                                                
                                                
                                                print(str_ContNo_CounCode)
                                                
                                                if  error != nil
                                                {
                                                    print(NSLocalizedDescriptionKey)
                                                    print(NSLocalizedFailureReasonErrorKey)
                                                    print("error: \(String(describing: error?.localizedDescription))")
                                                    CommenModel.showDefaltAlret(strMessage:String(describing: error?.localizedDescription), controller: self)
                                                    
                                                    //SKToast.show(withMessage: "Invalid phone number")
                                                    
                                                }
                                                else
                                                {
                                                    let defaults = UserDefaults.standard
                                                    defaults.set(verificationID, forKey: "authVID")
                                                    print(verificationID ?? "nil")
                                                    
                                                    OTPPhnNumber = self.Email
                                                    
                                                    let EnterCodeViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterCode_ViewController") as? EnterCode_ViewController
                                                    
                                                    EnterCodeViewController?.countryCode = self.countryCode
                                                    self.navigationController?.pushViewController(EnterCodeViewController!, animated: true)
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                            
                                        }else
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
    
    @objc func countrycodeAction() {
        let picker = ADCountryPicker()
        picker.delegate = self
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    @objc func signupAction(_ sender: UIButton)
    {
        let Registrationotp = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationotpVC")
        self.navigationController?.pushViewController(Registrationotp!, animated: true)
    }
    
    @objc func guestLogin() {
        //self.navigationController?.popViewController(animated: true)
        let months = DateFormatter().monthSymbols
        let days = DateFormatter().weekdaySymbols
        
        let mainVC = SJSwiftSideMenuController()
        
        let sideVC_L : SideMenuController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_L.menuItems = months as NSArray? ?? NSArray()
        
        let sideVC_R : SideMenuController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_R.menuItems = days as NSArray? ?? NSArray()
        
        
        let DashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        SJSwiftSideMenuController.setUpNavigation(rootController: DashboardVC, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)
        
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        
        SJSwiftSideMenuController.enableDimbackground = true
        SJSwiftSideMenuController.leftMenuWidth = 340
        
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
    @objc func btn_SigninAction(_ sender: UIButton)
    {
        self.view.endEditing(true)
        if Validate.shared.validateLogin(vc: self)
        {
            ActivityIndicator.shared.startLoading()
            str_ContNo_CounCode = self.countryCode + self.Email//"+91"+self.Email
            PhoneAuthProvider.provider().verifyPhoneNumber(str_ContNo_CounCode, uiDelegate: nil) { (verificationID, error) in
                ActivityIndicator.shared.stopLoader()
                print(str_ContNo_CounCode)
                if  error != nil
                {
                    print(NSLocalizedDescriptionKey)
                    print(NSLocalizedFailureReasonErrorKey)
                    print("error: \(String(describing: error?.localizedDescription))")
                    CommenModel.showDefaltAlret(strMessage:String(describing: error?.localizedDescription), controller: self)
                    
                    //SKToast.show(withMessage: "Invalid phone number")
                }
                else
                {
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID, forKey: "authVID")
                    print(verificationID ?? "nil")
                    OTPPhnNumber = self.Email
                    let EnterCodeViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterCode_ViewController") as? EnterCode_ViewController
                    EnterCodeViewController?.countryCode = self.countryCode
                    self.navigationController?.pushViewController(EnterCodeViewController!, animated: true)
                }
            }
        }
    }
    
    @objc func btn_visibilityAction(_ sender: UIButton){
        if isChecked == true{
            isChecked = false
            visibilityonoff = ""
            tbl_login.reloadData()
        }else{
            isChecked = true
            visibilityonoff = "shiptick"
            tbl_login.reloadData()
            
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tbl_login.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 700
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! LoginCell
        cell_Add.btn_Signin.layer.cornerRadius = 30
        cell_Add.view_login.layer.cornerRadius = 10
//        cell_Add.view_email.layer.cornerRadius = 10
        cell_Add.view_email.layer.borderWidth = 1
        cell_Add.view_email.layer.borderColor = (UIColor .black).cgColor
        cell_Add.btn_Signin.setTitle("Login", for: .normal)
        cell_Add.buttonCountryCode.addTarget(self, action: #selector(countrycodeAction), for: .touchUpInside)
        cell_Add.txtCountryCode.text = self.countryCode
        cell_Add.btn_Signin.tag = indexPath.row
        cell_Add.btn_Signin.addTarget(self, action: #selector(self.btn_SigninAction(_:)), for: .touchUpInside)
        cell_Add.btnGuest.addTarget(self, action: #selector(guestLogin), for: .touchUpInside)
        cell_Add.btn_terms.tag = indexPath.row
        cell_Add.btn_terms.addTarget(self, action: #selector(self.signupAction), for: .touchUpInside)
        cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
        cell_Add.txt_Email.attributedPlaceholder = NSAttributedString(string:"Enter Mobile No.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        self.view.layoutIfNeeded()
        return cell_Add
    }
}

extension LoginVC: ADCountryPickerDelegate {
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String) {
        print(code)
    }
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        self.view.endEditing(true)
        self.countryCode = dialCode
        self.dismiss(animated: true, completion: {
            self.tbl_login.reloadData()
        })
    }
}
