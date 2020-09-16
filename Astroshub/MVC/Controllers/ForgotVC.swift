//
//  ForgotVC.swift
//  BloomKart
//
//  Created by Kriscent on 25/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit


class ForgotVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet var tbl_forgot: UITableView!
    var Email = ""
    var Password = ""
    var visibilityonoff = ""
    var isChecked: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)

        // Do any additional setup after loading the view.
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        
        if (sender.direction == .right)
        {
            print("Swipe Right")
            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: LoginVC.self) {
                    _ =  self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            
            // show the view from the left side
        }
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
       func validateMethod () -> Bool
       {
           guard  !(self.Email).isBlank  else{
            
                   CommenModel.showDefaltAlret(strMessage: "Please enter Mobile No.", controller: self)
              
               return false
           }

           
           return  true
       }
       
       func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
           
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
       
       
    
    
    
    

    //****************************************************
    // MARK: - API Methods
    //****************************************************
    
     func forgetApiCallMethods() {
            
            let deviceID = UIDevice.current.identifierForVendor!.uuidString
            print(deviceID)
            let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"email":Email as Any] as [String : Any]
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
    
    
    

    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @objc func btn_SigninAction(_ sender: UIButton)
      {
//          tbl_forgot.reloadData()
//          guard validateMethod() else {
//              return
//          }
//        //  self.loginApiCallMethods()
        
        print(Email)
        
        if Validate.shared.validateForgotPassword(vc: self)
        {
               self.forgetApiCallMethods()
        }
      }
    
    
    
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 640
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! LoginCell
        
        cell_Add.btn_Signin.layer.cornerRadius = 28
        
      
       
        cell_Add.view_email.layer.cornerRadius = 25
        cell_Add.view_email.layer.borderWidth = 1
        cell_Add.view_email.layer.borderColor = (UIColor .darkGray).cgColor

        cell_Add.btn_Signin.tag = indexPath.row
        cell_Add.btn_Signin.addTarget(self, action: #selector(self.btn_SigninAction(_:)), for: .touchUpInside)
        
        
         Common.setGradient(frame: CGRect(x: 0.0, y: 0.0, width: cell_Add.btn_Signin.frame.size.width, height: cell_Add.btn_Signin.frame.size.height), colors: [mainColor1.cgColor, mainColor3.cgColor], startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5), targetView: cell_Add.btn_Signin)

        
        cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
        
       
        
        cell_Add.txt_Email.setIcon(UIImage(named: "ic_phone")!)
       
        self.view.layoutIfNeeded()
        
      
        
        
        return cell_Add
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }

    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************

    

}
