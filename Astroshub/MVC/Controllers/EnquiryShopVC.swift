//
//  EnquiryShopVC.swift
//  Astroshub
//
//  Created by Kriscent on 10/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class EnquiryShopVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{

    @IBOutlet weak var btn_Done: ZFRippleButton!
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_enquiryshop: UITableView!
    
       var Subject = ""
       var Personname = ""
       var Email = ""
       var MopbileNumber = ""
       var Message = ""
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnayer = CAGradientLayer()
        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: btn_Done.frame.size.width, height: btn_Done.frame.size.height)
        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        btn_Done.layer.insertSublayer(btnayer, at: 1)

        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    func textFieldDidBeginEditing(_ textField: UITextField)
    {    //delegate method
        
        
        if (textField.tag==1)
        {
            Subject=textField.text!
            
        }
            
        else if (textField.tag==2)
        {
            
            Personname=textField.text!
        }
        else if (textField.tag==3)
        {
            
            Email=textField.text!
        }
        else if (textField.tag==4)
        {
            
            MopbileNumber=textField.text!
        }
        else if (textField.tag==5)
        {
            
            Message=textField.text!
        }
        
    }
      func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
      {
          
        if (textField.tag==1)
        {
            Subject=textField.text!
            
        }
            
        else if (textField.tag==2)
        {
            
            Personname=textField.text!
        }
        else if (textField.tag==3)
        {
            
            Email=textField.text!
        }
        else if (textField.tag==4)
        {
            
            MopbileNumber=textField.text!
        }
        else if (textField.tag==5)
        {
            
            Message=textField.text!
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
    func func_enquiryForm() {
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id,"enquiry_product_id":productcatyegoryIDD,"enquiry_subject":self.Subject,"enquiry_person_name":self.Personname,"enquiry_person_email":self.Email,"enquiry_person_phone":self.MopbileNumber,"enquiry_person_message":self.Message]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("productEnquiryShop", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true{
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }else{
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
    
    @IBAction func btn_doneAction(_ sender: Any)
       {
           if Validate.shared.validatenquiryyyform(vc: self)
           {
             self.func_enquiryForm()
           }
       }
    
    //****************************************************
        // MARK: - Tableview Method
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        func numberOfSections(in tableView: UITableView) -> Int{
            return 2
        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            
            if indexPath.section == 0{
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell1", for: indexPath) as! ProfileCell1
                cell_Add.txt_subject.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_namee.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
                return cell_Add
            }else{
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell3", for: indexPath) as! ProfileCell3
                cell_Add.txt_mobilenumber.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_enquiry.delegate = (self as UITextFieldDelegate)
                return cell_Add
            }
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
}
