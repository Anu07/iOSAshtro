//
//  CallEstimateVC.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 07/06/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class CallEstimateVC: UIViewController {

    @IBOutlet weak var labelMaximum: UILabel!
    @IBOutlet weak var labelgetCall: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblMaximumCallDuration: UILabel!
    @IBOutlet weak var lblAvailableBalance: UILabel!
    @IBOutlet weak var lblPerMinutePrice: UILabel!
    @IBOutlet weak var lblCallToAstrologer: UILabel!
    var completionHandler: (()->())?
    @IBOutlet weak var btnOk: ZFRippleButton!
    var estimateModel = EstimatePriceModel()
    var screenCome = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if screenCome == "chat" {
            self.lblNumber.text = ""
            self.lblCallToAstrologer.text = "Chat to \(estimateModel.name)"
            self.labelMaximum.text = "Maximum chat duration:"
            labelgetCall.isHidden = true
            btnOk.setTitle("Chat", for: .normal)
        }else{
            self.labelMaximum.text = "Maximum call duration:"
            labelgetCall.isHidden = false
            btnOk.setTitle("Call", for: .normal)


        self.lblNumber.text = setCustomerphoneCode + "-" + estimateModel.number
        self.lblCallToAstrologer.text = "Call to \(estimateModel.name)"
        
        }
        self.lblPerMinutePrice.text = estimateModel.charge

        self.lblMaximumCallDuration.text = estimateModel.timeInHours

        self.lblAvailableBalance.text = estimateModel.balance
        if walletBalanceNew < 0 {
            self.btnOk.isUserInteractionEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionOk(_ sender: Any) {
        if let getHandler = completionHandler {
            self.dismiss(animated: true, completion: nil)
            getHandler()
        }
    }
}
