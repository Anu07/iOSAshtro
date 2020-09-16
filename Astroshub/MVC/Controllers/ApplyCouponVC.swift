//
//  ApplyCouponVC.swift
//  Carclean
//
//  Created by Kriscent on 10/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit
import SDWebImage
class ApplyCouponVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet var tbl_applycoupon: UITableView!
    var arrCouponList = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.getCouponListApiCallMethods()
        
        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func getCouponListApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("getCouponList", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            
                                            if let arrcoupon = dict_Data["Couponslist"] as? [[String:Any]]
                                            {
                                                self.arrCouponList = arrcoupon
                                            }
                                            print("arrCouponList is:- ",self.arrCouponList)
                                            self.tbl_applycoupon.reloadData()
                                            
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
    func applycouponcodeApiCallMethods() {
        
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"coupon_code":CouponCode,"amount":OnTabWalletAmount,"location":CurrentLocation]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("applyCouponCode", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            
                                            CouponDiscountAmount = dict_Data["coupon_discount_amt"] as! String
                                            //TotalDiscount = dict_Data["coupon_discount_amt"] as! Float
                                            CouponApplyID = dict_Data["coupon_apply_id"] as! Int
                                            CouponID = dict_Data["coupon_id"] as! String
                                            RemainingDiscountAmount = dict_Data["remainingAmount"] as! String
                                            
                                            //OnTabWalletAmount = RemainingDiscountAmount
                                            
                                            self.navigationController?.popViewController(animated: true)
                                            // CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
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
    @objc func btn_applyAction(_ sender: UIButton)
    {
        let dict3 = self.arrCouponList[sender.tag] as NSDictionary
        CouponCode =  dict3["coupon_code"] as! String
        self.applycouponcodeApiCallMethods()
        
    }
    @objc func btn_applyAction1(_ sender: UIButton)
    {
    }
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        if section == 0
        {
            
            return 1
            
            
        }
            
        else
        {
            return self.arrCouponList.count
            //return 6
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let CartListCell2 = tableView.dequeueReusableCell(withIdentifier: "ApplyCouponCell1", for: indexPath) as? ApplyCouponCell1
            
            
            CartListCell2?.view1.layer.borderWidth = 1
            CartListCell2?.view1.layer.borderColor = (UIColor .init(red: 149.0/255.0, green: 149.0/255.0, blue: 149.0/255.0, alpha: 1)).cgColor
            CartListCell2?.view1.layer.cornerRadius = 3
            
            CartListCell2?.btn_apply.tag = indexPath.row
            CartListCell2?.btn_apply.addTarget(self, action: #selector(self.btn_applyAction1(_:)), for: .touchUpInside)
            
            return CartListCell2!
        }
            
        else
        {
            let CartListCell4 = tableView.dequeueReusableCell(withIdentifier: "ApplyCouponCell2", for: indexPath) as? ApplyCouponCell2
            
            let dict_coupon = self.arrCouponList[indexPath.row]

            CartListCell4?.btn_apply.tag = indexPath.row
            CartListCell4?.btn_apply.addTarget(self, action: #selector(self.btn_applyAction(_:)), for: .touchUpInside)

            let coupon_descriptionn=dict_coupon["coupon_description"] as! String
            let coupon_codee=dict_coupon["coupon_code"] as! String

            CartListCell4?.lbl_code.text = coupon_codee


            CartListCell4?.lbl_description.attributedText = coupon_descriptionn.htmlToAttributedString
            
           // CartListCell4?.lbl_description.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            
            return CartListCell4!
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
}
class ApplyCouponCell1: UITableViewCell {
    
    @IBOutlet weak var txt_coupon: UITextField!
    @IBOutlet weak var btn_apply: UIButton!
    
    @IBOutlet weak var view1: UIView!
}
class ApplyCouponCell2: UITableViewCell {
    
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var btn_apply: UIButton!
}

