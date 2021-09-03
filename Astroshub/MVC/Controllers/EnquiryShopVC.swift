//
//  EnquiryShopVC.swift
//  Astroshub
//
//  Created by Kriscent on 10/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import Razorpay

private var KEY_ID = "rzp_live_1idxRp4tPV0Llx"
//    "rzp_live_1idxRp4tPV0Llx"    //"rzp_test_pDqqc1wovvXUCn" // @"rzp_test_1DP5mmOlF5G5ag";
private let SUCCESS_TITLE = "Yay!"
private let SUCCESS_MESSAGE = "Your payment was successful. The payment ID is %@"
private let FAILURE_TITLE = "Uh-Oh!"
private let FAILURE_MESSAGE = "Your payment failed due to an error.\nCode: %d\nDescription: %@"
private let EXTERNAL_METHOD_TITLE = "Umm?"
private let EXTERNAL_METHOD_MESSAGE = """
You selected %@, which is not supported by Razorpay at the moment.\nDo \
you want to handle it separately?
"""
private let OK_BUTTON_TITLE = "OK"

class EnquiryShopVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource,RazorpayPaymentCompletionProtocol{
    func onPaymentError(_ code: Int32, description str: String)
    {
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        // self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    var gstPrice = ""
    var getTotalPrice = ""
    var priceBooknow = ""
    var weight = ""
    @IBOutlet weak var btn_Done: ZFRippleButton!
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_enquiryshop: UITableView!
    var arrProductcategory = [String:Any]()
    @IBOutlet weak var viewForPop: UIView!
    var razorpay1: RazorpayCheckout? = nil
    var productid = ""
    var  bookNowVar = ""
    @IBOutlet weak var viewForPopPayment: UIView!
    var Subject = ""
    var Personname = ""
    var Email = ""
    var MopbileNumber = ""
    var Message = ""
    var Picker: UIPickerView!
    let pickerValues = ["Select Supplement", "Copper Ring", "Silver Ring","Silver Pendant"]
    let pickerprice = ["0" , "300", "1000","700"]
    let pickerForRud = ["Select Supplement","Silver Pendant"]
    let pickerpriceRud = ["0" ,"250"]
    var valuePrice = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnayer = CAGradientLayer()
        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: btn_Done.frame.size.width, height: btn_Done.frame.size.height)
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        btn_Done.layer.insertSublayer(btnayer, at: 1)
        Picker = UIPickerView()
        Picker.dataSource = self
        Picker.delegate = self
        razorpay1 = RazorpayCheckout.initWithKey(KEY_ID, andDelegate: self)
        viewForPop.isHidden = true
        viewForPopPayment.isHidden = true
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
        } else if (textField.tag==2) {
            Personname=textField.text!
        } else if (textField.tag==3) {
            Email=textField.text!
        } else if (textField.tag==4) {
            MopbileNumber=textField.text!
        } else if (textField.tag==5) {
            Message=textField.text!
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var updatedTextString : NSString = textField.text! as NSString
        updatedTextString = updatedTextString.replacingCharacters(in: range, with: string) as NSString
        
        //            self.methodYouWantToCallWithUpdatedString(updatedTextString)
        if (textField.tag==4)
        {
            
            return true
        } else if (textField.tag==5)
        {
            
            return true
        }
        let point = textField.convert(CGPoint.zero, to: self.tbl_enquiryshop)
        let indexPath = self.tbl_enquiryshop.indexPathForRow(at: point)
        let cell = self.tbl_enquiryshop.cellForRow(at: indexPath!) as! ProfileCell1
        if textField == cell.textFieldWeight {
            if productid == "3" {
                if CurrentLocation == "India" {
                    let valueprice  = arrProductcategory["price_inr"] as! String
                    if let totalStonePrice = Double(valueprice), let typeWeight = Double(updatedTextString as String) , let price =  Double(valuePrice) {
                        //                print(totalStonePrice + typesupplementPrice)
                        let sum  = String(format: "%.2f", (( (totalStonePrice * typeWeight   ) +  price )))
                        cell.labelForcal.text =  " \(updatedTextString ) * \(arrProductcategory["price_inr"] as! String) + \(valuePrice)  = \(sum ) ( GST + Delivery charges)"
                        getTotalPrice = sum
                    }
                    weight = updatedTextString as String
                } else {
                    let valueprice  = arrProductcategory["price_dollar"] as! String
                    if let totalStonePrice = Double(valueprice), let typeWeight = Double(updatedTextString as String) {
                        //                print(totalHours + typeHours)
                        let sum  = String(format: "%.2f", (( (totalStonePrice  *  typeWeight )+30.0)))
                        cell.labelForcal.text =  " \(updatedTextString ) * \(arrProductcategory["price_dollar"] as! String)   = \(sum ) (Delivery charges)"
                        
                        //                cell.labelForcal.text =  "\(arrProductcategory["price_dollar"] as! String) * \(updatedTextString ) + \(valuePrice)  = \(sum ) (Delivery charges)"
                        getTotalPrice = sum
                    }
                    weight = updatedTextString as String
                }
            } else{
                if CurrentLocation == "India" {
                    let valueprice  = arrProductcategory["price_inr"] as! String
                    if let totalStonePrice = Double(valueprice), let typeWeight = Double(updatedTextString as String) , let price =  Double(valuePrice) {
                        //                print(totalStonePrice + typesupplementPrice)
                        let sum  = String(format: "%.2f", (( (totalStonePrice * typeWeight   ) +  price )))
                        cell.labelForcal.text =  " \(updatedTextString ) * \(arrProductcategory["price_inr"] as! String) + \(valuePrice)  = \(sum ) ( GST + Delivery charges)"
                        getTotalPrice = sum
                    }
                    weight = updatedTextString as String
                } else {
                    let valueprice  = arrProductcategory["price_dollar"] as! String
                    if let totalStonePrice = Double(valueprice), let typeWeight = Double(updatedTextString as String) {
                        //                print(totalHours + typeHours)
                        let sum  = String(format: "%.2f", (( (totalStonePrice  *  typeWeight )) + 30.0))
                        cell.labelForcal.text =  " \(updatedTextString ) * \(arrProductcategory["price_dollar"] as! String)  = \(sum ) (Delivery charges)"
                        
                        //                cell.labelForcal.text =  "\(arrProductcategory["price_dollar"] as! String) * \(updatedTextString ) + \(valuePrice)  = \(sum ) (Delivery charges)"
                        getTotalPrice = sum
                    }
                    weight = updatedTextString as String
                }
                
                
            }
        }
        return true;
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if productid == "3" {
            return pickerForRud.count
        } else{
            return pickerValues.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if productid == "3" {
            return pickerForRud[row]
        } else{
            return pickerValues[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let point = pickerView.convert(CGPoint.zero, to: self.tbl_enquiryshop)
        let indexPath = self.tbl_enquiryshop.indexPathForRow(at: point)
        let cell = self.tbl_enquiryshop.cellForRow(at: IndexPath(item: 0, section: 2) ) as? ProfileCell1
        if productid == "3" {
            cell?.textFieldForcategory.text = pickerForRud[row]
            valuePrice = pickerpriceRud[row]
            cell?.labelForcal.text = ""
            cell?.textFieldWeight.text = ""
            let valueprice  = arrProductcategory["price_inr"] as! String
            if let totalStonePrice = Double(valueprice), let price =  Double(valuePrice) {
                let sum  = String(format: "%.2f", ( totalStonePrice  +  price ))
                getTotalPrice = sum
            }
        } else{
            cell?.textFieldForcategory.text = pickerValues[row]
            valuePrice = pickerprice[row]
            cell?.labelForcal.text = ""
            cell?.textFieldWeight.text = ""
            
        }
        self.view.endEditing(true)
    }
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    @IBAction func btnForRazopay(_ sender: UIButton) {
        var multiplier = CurrentLocation == "India" ? 1.18 : 1
        let allowed = self.checkPaymentGatewayAlert(isStripe:false)
        if allowed {
            if bookNowVar == "book" {
                var price = ""
                if CurrentLocation == "India" {
                    mYCURRNECY = "INR"
                    price = arrProductcategory["price_inr"] as? String ?? ""
                } else {
                    mYCURRNECY = "USD"
                    price = arrProductcategory["price_dollar"] as? String ?? ""
                }
                let rezorp = (Double(price) ?? 0.0) * 100.0
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                let options: [String:Any] = [
                    "amount" : finalGSTPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹\(price) + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#F6C500"
                    ]
                ]
                priceBooknow =  "\(price)"
                razorpay1?.open(options, displayController: self)
            } else if bookNowVar == "bookSpec" {
                var price = ""
                let arrProductcategory1 = arrProductcategory["astro_product_package"] as? [String:Any]
                if CurrentLocation == "India" {
                    mYCURRNECY = "INR"
                    price = arrProductcategory1?["inr_price"] as? String ?? ""
                } else {
                    mYCURRNECY = "USD"
                    price = arrProductcategory1?["doller_price"] as? String ?? ""
                }
                let rezorp = (Double(price) ?? 0.0) * 100.0
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                let options: [String:Any] = [
                    "amount" : finalGSTPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹\(price) + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#F6C500"
                    ]
                ]
                priceBooknow =  "\(price)"
                razorpay1?.open(options, displayController: self)
            } else if bookNowVar == "enquiry" {
                var price = ""
                if CurrentLocation == "India" {
                    mYCURRNECY = "INR"
                    price = arrProductcategory["price_inr"] as? String ?? ""
                } else {
                    mYCURRNECY = "USD"
                    price = arrProductcategory["price_dollar"] as? String ?? ""
                }
                let rezorp = (Double(price) ?? 0.0) * 100.0
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                let options: [String:Any] = [
                    "amount" : finalGSTPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹\(price) + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#F6C500"
                    ]
                ]
                priceBooknow =  "\(price)"
                razorpay1?.open(options, displayController: self)
            } else {
                var price = ""
                if CurrentLocation == "India"{
                    mYCURRNECY = "INR"
                    price = arrProductcategory["price_inr"] as? String ?? ""
                } else {
                    mYCURRNECY = "USD"
                    price = arrProductcategory["price_dollar"] as? String ?? ""
                }
                if productid == "4" {
                    let rezorp = (Double(price) ?? 0.0)  * 100.0
                    let options: [String:Any] = [
                        "amount" : rezorp,
                        "currency" :  mYCURRNECY,
                        "description": "( ₹\(price))",
                        "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                        "name": setCustomername,
                        "prefill": [
                            "contact": setCustomerphone,
                            "email": setCustomeremail
                        ],
                        "theme": [
                            "color": "#F6C500"
                        ]
                    ]
                    //                  razorpay?.open(options)
                    priceBooknow =  "\(rezorp)"
                    razorpay1?.open(options, displayController: self)
                } else if productid == "3"{
                    if getTotalPrice == "" {
                        getTotalPrice = price
                    }
                    let rezorp = (Double(getTotalPrice ) ?? 0.0  ) * 100.0
                    let options: [String:Any] = [
                        "amount" : rezorp + (150.0 * 100),
                        "currency" :  mYCURRNECY,
                        "description": "( ₹\(getTotalPrice) + 150 Delivery Charges included)",
                        "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                        "name": setCustomername,
                        "prefill": [
                            "contact": setCustomerphone,
                            "email": setCustomeremail
                        ],
                        "theme": [
                            "color": "#F6C500"
                        ]
                    ]
                    priceBooknow =  "\(rezorp + (150.0 * 100))"
                    razorpay1?.open(options, displayController: self)
                } else {
                    if valuePrice == "0" {
                        multiplier = CurrentLocation == "India" ? ((Double(getTotalPrice) ?? 0.0) * 0.0025): 1
                    } else {
                        multiplier = CurrentLocation == "India" ? ((Double(getTotalPrice) ?? 0.0) * 0.03) : 1
                    }
                    let rezorp = (Double(getTotalPrice) ?? 0.0)
                    let finalGSTPrice = (rezorp + multiplier)  * 100.0
                    let options: [String:Any] = [
                        "amount" : finalGSTPrice + (150.0 * 100),
                        "currency" :  mYCURRNECY,
                        "description": "( ₹\(getTotalPrice) +  GST included + 150 Delivery charges)",
                        "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                        "name": setCustomername,
                        "prefill": [
                            "contact": setCustomerphone,
                            "email": setCustomeremail
                        ],
                        "theme": [
                            "color": "#F6C500"
                        ]
                    ]
                    priceBooknow =  getTotalPrice
                    razorpay1?.open(options, displayController: self)
                }
                //            let rezorp = (Double(getTotalPrice) ?? 0.0) * 100.0
                //                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                //                let options: [String:Any] = [
                //                    "amount" : finalGSTPrice,
                //                    "currency" :  mYCURRNECY,
                //                    "description": "( ₹\(getTotalPrice) + 18% GST included)",
                //                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                //                    "name": setCustomername,
                //                    "prefill": [
                //                        "contact": setCustomerphone,
                //                        "email": setCustomeremail
                //                    ],
                //                    "theme": [
                //                        "color": "#F6C500"
                //                    ]
                //                ]
                //                //                  razorpay?.open(options)
                //                razorpay1?.open(options, displayController: self)
            }
            //                  razorpay?.open(options)
        }
    }
    
    
    
    @IBAction func buttonForStripe(_ sender: UIButton) {
        
        let allowed = self.checkPaymentGatewayAlert(isStripe:true)
        let currency = (CurrentLocation == "India" ? "INR" : "USD").lowercased()
        var amt = bookNowVar == "book" ? arrProductcategory["price_inr"] as! String : getTotalPrice
        var price = ""
        
        if bookNowVar == "book" ||  bookNowVar == "enquiry"{
            if CurrentLocation == "India"{
                mYCURRNECY = "INR"
                price = arrProductcategory["price_inr"] as? String ?? ""
            } else {
                mYCURRNECY = "USD"
                price = arrProductcategory["price_dollar"] as? String ?? ""
            }
        }
        else if bookNowVar == "bookSpec"{
            let arrProductcategory1 = arrProductcategory["astro_product_package"] as? [String:Any]
            if CurrentLocation == "India"{
                mYCURRNECY = "INR"
                price = arrProductcategory1?["inr_price"] as? String ?? ""
            } else {
                mYCURRNECY = "USD"
                price = arrProductcategory1?["doller_price"] as? String ?? ""
                
            }
        } else {
            if getTotalPrice != "" {
                price = getTotalPrice
            } else {
                mYCURRNECY = "USD"
                price = arrProductcategory["price_dollar"] as? String ?? ""
            }
        }
        
        if allowed {
            guard let addNewCardVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentFoerignViewController") as? PaymentFoerignViewController else { return }
            //                        addNewCardVC.stripePaymentParams = ["amount": amt,
            //                                                            "currency": currency]
            //                        addNewCardVC.delegateStripePay = self
            //                        addNewCardVC.amount = Int(amt) ?? 0
            
            
            //            guard let addNewCardVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as? AddNewCardVC else { return }
            if productid == "4" {
                addNewCardVC.stripePaymentParams = ["amount": ((Double(price) ?? 0.0) + 30.0) ,
                                                    "currency": mYCURRNECY]
                priceBooknow =  "\((Double(price) ?? 0.0) + 30.0)"
            } else  if productid == "3" {
                addNewCardVC.stripePaymentParams = ["amount": (((Double(price) ?? 0.0) + 30.0) )  ,
                                                    "currency": mYCURRNECY]
                priceBooknow =  "\((Double(price) ?? 0.0) + 30.0)"
                
            } else  if productid == "2" {
                addNewCardVC.stripePaymentParams = ["amount": (Double(price) ?? 0)  ,
                                                    "currency": currency]
                priceBooknow =  "\(((Double(price) ?? 0) ))"
                
            } else  {
                addNewCardVC.stripePaymentParams = ["amount": (Int(price) ?? 0) ,
                                                    "currency": currency]
                priceBooknow =  "\(((Double(price) ?? 0)))"
            }
            addNewCardVC.amount = Int(Double(priceBooknow) ?? 0.0)
            addNewCardVC.delegateStripePay = self
            addNewCardVC.completionHandler =   { text in
                if text["isSuccess"] as? Bool == true{
                    self.showAlert(withTitle: SUCCESS_TITLE, andMessage: SUCCESS_MESSAGE)
                    let paymentId =  text["paymentId"] as? String
                    if self.bookNowVar == "book" {
                        let rezorp = Double(self.getTotalPrice) ?? 0.0 * 100.0
                        let multiplier = CurrentLocation == "India" ? 1.18 : 1
                        //                    paymentId
                        let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                        self.func_enquiryForm(self.priceBooknow, weight: self.weight, cost: "", gstAmount: "\(finalGSTPrice)", discount: "", transactionId: paymentId ?? "", enquiry_type: "purchase")
                        
                    } else  if self.bookNowVar == "bookSpec" {
                        self.func_BookForm(self.priceBooknow, transactionId: paymentId ?? "")
                    }
                    else{
                        let rezorp = Double(self.getTotalPrice) ?? 0.0 * 100.0
                        let multiplier = CurrentLocation == "India" ? 1.18 : 1
                        let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                        self.func_enquiryForm(self.priceBooknow, weight: self.weight, cost: "", gstAmount: "\(finalGSTPrice)", discount: "", transactionId: paymentId ?? "", enquiry_type: "purchase")
                    }
                }
                return text
            }
            self.navigationController?.pushViewController(addNewCardVC, animated: true)
        }
    }
    
    
    @IBAction func backPopUp(_ sender: UIButton) {
        viewForPop.isHidden = true
        viewForPopPayment.isHidden = true
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
        if productid == "2"  {
            if Validate.shared.validatenquiryyyform(vc: self)
            {
                if  bookNowVar == "call"
                {
                    viewForPop.isHidden = false
                    viewForPopPayment.isHidden = false
                    //             self.func_enquiryForm("", weight: "", cost: "", gstAmount: "", discount: "", transactionId: "", enquiry_type: "enquiry")
                } else if bookNowVar == "book" {
                    viewForPop.isHidden = false
                    viewForPopPayment.isHidden = false
                } else {
                    viewForPop.isHidden = false
                    viewForPopPayment.isHidden = false
                }
                //            self.func_enquiryForm("", weight: "", cost: "", gstAmount: "", discount: "", transactionId: "")
            }
        } else  {
            if Validate.shared.validatenquiryyyform1(vc: self)
            {
                if  bookNowVar == "call"
                {
                    //             self.func_enquiryForm("", weight: "", cost: "", gstAmount: "", discount: "", transactionId: "", enquiry_type: "enquiry")
                } else if bookNowVar == "book" {
                    viewForPop.isHidden = false
                    viewForPopPayment.isHidden = false
                } else {
                    viewForPop.isHidden = false
                    viewForPopPayment.isHidden = false
                }
                //            self.func_enquiryForm("", weight: "", cost: "", gstAmount: "", discount: "", transactionId: "")
            }
        }
    }
    //****************************************************
    // MARK: - Tableview Method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if productid == "2"  {
            if indexPath.row == 2 {
                return 250
            } else {
                return UITableView.automaticDimension
            }
        } else if productid == "3"  {
            if indexPath.row == 2 {
                return 150
            } else {
                return UITableView.automaticDimension
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        if productid == "2" || productid == "3"  {
            return 3
        } else {
          return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if productid == "2" || productid == "3" {
            if indexPath.section == 0 {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell1", for: indexPath) as! ProfileCell1
                cell_Add.txt_subject.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_namee.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
                return cell_Add
            } else if indexPath.section == 1 {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell3", for: indexPath) as! ProfileCell3
                cell_Add.txt_mobilenumber.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_enquiry.delegate = (self as UITextFieldDelegate)
                return cell_Add
            } else {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell1
                if CurrentLocation == "India" {
                    cell_Add.textFieldForcategory.isHidden = false
                    cell_Add.labelForOpt.isHidden = false
                    cell_Add.viewForSupplement.isHidden = false
                    cell_Add.textFieldWeight.delegate = self
                    cell_Add.textFieldForcategory.inputView = Picker
                    cell_Add.textFieldForcategory.text = pickerValues[0]
                } else {
                    cell_Add.viewForSupplement.isHidden = true
                    cell_Add.textFieldForcategory.isHidden = true
                    cell_Add.labelForOpt.isHidden = true
                }
                if productid == "3" {
                    cell_Add.viewForWeight.isHidden = true
                    cell_Add.labelForcal.isHidden = true
                    cell_Add.labelForCostCal.isHidden = true
                    
                } else {
                    cell_Add.labelForCostCal.isHidden = false
                    
                    cell_Add.viewForWeight.isHidden = false
                    cell_Add.labelForcal.isHidden = false
                }
                return cell_Add
            }
        } else {
            if indexPath.section == 0 {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell1", for: indexPath) as! ProfileCell1
                cell_Add.txt_subject.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_namee.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
                return cell_Add
            } else if indexPath.section == 1 {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell3", for: indexPath) as! ProfileCell3
                cell_Add.txt_mobilenumber.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_enquiry.delegate = (self as UITextFieldDelegate)
                return cell_Add
            }
        }
        return UITableViewCell()
    }
}
extension EnquiryShopVC {
    func func_enquiryForm( _ totalAmount:String,weight:String,cost:String,gstAmount:String,discount:String,transactionId:String,enquiry_type:String) {
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id,"enquiry_product_id":productcatyegoryIDD,"enquiry_subject":self.Subject,"enquiry_person_name":self.Personname,"enquiry_person_email":self.Email,"enquiry_person_phone":self.MopbileNumber,"enquiry_person_message":self.Message,"total_amount" :totalAmount,"weight":weight,"cost":cost,"gst_amount":gstAmount,"discount":discount,"transection_id":transactionId,"enquiry_type":enquiry_type]
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
                                            let refreshAlert = UIAlertController(title: "Astroshubh", message: message, preferredStyle: UIAlertController.Style.alert)
                                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                                                    {
                                                                                        (action: UIAlertAction!) in
                                                                                        //            self.navigationController?.popToRootViewController(animated: true)
                                                                                        
                                                                                        self.backFun()
                                                                                    }))
                                            
                                            self.present(refreshAlert, animated: true, completion: nil)
                                        }else{
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
                                      }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    func backFun(){
        for controller in self.navigationController!.viewControllers as Array{
            if controller.isKind(of: DashboardVC.self){
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }else{
                // Fallback on earlier versions
            }
        }
    }
    func func_BookForm( _ totalAmount:String,transactionId:String) {
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id,"specialistId":productcatyegoryIDD,"service":self.Subject,"name":self.Personname," problem":self.Message,"amount" :totalAmount,"paymentID":transactionId,"dob":"2020-01-01","time":"5:30","date":"2020-12-13"]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("bookSpecialist", params: setparameters as [String : AnyObject],headers: nil,
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
    
    func onPaymentSuccess(_ payment_id: String)
    {
        PaymentID =  payment_id
        showAlert(withTitle: SUCCESS_TITLE, andMessage: String(format: SUCCESS_MESSAGE, payment_id ))
        if bookNowVar == "book" {
            let rezorp = Double(priceBooknow) ?? 0.0 * 100.0
            let multiplier = CurrentLocation == "India" ? 1.18 : 1
            
            let finalGSTPrice = (rezorp * multiplier).round(to: 2)
            self.func_enquiryForm(priceBooknow, weight: weight, cost: "", gstAmount: "\(finalGSTPrice)", discount: "", transactionId: payment_id, enquiry_type: "purchase")
        } else if bookNowVar == "bookSpec" {
            func_BookForm(priceBooknow, transactionId: payment_id)
        } else {
            let rezorp = Double(getTotalPrice) ?? 0.0 * 100.0
            let multiplier = CurrentLocation == "India" ? 1.18 : 1
            let finalGSTPrice = (rezorp * multiplier).round(to: 2)
            self.func_enquiryForm(getTotalPrice, weight: weight, cost: "", gstAmount: "\(finalGSTPrice)", discount: "", transactionId: payment_id, enquiry_type: "purchase")
        }
    }
    
    func onPaymentError(_ code: Int, description str: String?) {
        showAlert(withTitle: FAILURE_TITLE, andMessage: String(format: FAILURE_MESSAGE, code, str ?? ""))
    }
    
    func onExternalWalletSelected(_ walletName: String, withPaymentData paymentData: [AnyHashable : Any]?) {
        showAlert(withTitle: EXTERNAL_METHOD_TITLE, andMessage: String(format: EXTERNAL_METHOD_MESSAGE, walletName ))
    }
    
    func showAlert(withTitle title: String?, andMessage message: String?) {
        if UIDevice.current.systemVersion.compare("8.0", options: .numeric, range: nil, locale: .current) != .orderedAscending {
            _ = UIAlertController(title: title, message: message, preferredStyle: .alert)
            _ = UIAlertAction(title: OK_BUTTON_TITLE, style: .cancel, handler: nil)
            //
            //  The converted code is limited to 1 KB.
            //  Please Sign Up (Free!) to double this limit.
            //
            //  %< ----------------------------------------------------------------------------------------- %<
            
        }
    }
    
}
//MARK:- Stripe PAYMENTS
extension EnquiryShopVC : DelegateStripePayment{
    func paymentDone(isSuccess : Bool , paymentId : String, msg : String){
        if isSuccess {
            self.showAlert(withTitle: SUCCESS_TITLE, andMessage: SUCCESS_MESSAGE)
            if bookNowVar == "book" {
                let rezorp = Double(getTotalPrice) ?? 0.0 * 100.0
                let multiplier = CurrentLocation == "India" ? 1.18 : 1
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                self.func_enquiryForm(priceBooknow, weight: weight, cost: "", gstAmount: "\(finalGSTPrice)", discount: "", transactionId: paymentId, enquiry_type: "purchase")
                
            } else  if bookNowVar == "bookSpec" {
                func_BookForm(priceBooknow, transactionId: paymentId)
            } else {
                let rezorp = Double(getTotalPrice) ?? 0.0 * 100.0
                let multiplier = CurrentLocation == "India" ? 1.18 : 1
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                self.func_enquiryForm(priceBooknow, weight: weight, cost: "", gstAmount: "\(finalGSTPrice)", discount: "", transactionId: paymentId, enquiry_type: "purchase")
            }
        } else {
            self.showAlert(withTitle: "ERROR", andMessage: msg )
        }
    }
}

extension EnquiryShopVC: RazorpayPaymentCompletionProtocolWithData {
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        //        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        //        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}

