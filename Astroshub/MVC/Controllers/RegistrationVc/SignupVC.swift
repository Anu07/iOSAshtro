//
//  SignupVC.swift
//  BloomKart
//
//  Created by Kriscent on 24/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseAuth
import SJSwiftSideMenuController
import FirebaseAuth
import FirebaseDatabase
import Firebase
var Namesign = ""
var MobileNumbersign = ""
var Emailsign = ""
var Passwordsign = ""
var CnfPasswordsign = ""
var referalcodesign = ""

class SignupVC: UIViewController  ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MKMapViewDelegate {
    var SignupCountrycode = ""
    var Name = ""
    var MobileNumber = ""
    var Email = ""
    var Password = ""
    var CnfPassword = ""
    var referalcode = ""
    
    var referingcode = ""
    var arrstatecity = [[String:Any]]()
    @IBOutlet var tbl_signup: UITableView!
    var visibilityonoff1 = ""
    var isChecked1: Bool = false
    var visibilityonoff2 = ""
    var isChecked2: Bool = false
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var privacyterms = ""
    var isChecked3: Bool = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.func_GetCOUNTRY()
       
        
        MobileNumber = Mobsign
        self.navigationController?.isNavigationBarHidden = true
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        // Do any additional setup after loading the view.
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        if (sender.direction == .right)
        {
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: RegistrationotpVC.self) {
                    _ =  self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            
           
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        //SignupCountrycode = userCountrycode
        
        self.tbl_signup.reloadData()
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    func validateMethod () -> Bool
    {
        guard  !(Name).isBlank  else{
            
            CommenModel.showDefaltAlret(strMessage: "Please enter Username", controller: self)
            
            return false
        }
        guard  !(MobileNumber).isBlank  else{
            
            CommenModel.showDefaltAlret(strMessage: "Please enter Mobile No.", controller: self)
            
            return false
        }
        guard  !(Password).isBlank  else{
            
            CommenModel.showDefaltAlret(strMessage: "Please enter Password", controller: self)
            
            return false
        }
        guard  !(CnfPassword).isBlank  else{
            
            CommenModel.showDefaltAlret(strMessage: "Please enter Confirm Password", controller: self)
            
            return false
        }
        guard ((Password) == (CnfPassword)) else {
            
            
            CommenModel.showDefaltAlret(strMessage:"Password not match", controller: self)
            
            return false
            
        }
        guard  !(Email).isBlank  else{
            
            CommenModel.showDefaltAlret(strMessage: "Please enter Email", controller: self)
            
            return false
        }
        guard ((Email.isValidEmail()))else {
            
            
            CommenModel.showDefaltAlret(strMessage: "Please enter valid Email ID", controller: self)
            
            return false
            
        }
        
        return  true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        
        if (textField.tag==1)
        {
            Name=textField.text!
            
        }
        else if (textField.tag==2)
        {
            
            Email=textField.text!
        }
        else if (textField.tag==3)
        {
            MobileNumber=textField.text!
        }
        else if (textField.tag==4)
        {
            Password=textField.text!
        }
        else if (textField.tag==5)
        {
            referalcode=textField.text!
        }
        else if (textField.tag==10)
        {
            referingcode = textField.text!
        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if (textField.tag==1)
        {
            Name=textField.text!
        }
        else if (textField.tag==2)
        {
            Email=textField.text!
        }
        else if (textField.tag==3)
        {
            MobileNumber=textField.text!
        }
        else if (textField.tag==4)
        {
            Password=textField.text!
        }
        else if (textField.tag==5)
        {
            referalcode=textField.text!
        }
        else if (textField.tag==10)
        {
            referingcode = textField.text!
        }
        // return YES;
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tbl_signup.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func signupApiCallMethods() {
        let defaults = UserDefaults.standard
      
        let fcm = defaults.string(forKey: "FcmToken")
        print(fcm ?? "")
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":kAppVersion,"username":Name,"phone_number":MobileNumber,"email":Email,"country":countrycodeID,"fcm_userid":fcmUserID,"referring_code":referingcode] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.USEREGISTRATION.rawValue, params: setparameters as [String : AnyObject],headers: nil,
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
                                            let refreshAlert = UIAlertController(title: "Astroshubh", message: message, preferredStyle: UIAlertController.Style.alert)
                                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                {
                                                    (action: UIAlertAction!) in
                                                    //            self.navigationController?.popToRootViewController(animated: true)
                                                   
                                                    self.backFun()
                                            }))
                                            self.present(refreshAlert, animated: true, completion: nil)
                                        }
                                        else
                                        {
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
            }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Account created successfully!", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                {
                    (action: UIAlertAction!) in                    
                    self.backFun()
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    func func_GetCOUNTRY() {
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
                                            for j in 0..<self.arrstatecity.count
                                            {
                                                 let dict2 = self.arrstatecity[j] as NSDictionary
                                                 let phonecode1 = dict2["phonecode"] as! String
                                                 if phonecode1 == LocationCountrycode
                                                 {
                                                    userCountrycode = phonecode1
                                                    //self.SignupCountrycode = userCountrycode
                                                    LocationCountrycodeID = dict2["id"] as! String
                                                    self.tbl_signup.reloadData()
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
    
    func backFun()
    {
        for controller in self.navigationController!.viewControllers as Array
        {
            if controller.isKind(of: LoginVC.self)
            {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
            else
            {
                // Fallback on earlier versions
            }
        }
    }
    
    
    
    
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @objc func btn_SinginAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btn_SubmitAction(_ sender: UIButton)
    {
        self.view.endEditing(true)
        if Validate.shared.validateRegistration(vc: self)
        {
            print(self.referalcode)
            let defaults = UserDefaults.standard
             ActivityIndicator.shared.startLoading()
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")! ,verificationCode: self.referalcode)
            Auth.auth().signIn(with: credential) { authData, error in
                ActivityIndicator.shared.stopLoader()
                if ((error) != nil) {
                    let alert = UIAlertController(title: "Astroshubh", message: "Please enter Valid Code", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                _ = authData!.user
                guard let userID = Auth.auth().currentUser?.uid else { return }
                fcmUserID = userID
                print(fcmUserID)
                self.signupApiCallMethods()
            }
        }
    }
    
    @objc func btn_BackAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btn_visibilityAction1(_ sender: UIButton)
    {
        if isChecked1 == true {
            isChecked1 = false
            visibilityonoff1 = ""
            tbl_signup.reloadData()
        }
        else
        {
            isChecked1 = true
            visibilityonoff1 = "shiptick"
            tbl_signup.reloadData()
        }
    }
    
    @objc func btn_visibilityAction2(_ sender: UIButton)
    {
        if isChecked2 == true
        {
            isChecked2 = false
            visibilityonoff2 = ""
            tbl_signup.reloadData()            
        } else
        {
            isChecked2 = true
            visibilityonoff2 = "shiptick"
            tbl_signup.reloadData()
            
        }
    }
    
    @objc func btn_boxAction(_ sender: UIButton)
    {
        if isChecked3 == true
        {
            isChecked3 = false
            privacyterms = ""
            
            tbl_signup.reloadData()
            self.scrollToBottom()
            
        }
        else
        {
            isChecked3 = true
            privacyterms = "privacyterms"
            tbl_signup.reloadData()
            self.scrollToBottom()
            
        }
    }
    
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 1050
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "SignupCell", for: indexPath) as! SignupCell
        cell_Add.btn_Submit.layer.cornerRadius = 10
        
        cell_Add.btn_Signin.tag = indexPath.row
        cell_Add.btn_Signin.addTarget(self, action: #selector(self.btn_SinginAction(_:)), for: .touchUpInside)
        
        cell_Add.btn_Submit.tag = indexPath.row
        cell_Add.btn_Submit.addTarget(self, action: #selector(self.btn_SubmitAction(_:)), for: .touchUpInside)
        
        cell_Add.btn_box.tag = indexPath.row
        cell_Add.btn_box.addTarget(self, action: #selector(self.btn_boxAction(_:)), for: .touchUpInside)
        
        
        cell_Add.btn_countrycode.tag = indexPath.row
        
//        let btnayer = CAGradientLayer()
//        
//        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: cell_Add.btn_Submit.frame.size.width, height: cell_Add.btn_Submit.frame.size.height)
////        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
//        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        cell_Add.txt_MobileNo.isUserInteractionEnabled = false
//        cell_Add.btn_Submit.layer.insertSublayer(btnayer, at: 1)
        
        
        cell_Add.view_Signup.layer.cornerRadius = 10
        
        cell_Add.view_code.layer.cornerRadius = 10
        cell_Add.view_code.layer.borderWidth = 1
        cell_Add.view_code.layer.borderColor = (UIColor .darkGray).cgColor
        
        cell_Add.view_Name.layer.cornerRadius = 10
        cell_Add.view_Name.layer.borderWidth = 1
        cell_Add.view_Name.layer.borderColor = (UIColor .darkGray).cgColor
        
        cell_Add.view_Email.layer.cornerRadius = 10
        cell_Add.view_Email.layer.borderWidth = 1
        cell_Add.view_Email.layer.borderColor = (UIColor .darkGray).cgColor
        
        cell_Add.view_MobileNo.layer.cornerRadius = 10
        cell_Add.view_MobileNo.layer.borderWidth = 1
        cell_Add.view_MobileNo.layer.borderColor = (UIColor .darkGray).cgColor
        cell_Add.viewForCode.layer.cornerRadius = 10
        cell_Add.viewForCode.layer.borderWidth = 1
        cell_Add.viewForCode.layer.borderColor = (UIColor .darkGray).cgColor
        cell_Add.view_referalcode.layer.cornerRadius = 10
        cell_Add.view_referalcode.layer.borderWidth = 1
        cell_Add.view_referalcode.layer.borderColor = (UIColor .darkGray).cgColor
        let codeee = self.SignupCountrycode
        cell_Add.btn_countrycode.setTitleColor(.black, for: .normal)
        cell_Add.btn_countrycode.setTitle(codeee,for: .normal)
        if privacyterms == ""
        {
            cell_Add.img_box.image=UIImage(named: "")
            cell_Add.img_box.tintColor = UIColor.init(red: 246.0/255.0, green: 197.0/255.0, blue: 0/255.0, alpha: 1.0)

        }
        else
        {
            cell_Add.img_box.image=UIImage(named: "checkBox")
            cell_Add.img_box.tintColor = UIColor.init(red: 246.0/255.0, green: 197.0/255.0, blue: 0/255.0, alpha: 1.0)

        }
        
        cell_Add.txt_MobileNo.text = MobileNumber
        cell_Add.txt_Name.delegate = (self as UITextFieldDelegate)
        cell_Add.txt_MobileNo.delegate = (self as UITextFieldDelegate)
        cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
        cell_Add.txt_referalcode.delegate = (self as UITextFieldDelegate)
        return cell_Add
        
    }
    
    
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
}
extension String {
    func isValidmobile() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[0-9]", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count))  != nil
    }
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        
        
    }
}
extension String {
    
    func validate() -> Bool {
        let string = " "
        return (string.rangeOfCharacter(from: CharacterSet.whitespaces) != nil)
    }
}
