//
//  WalletOfferViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 12/12/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class WalletOfferViewController: UIViewController {
    var completionHandler:((String) -> String)?

    @IBOutlet weak var labelForOffer: UILabel!
    @IBOutlet weak var blurView: UIView!
    var strForAmount = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if CurrentLocation == "India"{
        if strForAmount == "1" {
            labelForOffer.text = "Recharge 1 get Rs.100 and start using our services"
        }else{
            labelForOffer.text = "Recharge 50 get Rs. 150 and start using our services"
        }
        } else {
            if strForAmount == "1" {
                labelForOffer.text = "Recharge 1 get $3 and start using our services"
            }
        }
        
    }
    
    @IBAction func buttonOk(_ sender: UIButton) {
        self.completionHandler!("")
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
