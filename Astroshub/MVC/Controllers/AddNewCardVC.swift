//
//  AddNewCardVC.swift
//  Fittever
//
//  Created by dev on 1/31/18.
//  Copyright © 2018 dev. All rights reserved.
//

import UIKit
import Stripe

protocol DelegateStripePayment : class{
    func paymentDone(isSuccess : Bool , paymentId : String , msg : String)
}

class AddNewCardVC: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var txtCardNo: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    
    
    //MARK:- View Lifecycle Methods
    weak var delegateStripePay : DelegateStripePayment?
    var stripePaymentParams : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtCardNo.becomeFirstResponder()
        //setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    
    //MARK:- Touches Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- Helper Methods
    
    func validateCard(withCardNo cardNo:String,withCVV cvv:String,withMonth month:UInt,withYear year:UInt) -> String {
        
        guard cardNo.count >= 12 && cardNo.count <= 16 else {
            return "Card Number is Invalid"
        }
        guard cvv.count == 3 else {
            return "Invalid CVV"
        }
        
        guard month <= 12 else {
            return "Expiry Date is Invalid"
        }
        
        //Fetch current year
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy"
        let yearStr = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let monthStr = formatter.string(from: date)
        
        if let currentMonth = UInt(monthStr),let currentYear = UInt(yearStr) {
            if month > currentMonth {
                guard year >= currentYear else {
                    return "Expiry Date is Invalid"
                }
            } else {
                guard year > currentYear else {
                    return "Expiry Date is Invalid"
                }
            }
        }

        return "Valid Card"
    }
    
    
    func addCard(withStripeToken stripeToken:String) {
        
        stripePaymentParams["payment_token"] = stripeToken
        stripePaymentParams["user_id"] = user_id
        print(stripePaymentParams)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("stripePayment",
                                      params: stripePaymentParams as [String : AnyObject],
                                      headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        AutoBcmLoadingView.dismiss()
                                        if success == true{
                                            guard let data=tempDict["data"] as? [String : Any],
                                            let paymentID = data["stripe_charge_id"] as? String else { return }
                                            self.navigationController?.popViewController(animated: true)
                                            self.delegateStripePay?.paymentDone(isSuccess: true, paymentId: paymentID, msg : "")
                                            
                                        }else{
                                            guard let data=tempDict["data"] as? [String : Any],
                                            let err = data["value"] as? String else { return }
                                            self.navigationController?.popViewController(animated: true)
                                            self.delegateStripePay?.paymentDone(isSuccess: false, paymentId: "", msg : err)
                                            
                                        }
                                        
                                        
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
        
    }
    
    
    //MARK:- Button Actions
    
    @IBAction func actionAddCard(_ sender: UIButton) {
        self.view.endEditing(true)
        let cardNo = txtCardNo.text!.replacingOccurrences(of: " ", with: "")
        let cvv = txtCVV.text!
        let expiryDate = txtExpiryDate.text!
        let components = expiryDate.components(separatedBy: "/")
        var expiryYear:UInt!
        var expiryMonth:UInt!
        guard components.count > 1 else {
            showAlert(withTitle: "ERROR",
                      andMessage: "Expiry Date is Invalid")
            
            return }
        expiryMonth = UInt(components[0])
        expiryYear = UInt(components[1])
        weak var selfVar = self
        let checkValidation = validateCard(withCardNo: cardNo, withCVV: cvv,withMonth:expiryMonth,withYear:expiryYear)
        if checkValidation == "Valid Card" {
            AutoBcmLoadingView.show("Loading......")
            let cardParams = STPCardParams()
            cardParams.number = cardNo
            cardParams.cvc = cvv
            cardParams.expYear = expiryYear
            cardParams.expMonth = expiryMonth
            STPAPIClient.shared().createToken(withCard: cardParams) { (stripetoken, error) in
                guard selfVar != nil else { return }
                guard let token = stripetoken , error == nil else {
                    DispatchQueue.main.async {
                        AutoBcmLoadingView.dismiss()
                        self.showAlert(withTitle: "ERROR", andMessage: error!.localizedDescription)
                    }
                    return
                }
                selfVar!.addCard(withStripeToken: "\(token)")
            }
        } else {
            self.showAlert(withTitle: "ERROR", andMessage: checkValidation)
        }
    }
}

//MARK:- Textfield Delegate Methods

extension AddNewCardVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtCardNo {
            var newStr = textField.text!.trimmingCharacters(in: .whitespaces)
            newStr = newStr.replacingOccurrences(of: " ", with: "")
            if newStr.count != 0 && newStr.count % 4 == 0 && string != "" && txtCardNo.text!.count < 20 {
                textField.text = textField.text! + " "
            }
            if string == "" && textField.text!.hasSuffix(" ") {
                textField.text!.removeLast()
            }
           
//            if textField.text!.count > 19 {
//                return false
//            }
              
            return (txtCardNo.text!.count < 20) || string == ""
        } else if textField == txtExpiryDate {
            if textField.text!.count == 2 && string != "" {
                textField.text = textField.text! + "/"
            }
            if textField.text!.count == 4 && string == "" {
                textField.text = textField.text!.replacingOccurrences(of: "/", with: "")
            }
            return (textField.text!.count < 5) || string == ""
        } else if textField == txtCVV {
            return (textField.text!.count < 3) || string == ""
        }
        return true
    }
    
    func showAlert(withTitle title: String?, andMessage message: String?) {
        let refreshAlert = UIAlertController(title: "Astroshubh",
                                             message: message,
                                             preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: { (action: UIAlertAction!) in }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
}
