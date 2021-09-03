//
//  PaymentFoerignViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 13/02/21.
//  Copyright © 2021 Bhunesh Kahar. All rights reserved.
//

import UIKit
import Stripe
class PaymentFoerignViewController: UIViewController {
    
    @IBOutlet weak var labelForPayable: UILabel!
    @IBOutlet weak var labelForAmount: UILabel!
    @IBOutlet weak var tableVieww: UITableView!
    
    var amount = 0
    var completionHandler:(([String : Any]) -> [String : Any])?
    var paymentIntentClientSecret: String?
    
    //MARK:- View Lifecycle Methods
    weak var delegateStripePay : DelegateStripePayment?
    var stripePaymentParams : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        labelForPayable.text = "$ \(amount)"
        labelForAmount.text = "$ \(amount)"
        getCard() 
    }
    
    @IBAction func buttonForStripe(_ sender: UIButton) {
        
        //        let config = STPPaymentConfiguration.shared
        //        config.requiredBillingAddressFields = .full
        //        let viewController = STPAddCardViewController(configuration: config, theme: STPTheme.defaultTheme)
        //        viewController.delegate = self
        //        let navigationController = UINavigationController(rootViewController: viewController)
        //        present(navigationController, animated: true, completion: nil)
        guard let addNewCardVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as? AddNewCardVC else { return }
        addNewCardVC.stripePaymentParams = stripePaymentParams
        addNewCardVC.delegateStripePay = self
        addNewCardVC.amount = Int(amount)
        addNewCardVC.paymentIntentClientSecret = paymentIntentClientSecret ?? ""
        self.navigationController?.pushViewController(addNewCardVC, animated: true)
    }
    
    @IBAction func buttonForBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension PaymentFoerignViewController : DelegateStripePayment{
    func paymentDone(isSuccess : Bool , paymentId : String, msg : String){
        var data = [String:Any]()
        
        data["isSuccess"] = isSuccess
        data["paymentId"] = paymentId
        data["msg"] = msg
        
        self.completionHandler!(data)
        if isSuccess{
            //            self.showAlert(withTitle: SUCCESS_TITLE, andMessage: SUCCESS_MESSAGE)
            //            if QueryReportFormshow == "query" {
            //                self.func_QueryForm("0")
            //            }
            //            if QueryReportFormshow == "report"{
            //                self.func_ReportForm()
            //            }
            //            if QueryReportFormshow == "voice"{
            //                self.func_QueryForm("1")
            //            }
            //            if QueryReportFormshow == "remedy"{
            //                self.func_RemedyForm()
            //            }
        }else{
            //            self.showAlert(withTitle: "ERROR", andMessage: msg )
        }
        
    }
}


extension PaymentFoerignViewController: STPAddCardViewControllerDelegate {
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
        
    }
    
    
    //MARK:- STPAdd Card Controller Delegate
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.async {
            //            self.addCard(withStripeToken: token.tokenId)
        }
        
    }
    
    func getCard() {
        stripePaymentParams["user_id"] = user_id
        stripePaymentParams["user_api_key"] = user_apikey
        stripePaymentParams["amount"] = amount
        stripePaymentParams["currency"] = "USD"
        
        print(stripePaymentParams)
        
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("acceptPayment",
                                      params: stripePaymentParams as [String : AnyObject],
                                      headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        AutoBcmLoadingView.dismiss()
                                        if success == true {
                                            guard let data=tempDict["data"] as? [String : Any] else {
                                                return
                                            }
                                            UserDefaults.standard.setValue(data["client_secret"] as? String ?? "", forKey: "client_secret")
                                            
                                            //
                                            
                                        }else{
                                            //                                            guard let data=tempDict["data"] as? [String : Any],
                                            //                                                let err = data["value"] as? String else { return }
                                            //                                            self.navigationController?.popViewController(animated: true)
                                            //                                            self.delegateStripePay?.paymentDone(isSuccess: false, paymentId: "", msg : err)
                                            
                                        }
                                        
                                        
                                      }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
        
    }
}
