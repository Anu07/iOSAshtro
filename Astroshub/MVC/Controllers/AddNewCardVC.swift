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

class AddNewCardVC: UIViewController, STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
    
    @IBOutlet weak var labelForAmount: UILabel!
    var paymentIntentClientSecret: String?
    
    @IBOutlet weak var viewForAddTeextFiled: UIView!
    //MARK:- Outlets
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    
    var amount = 0
    
    @IBOutlet weak var viewForField: UIView!
    //MARK:- View Lifecycle Methods
    weak var delegateStripePay : DelegateStripePayment?
    var stripePaymentParams : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentIntentClientSecret =  UserDefaults.standard.value(forKey: "client_secret") as? String
        
        labelForAmount.text = "$ \(amount)"
        let stackView = UIStackView(arrangedSubviews: [cardTextField])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewForField.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: viewForField.leftAnchor, multiplier: 1),
            viewForField.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 1),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: viewForField.topAnchor, multiplier: 1),
        ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupNavigationBar()
    }
    
    @IBAction func btnForPAy(_ sender: Any) {
        guard let paymentIntentClientSecret = paymentIntentClientSecret else {
            return;
        }
        // Collect card details
        AutoBcmLoadingView.show("Loading......")
        let cardParams = cardTextField.cardParams
        let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        // Submit the payment
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(paymentIntentParams, with: self) { (status, paymentIntent, error) in
            AutoBcmLoadingView.dismiss()
            switch (status) {
            case .failed:
                // self.displayAlert(title: "Payment failed", message: error?.localizedDescription ?? "")
                self.delegateStripePay?.paymentDone(isSuccess: false, paymentId: "", msg : error?.localizedDescription ?? "")

            case .canceled:
                //   self.displayAlert(title: "Payment canceled", message: error?.localizedDescription ?? "")
                self.delegateStripePay?.paymentDone(isSuccess: false, paymentId: "", msg : error?.localizedDescription ?? "")

            case .succeeded:
                //self.displayAlert(title: "Payment succeeded", message: paymentIntent?.description ?? "", restartDemo: true)
                print(paymentIntent?.description ?? "")
                self.delegateStripePay?.paymentDone(isSuccess: true, paymentId: paymentIntent?.paymentMethodId ?? "", msg : "")
            default:
                break
            }
        }
        
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
        let data_IsLogin = UserDefaults.standard.value(forKey: "isUserData") as? Data
        if let getData = data_IsLogin {
            let dict_IsLogin = NSKeyedUnarchiver.unarchiveObject(with:getData) as? [String:Any]
            stripePaymentParams["name"] = dict_IsLogin?["customer_name"] as? String ?? ""
            stripePaymentParams["email"] = dict_IsLogin?["email"] as? String ?? ""
            if dict_IsLogin?["customer_address"] as? String == "" {
                stripePaymentParams["line1"] = "Test Address"
            } else {
                stripePaymentParams["line1"] = dict_IsLogin?["customer_address"] as? String ?? "Test Address"
            }
            stripePaymentParams["city"] = dict_IsLogin?["user_city"] as? String ?? CurrentLocation
            let country = dict_IsLogin?["customer_country_name"] as? String ?? CurrentLocation
            stripePaymentParams["country"] =   CurrentLocation
            stripePaymentParams["state"] =   dict_IsLogin?["user_state"] as? String ?? CurrentLocation
        }
        stripePaymentParams["payment_token"] = stripeToken
        stripePaymentParams["user_id"] = user_id
        stripePaymentParams["user_api_key"] = user_apikey
        stripePaymentParams["amount"] = amount
        stripePaymentParams["currency"] = "USD"
        
        
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
    
    //
    //    //MARK:- Button Actions
    //
    //    @IBAction func actionAddCard(_ sender: UIButton) {
    //        self.view.endEditing(true)
    //        let cardNo = txtCardNo.text!.replacingOccurrences(of: " ", with: "")
    //        let cvv = txtCVV.text!
    //        let expiryDate = txtExpiryDate.text!
    //        let components = expiryDate.components(separatedBy: "/")
    //        var expiryYear:UInt!
    //        var expiryMonth:UInt!
    //        guard components.count > 1 else {
    //            showAlert(withTitle: "ERROR",
    //                      andMessage: "Expiry Date is Invalid")
    //
    //            return }
    //        expiryMonth = UInt(components[0])
    //        expiryYear = UInt(components[1])
    //        weak var selfVar = self
    //        let checkValidation = validateCard(withCardNo: cardNo, withCVV: cvv,withMonth:expiryMonth,withYear:expiryYear)
    //        if checkValidation == "Valid Card" {
    //            AutoBcmLoadingView.show("Loading......")
    //            let cardParams = STPCardParams()
    //            cardParams.number = cardNo
    //            cardParams.cvc = cvv
    //            cardParams.expYear = expiryYear
    //            cardParams.expMonth = expiryMonth
    //            STPAPIClient.shared.createToken(withCard: cardParams) { (stripetoken, error) in
    //                guard selfVar != nil else { return }
    //                guard let token = stripetoken , error == nil else {
    //                    DispatchQueue.main.async {
    //                        AutoBcmLoadingView.dismiss()
    //                        self.showAlert(withTitle: "ERROR", andMessage: error!.localizedDescription)
    //                    }
    //                    return
    //                }
    //                selfVar!.addCard(withStripeToken: "\(token)")
    //            }
    //        } else {
    //            self.showAlert(withTitle: "ERROR", andMessage: checkValidation)
    //        }
    //    }
}


