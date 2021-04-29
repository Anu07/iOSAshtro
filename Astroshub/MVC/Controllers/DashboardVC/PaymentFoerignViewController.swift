//
//  PaymentFoerignViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 13/02/21.
//  Copyright © 2021 Bhunesh Kahar. All rights reserved.
//

import UIKit

class PaymentFoerignViewController: UIViewController {

    @IBOutlet weak var labelForPayable: UILabel!
    @IBOutlet weak var labelForAmount: UILabel!
    @IBOutlet weak var tableVieww: UITableView!
    
    var amount = 0
    var completionHandler:(([String : Any]) -> [String : Any])?

    //MARK:- View Lifecycle Methods
    weak var delegateStripePay : DelegateStripePayment?
    var stripePaymentParams : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelForPayable.text = "$ \(amount)"
        labelForAmount.text = "$ \(amount)"

    }

    @IBAction func buttonForStripe(_ sender: UIButton) {
                   guard let addNewCardVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as? AddNewCardVC else { return }
                    addNewCardVC.stripePaymentParams = stripePaymentParams
                    addNewCardVC.delegateStripePay = self
                    addNewCardVC.amount = Int(amount)
        
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
