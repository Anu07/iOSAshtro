//
//  RegistrationotpVC.swift
//  Carclean
//
//  Created by Kriscent on 04/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController
import FirebaseAuth
import ADCountryPicker

var countrycodeID = "26"

var Otpsign = Int()
var Mobsign = ""
class RegistrationotpVC: UIViewController ,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var img_Header: UIImageView!
    @IBOutlet weak var txt_otp: UITextField!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var view_otp: UIView!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet var tbl_login: UITableView!
    var Email = ""
    var countryCode = "+91"
    var arrstatecity = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCountryCode()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.tbl_login.addGestureRecognizer(rightSwipe)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        
        if (sender.direction == .right)
        {
            print("Swipe Right")
            
            for controller in self.navigationController!.viewControllers as Array {
                //  if #available(iOS 13.0, *) {
                if controller.isKind(of: LoginVC.self) {
                    _ =  self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
                    //   }
                else {
                    // Fallback on earlier versions
                }
            }
            
            // show the view from the left side
        }
    }
    
    @objc func countrycodeAction() {
        let picker = ADCountryPicker()
        picker.delegate = self
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    func validateMethodddd () -> Bool
    {
        guard  !(self.txt_otp.text)!.isBlank  else{
            if #available(iOS 13.0, *) {
                CommenModel.showDefaltAlret(strMessage: "Please enter Otp", controller: self)
            } else {
                // Fallback on earlier versions
            }
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
       
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if (textField.tag==1)
        {
            Email=textField.text!
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
            Email=textField.text!
        }
        
        return true
    }
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func otpApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":kAppVersion,"mobile_no":txt_otp.text as Any] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.SENDREGISTRATIONOTP.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            let dict_Data = tempDict["data"] as! NSDictionary
                                            print("dict_Data is:-",dict_Data)
                                            
                                            Otpsign = dict_Data["Otp"] as! Int
                                            Mobsign = dict_Data["user_phone"] as! String
                                            let Signup = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC")
                                            self.navigationController?.pushViewController(Signup!, animated: true)
                                            
                                            
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
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
    func resendOtpApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":kAppVersion,"mobile_no":txt_otp.text as Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("sendRegistrationOtp", params: setparameters as [String : AnyObject],headers: nil,
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
    
    
    func otpvarifyApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":kAppVersion,"user_otp":txt_otp.text as Any] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("checkOtp", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            //                                            UserApiKey = tempDict["user_api_key"] as! String
                                            //                                            print("UserApiKey:-",UserApiKey)
                                            
                                            
                                            let NewPasswordVC = self.storyboard?.instantiateViewController(withIdentifier: "NewPasswordVC")
                                            self.navigationController?.pushViewController(NewPasswordVC!, animated: true)
                                            
                                            
                                            
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
    
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    
    @IBAction func buttonSignIn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_SubmitAction(_ sender: Any)
    {
        self.view.endEditing(true)
        if Validate.shared.validateRegistationotp(vc: self)
        {
            ActivityIndicator.shared.startLoading()
            str_ContNo_CounCode = self.countryCode + txt_otp.text!
            Mobsign = txt_otp.text!
            print("str_ContNo_CounCode is:-",str_ContNo_CounCode)
            PhoneAuthProvider.provider().verifyPhoneNumber(str_ContNo_CounCode, uiDelegate: nil) { (verificationID, error) in
                ActivityIndicator.shared.stopLoader()
                if  error != nil
                {
                    print(NSLocalizedDescriptionKey)
                    print(NSLocalizedFailureReasonErrorKey)
                    print("error: \(String(describing: error?.localizedDescription))")
                    CommenModel.showDefaltAlret(strMessage:String(describing: error?.localizedDescription), controller: self)
                }
                else
                {
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID, forKey: "authVID")
                    print(verificationID ?? "nil")
                    
                    let Signup = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC
                    self.navigationController?.pushViewController(Signup!, animated: true)
                    
                    
                    
                    
                }
                
            }
            
            
        }
        
    }
    
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_ResendAction(_ sender: Any)
    {
        self.resendOtpApiCallMethods()
    }
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 655
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! LoginCell
        cell_Add.btn_Signin.layer.cornerRadius = 10
        // cell_Add.btn_createaccount.layer.cornerRadius = 6
        
        cell_Add.view_login.layer.cornerRadius = 10
        cell_Add.view_email.layer.cornerRadius = 10
        cell_Add.view_email.layer.borderWidth = 1
        cell_Add.view_email.layer.borderColor = (UIColor .darkGray).cgColor
        cell_Add.buttonCountryCode.addTarget(self, action: #selector(countrycodeAction), for: .touchUpInside)
        
        cell_Add.btn_Signin.setTitle("Submit", for: .normal)
        cell_Add.txtCountryCode.text = self.countryCode
        
    
        cell_Add.btn_Signin.tag = indexPath.row
        cell_Add.btn_Signin.addTarget(self, action: #selector(self.btn_SigninAction(_:)), for: .touchUpInside)
        cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
       
        
        
        let btnayer = CAGradientLayer()
        
        
        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: cell_Add.btn_Signin.frame.size.width, height: cell_Add.btn_Signin.frame.size.height)
        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        cell_Add.btn_Signin.layer.insertSublayer(btnayer, at: 1)
        
        
        
        //cell_Add.txt_Email.setIcon(UIImage(named: "ic_phone")!)
        
        self.view.layoutIfNeeded()
        
        
        return cell_Add
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    @objc func btn_SigninAction(_ sender: UIButton)
    {
        self.view.endEditing(true)
        if Validate.shared.validateRegistationotp(vc: self)
        {
            ActivityIndicator.shared.startLoading()
            str_ContNo_CounCode = self.countryCode + self.Email
            Mobsign = self.Email
            print("str_ContNo_CounCode is:-",str_ContNo_CounCode)
            PhoneAuthProvider.provider().verifyPhoneNumber(str_ContNo_CounCode, uiDelegate: nil) { (verificationID, error) in
                ActivityIndicator.shared.stopLoader()
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
                    
                    let Signup = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC
                    Signup?.SignupCountrycode = self.countryCode
                    self.navigationController?.pushViewController(Signup!, animated: true)
                    
                    
                    
                    
                }
                
            }
            
            
        }
        
           
    }
        
        
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
}
extension RegistrationotpVC: ADCountryPickerDelegate {
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String) {
        
            print(code)
    }

    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        self.view.endEditing(true)
        self.countryCode = dialCode
        self.getCountryCodeId()
        self.dismiss(animated: true, completion: {
            self.tbl_login.reloadData()
        })
    }
}
