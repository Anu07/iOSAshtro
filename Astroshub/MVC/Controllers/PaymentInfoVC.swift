//
//  PaymentInfoVC.swift
//  Astroshub
//
//  Created by Kriscent on 21/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

//MARK:- MODULES
import UIKit
import Razorpay


//MARK:- CLASS VARIBALES
private var KEY_ID = "rzp_live_1idxRp4tPV0Llx"
//    "rzp_live_1idxRp4tPV0Llx"
//    "rzp_live_1idxRp4tPV0Llx" // @"rzp_test_1DP5mmOlF5G5ag";
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

//MARK:- CLASS
class PaymentInfoVC: UIViewController ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,RazorpayPaymentCompletionProtocol,ExternalWalletSelectionProtocol
{
    
    //MARK:- OUTLETS
    @IBOutlet var tbl_paymentInfo: UITableView!
    
    //MARK:- PROPERTIES
    var razorpay: RazorpayCheckout? = nil
    var IntAmount = Float()
    var offerPrice = ""
    var gstPrice = Double()
    var amountAddAfterOffer = ""
    
    //MARK:- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        RemainingDiscountAmount = ""
        CouponDiscountAmount = ""
        razorpay = RazorpayCheckout.initWithKey(KEY_ID, andDelegate: self)
        tbl_paymentInfo.reloadData()
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        self.tbl_paymentInfo.reloadData()
    }
    //MARK:- TABLE VIEW DELEGATES
    func numberOfSections(in tableView: UITableView) -> Int{
        if offerPrice == "hide"{
            return 4
        }
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if offerPrice == "hide"{
            if indexPath.section == 0 {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfocell", for: indexPath) as! PaymentInfocell
                //let text1 = Float(GstAmount)
                //let text = String(format: "%.2f", text1)
                cell_Add.lbl1.text = dollar + OnTabWalletAmount
                cell_Add.lbl2.text = dollar + CouponDiscountAmount
                //cell_Add.lbl3.text = rupee + String(TotalAmount)
                return cell_Add
            } else if indexPath.section == 1 {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfocell3", for: indexPath) as! PaymentInfocell3
                let successor = CurrentLocation == "India" ? " \n (18% GST included) " : ""
                let multiplier = CurrentLocation == "India" ? 1.18 : 1
                //                if gstPrice == "0" {
                //                    cell_Add.lbl_totalamount.text = "\(OnTabWalletAmount)"
                //
                //                } else {
                if CouponDiscountAmount == "" || CouponDiscountAmount == "0" {
                    let gstAddedFinalAmount = ((OnTabWalletAmount as NSString).doubleValue * multiplier).round(to: 2)
                    cell_Add.lbl_totalamount.text = "\(dollar) \(gstAddedFinalAmount)\(successor)"
                }else{
                    let formatter = NumberFormatter()
                    formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
                    formatter.numberStyle = .decimal
                    let number = formatter.number(from: RemainingDiscountAmount)
                    let doubleAmount = number?.doubleValue ?? 0.0
                    let gstAddedFinalAmount = (doubleAmount * 0.18) + doubleAmount
                    cell_Add.lbl_totalamount.text = "\(dollar) \(gstAddedFinalAmount)\(successor)"
                }
                //                }
                return cell_Add
                
            }
            else if indexPath.section == 2{
                
                if CurrentLocation == "India" {
                    let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfocell1", for: indexPath) as! PaymentInfocell1
                    cell_Add.btnpay.tag = indexPath.row
                    cell_Add.btnpay.addTarget(self, action: #selector(self.btn_Pay(_:)), for: .touchUpInside)
                    return cell_Add
                } else {
                    
                    let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfonewcell", for: indexPath) as! PaymentInfonewcell
                    cell_Add.btnpay.tag = indexPath.row
                    cell_Add.btnpay.addTarget(self, action: #selector(self.btn_Paypal(_:)), for: .touchUpInside)
                    return cell_Add
                }
                
            }
            //            else if indexPath.section == 3{
            //                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfonewcell", for: indexPath) as! PaymentInfonewcell
            //                cell_Add.btnpay.tag = indexPath.row
            //                cell_Add.btnpay.addTarget(self, action: #selector(self.btn_Paypal(_:)), for: .touchUpInside)
            //                return cell_Add
            //            }
            else{
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "Notecell", for: indexPath) as! Notecell
                return cell_Add
            }
        } else {
            if indexPath.section == 0 {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfocell", for: indexPath) as! PaymentInfocell
                //let text1 = Float(GstAmount)
                //let text = String(format: "%.2f", text1)
                cell_Add.lbl1.text = dollar + OnTabWalletAmount
                cell_Add.lbl2.text = dollar + CouponDiscountAmount
                //cell_Add.lbl3.text = rupee + String(TotalAmount)
                return cell_Add
            } else if indexPath.section == 1 {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfocell2", for: indexPath) as! PaymentInfocell2
                cell_Add.btnSelectApplyCoupon.tag = indexPath.row
                cell_Add.btnSelectApplyCoupon.addTarget(self, action: #selector(self.btn_couponAction(_:)), for: .touchUpInside)
                cell_Add.btncross.tag = indexPath.row
                cell_Add.btncross.addTarget(self, action: #selector(self.btn_crossAction(_:)), for: .touchUpInside)
                cell_Add.view3.layer.shadowColor = UIColor.lightGray.cgColor
                cell_Add.view3.layer.shadowOpacity = 5.0
                cell_Add.view3.layer.shadowRadius = 5.0
                cell_Add.view3.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
                cell_Add.view3.layer.masksToBounds = false
                cell_Add.view3.layer.cornerRadius = 5.0
                
                if CouponDiscountAmount == ""{
                    cell_Add.view6.isHidden = true
                    // cell_Add.lbl_discount.text = rupee + " " + "0"
                }else{
                    cell_Add.view6.isHidden = false
                    cell_Add.lbl_couponname.text = CouponCode
                    //cell_Add.lbl_discount.text = rupee + " " + CouponDiscountAmount
                }
                return cell_Add
            }
            else if indexPath.section == 2
            {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfocell3", for: indexPath) as! PaymentInfocell3
                let successor = CurrentLocation == "India" ? " \n (18% GST included) " : ""
                let multiplier = CurrentLocation == "India" ? 1.18 : 1
                //            if gstPrice == "0" {
                //                cell_Add.lbl_totalamount.text = "\(OnTabWalletAmount)"
                //
                //            } else {
                if CouponDiscountAmount == "" || CouponDiscountAmount == "0" {
                    let gstAddedFinalAmount = ((OnTabWalletAmount as NSString).doubleValue * multiplier).round(to: 2)
                    cell_Add.lbl_totalamount.text = "\(dollar) \(gstAddedFinalAmount)\(successor)"
                    
                }else{
                    
                    let formatter = NumberFormatter()
                    formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
                    formatter.numberStyle = .decimal
                    let number = formatter.number(from: RemainingDiscountAmount)
                    let doubleAmount = number?.doubleValue ?? 0.0
                    let gstAddedFinalAmount = (doubleAmount * 0.18) + doubleAmount
                    cell_Add.lbl_totalamount.text = "\(dollar) \(gstAddedFinalAmount)\(successor)"
                    
                }
                //            }
                return cell_Add
                
            }
            else if indexPath.section == 3{
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfocell1", for: indexPath) as! PaymentInfocell1
                cell_Add.btnpay.tag = indexPath.row
                cell_Add.btnpay.addTarget(self, action: #selector(self.btn_Pay(_:)), for: .touchUpInside)
                return cell_Add
            }else if indexPath.section == 4{
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PaymentInfonewcell", for: indexPath) as! PaymentInfonewcell
                cell_Add.btnpay.tag = indexPath.row
                cell_Add.btnpay.addTarget(self, action: #selector(self.btn_Paypal(_:)), for: .touchUpInside)
                return cell_Add
            }else{
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "Notecell", for: indexPath) as! Notecell
                return cell_Add
            }
        }
        
    }
    
    
    
    
    
    
    
    
    //MARK:- ACTIONS
    @IBAction func btn_backAction(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionApplyCoupon(_ sender: UIButton) {
        //        appleCoup()
        let point = sender.convert(CGPoint.zero, to: self.tbl_paymentInfo)
        let indexPath = self.tbl_paymentInfo.indexPathForRow(at: point)
        let cell = self.tbl_paymentInfo.cellForRow(at: indexPath!) as! PaymentInfocell2
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ApplyCouponVC") as! ApplyCouponVC
        //        vc.screenCome = .recharge
        vc.completionHandler = { text in
            cell.lbl_couponname.text = text["coupon_code"] as? String
            print("text = \(text)")
            //            self.couponCode = text["id"] as! String
            return text
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- SELECTORS
    @objc func btn_Paypal(_ sender: UIButton) {
        let allowed = self.checkPaymentGatewayAlert(isStripe:true)
        let multiplier = CurrentLocation == "India" ? 1.18 : 1
        let currency = (CurrentLocation == "India" ? "INR" : "USD").lowercased()
        if allowed{
            //            if gstPrice == "0" {
            //                FinalAmount = Double(OnTabWalletAmount) ?? 0.0
            //
            //            } else{
            if CouponDiscountAmount == "" || CouponDiscountAmount == "0"{
                //FinalAmount = Float(OnTabWalletAmount) ?? 0.0
                let gstAddedFinalAmount = ((OnTabWalletAmount as NSString).doubleValue * multiplier).round(to: 2)
                FinalAmount = Double(gstAddedFinalAmount)
            }else{
                
                let formatter = NumberFormatter()
                formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
                formatter.numberStyle = .decimal
                let number = formatter.number(from: RemainingDiscountAmount)
                let doubleAmount = number?.doubleValue ?? 0.0
                let gstAddedFinalAmount = doubleAmount * multiplier
                FinalAmount = Double(gstAddedFinalAmount)
            }
            //            }
            guard let addNewCardVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as? AddNewCardVC else { return }
            addNewCardVC.stripePaymentParams = ["amount": FinalAmount,
                                                "currency": currency]
            addNewCardVC.amount = Int(FinalAmount)
            addNewCardVC.delegateStripePay = self
            self.navigationController?.pushViewController(addNewCardVC, animated: true)
        }
        
    }
    @objc func btn_Pay(_ sender: UIButton)
    {
        let allowed = self.checkPaymentGatewayAlert(isStripe:false)
        let multiplier = CurrentLocation == "India" ? 1.18 : 1
        if allowed {
            //            if gstPrice == "0" {
            //                FinalAmount = Double(OnTabWalletAmount) ?? 0.0
            //                let abcccc1 = Double(100.0)
            //                mYCURRNECY = CurrentLocation == "India" ? "INR" : "USD"
            //
            //                let abcccc2 = FinalAmount * abcccc1
            //                let options: [String:Any] = [
            //                    "amount" :  abcccc2,
            //                    "currency" :  mYCURRNECY,
            //                    "description": "",
            //                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
            //                    "name": setCustomername,
            //                    "prefill": [
            //                        "contact": setCustomerphone,
            //                        "email": setCustomeremail
            //                    ],
            //                    "theme": [
            //                        "color": "#FF7B18"
            //                    ]
            //                ]
            //
            //                razorpay?.open(options, displayController: self)
            //            } else {
            if CouponDiscountAmount == ""{
                let gstAddedFinalAmount = ((OnTabWalletAmount as NSString).doubleValue * multiplier).round(to: 2)
                FinalAmount = Double(gstAddedFinalAmount)
                gstPrice =  ((OnTabWalletAmount as NSString).doubleValue * 0.18)
            }else{
                
                let formatter = NumberFormatter()
                formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
                formatter.numberStyle = .decimal
                let number = formatter.number(from: RemainingDiscountAmount)
                let doubleAmount = number?.doubleValue ?? 0.0
                let gstAddedFinalAmount = doubleAmount * multiplier
                FinalAmount = Double(gstAddedFinalAmount)
                gstPrice =  doubleAmount * 0.18
            }
            let abcccc1 = Double(100.0)
            mYCURRNECY = CurrentLocation == "India" ? "INR" : "USD"
            
            let abcccc2 = FinalAmount * abcccc1
            let options: [String:Any] = [
                "amount" :  abcccc2,
                "currency" :  mYCURRNECY,
                "description": "(18% GST included)",
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
            
            razorpay?.open(options, displayController: self)
        }
        
        //        }
        
    }
    
    @objc func btn_couponAction(_ sender: UIButton){
        //        appleCoup()
        let point = sender.convert(CGPoint.zero, to: self.tbl_paymentInfo)
        let indexPath = self.tbl_paymentInfo.indexPathForRow(at: point)
        let cell = self.tbl_paymentInfo.cellForRow(at: indexPath!) as! PaymentInfocell2
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ApplyCouponVC") as! ApplyCouponVC
        //        vc.screenCome = .recharge
        vc.completionHandler = { text in
            cell.lbl_couponname.text = text["coupon_code"] as? String
            print("text = \(text)")
            //            self.couponCode = text["id"] as! String
            return text
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btn_crossAction(_ sender: UIButton){
        self.removevouponApiCallMethods()
    }
    
    //MARK:- FUNCTIONS
    func appleCoup(){
        let CouponVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplyCouponVC")
        self.navigationController?.pushViewController(CouponVC!, animated: true)
    }
    
    func backFun(){
        for controller in self.navigationController!.viewControllers as Array{
            if controller.isKind(of: WalletNewVC.self){
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }else{
                // Fallback on earlier versions
            }
        }
    }
    
    func showAlert(withTitle title: String?, andMessage message: String?) {
        if UIDevice.current.systemVersion.compare("8.0", options: .numeric, range: nil, locale: .current) != .orderedAscending {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: OK_BUTTON_TITLE, style: .cancel, handler: nil)
        }
    }
    
    func onPaymentError(_ code: Int32, description str: String)
    {
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
    }
    
    //MARK:- RAZOR PAY DELEGATES
    func onPaymentSuccess(_ payment_id: String){
        PaymentID =  payment_id
        self.func_rechargeamount()
        showAlert(withTitle: SUCCESS_TITLE, andMessage: String(format: SUCCESS_MESSAGE, payment_id ))
    }
    
    func onPaymentError(_ code: Int, description str: String?) {
        showAlert(withTitle: FAILURE_TITLE, andMessage: String(format: FAILURE_MESSAGE, code, str ?? ""))
    }
    
    func onExternalWalletSelected(_ walletName: String, withPaymentData paymentData: [AnyHashable : Any]?) {
        showAlert(withTitle: EXTERNAL_METHOD_TITLE, andMessage: String(format: EXTERNAL_METHOD_MESSAGE, walletName ))
    }
    
    func onPaymentCompletion(msg: String) {
        print("Result Delegate : onPaymentCompletion")
        print(msg)
    }
    
    //MARK:- API HANDLER
    
    func func_rechargeamount() {
        var welcome = 0
        if CouponDiscountAmount == "" || CouponDiscountAmount == "0"{
            AMTNY = amountAddAfterOffer
            CouponDiscountAmount = "0"
        }else{
            AMTNY = amountAddAfterOffer
        }
        if CurrentLocation == "India"{
            if OnTabWalletAmount == "1" {
                AMTNY = "100"
                welcome = 1
                CouponDiscountAmount = "1"
            } else if OnTabWalletAmount == "50"{
                AMTNY = "150"
                welcome = 1
                CouponDiscountAmount = "50"
            }
        } else {
            if OnTabWalletAmount == "1" {
                AMTNY = "3"
                welcome = 1
                CouponDiscountAmount = "1"

            }
        }
        
        let setparameters = ["app_type":"ios",
                             "app_version":"1.0",
                             "user_api_key":user_apikey,
                             "user_id":user_id,
                             "credit_amount":AMTNY,
                             "location":CurrentLocation,
                             "paymentid":PaymentID,
                             "coupan_amount":CouponDiscountAmount,
                             "gst_amount":gstPrice
                             ,"transaction_amount":FinalAmount,"isWelcomeRecharge":welcome] as [String : Any]
        
        //        user_id,user_api_key,credit_amount,gst_amount,transaction_amount,coupan_amount
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("addCustomerWalletRecharge", params: setparameters as [String : AnyObject],headers: nil,
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
    
    func removevouponApiCallMethods() {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"coupon_id":CouponID,"coupon_apply_id":CouponApplyID,"location":CurrentLocation] as [String : Any]
        
        print(setparameters)
        //AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("removeCoupon", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true{
                                            CouponCode = ""
                                            CouponDiscountAmount = ""
                                            self.tbl_paymentInfo.reloadData()
                                        }else{
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
                                      }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
}

//MARK:- STRIPE PAYMENTS
extension PaymentInfoVC : DelegateStripePayment{
    func paymentDone(isSuccess : Bool , paymentId : String , msg : String){
        
        if isSuccess{
            PaymentID = paymentId
            self.func_rechargeamount()
            //self.showAlert(withTitle: SUCCESS_TITLE, andMessage: SUCCESS_MESSAGE )
            
        }else{
            let refreshAlert = UIAlertController(title: "Astroshubh",
                                                 message: msg,
                                                 preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "OK",
                                                 style: .default,
                                                 handler: { (action: UIAlertAction!) in }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
        
    }
}
