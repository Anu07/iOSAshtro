//
//  PaymentPopUpVC.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 29/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import Razorpay
private var KEY_ID = "rzp_live_1idxRp4tPV0Llx"    //"rzp_test_pDqqc1wovvXUCn" // @"rzp_test_1DP5mmOlF5G5ag";
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
class PaymentPopUpVC: UIViewController,RazorpayPaymentCompletionProtocol {
    func onPaymentSuccess(_ payment_id: String) {
        
    }
    
    var razorpay: RazorpayCheckout? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        razorpay = RazorpayCheckout.initWithKey(KEY_ID, andDelegate: self)

    }
    func onPaymentError(_ code: Int32, description str: String)
    {
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        // self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func btn_razorpayAction(_ sender: Any)
    {
        let multiplier = CurrentLocation == "India" ? 1.18 : 1
        let allowed = self.checkPaymentGatewayAlert(isStripe:false)
        if allowed{
            if QueryReportFormshow == "query"
            {
                if CurrentLocation == "India"{
                    mYCURRNECY = "INR"
                }else {
                    mYCURRNECY = "USD"
                }
                
                //let abcccc1 = Float(100.00)
                //let abcccc = Float(FormQueryPrice)
                //let abcccc2 = abcccc * abcccc1
                
                let rezorp = Double(FormQueryPrice) * 100.0
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                let options: [String:Any] = [
                    "amount" : finalGSTPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹\(FormQueryPrice) + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#FF7B18"
                    ]
                ]
                //                  razorpay?.open(options)
                razorpay?.open(options, displayController: self)
            }
            if QueryReportFormshow == "remedy"
            {
                if CurrentLocation == "India"{
                    mYCURRNECY = "INR"
                }else {
                    mYCURRNECY = "USD"
                }
                
                //let abcccc1 = Float(100.00)
                //let abcccc = Float(FormQueryPrice)
                //let abcccc2 = abcccc * abcccc1
                
                let rezorp = Double((CurrentLocation == "India" ? FormRemedyPrice : FormRemedydollarPrice)) * 100.0
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                let options: [String:Any] = [
                    "amount" : finalGSTPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹\((CurrentLocation == "India" ? FormRemedyPrice : FormRemedydollarPrice)) + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#FF7B18"
                    ]
                ]
                //                  razorpay?.open(options)
                razorpay?.open(options, displayController: self)
            }
            if QueryReportFormshow == "report"
            {
                if CurrentLocation == "India"
                {
                    mYCURRNECY = "INR"
                }
                else
                {
                    mYCURRNECY = "USD"
                }
                FormReportPrice = CurrentLocation == "India" ? FormReportPrice : FormReportPrice
                let rezorp = Double(FormReportPrice) * 100.0
                let finalGSTAddedPrice = (rezorp * multiplier).round(to: 2)
                
                let options: [String:Any] = [
                    "amount" : finalGSTAddedPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹\(FormReportPrice) + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#FF7B18"
                    ]
                ]
                //                  razorpay?.open(options)
                razorpay?.open(options, displayController: self)
            }
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
extension PaymentPopUpVC : DelegateStripePayment{
    func paymentDone(isSuccess : Bool , paymentId : String, msg : String){
        
        if isSuccess{
            self.showAlert(withTitle: SUCCESS_TITLE, andMessage: SUCCESS_MESSAGE)
            if QueryReportFormshow == "query" {
//                self.func_QueryForm("0")
            }
            if QueryReportFormshow == "report"{
//                self.func_ReportForm()
            }
            if QueryReportFormshow == "voice"{
//                self.func_QueryForm("1")
            }
            if QueryReportFormshow == "remedy"{
//                self.func_RemedyForm()
            }
        }else{
            self.showAlert(withTitle: "ERROR", andMessage: msg )
        }
        
    }
}


