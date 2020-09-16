//
//  RefertofriendVC.swift
//  Astroshub
//
//  Created by Kriscent on 04/03/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class RefertofriendVC: UIViewController {

    @IBOutlet var view1: UIView!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var lbl4: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view1.layer.shadowColor = UIColor.lightGray.cgColor
        view1.layer.shadowOpacity = 5.0
        view1.layer.shadowRadius = 5.0
        view1.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        view1.layer.masksToBounds = false
        view1.layer.cornerRadius = 5.0
        
        lbl1.text = "You get " + rupee + " 100 They get " + rupee +  " 100"
        lbl2.text = "Note : you will get " + rupee + " 100 for every friend you refer"
        lbl3.text = ReferellCode

        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    
    

    //****************************************************
    // MARK: - API Methods
    //****************************************************
    
    
    

    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_shareAction(_ sender: Any)
       {
       
          let text = "Join me on Astroshubh,Use My Referral code" + "(" + ReferellCode + ")" + "to sign up on app.We both gets referral bonus"
         // let image = UIImage(named: "3")
          let myWebsite = NSURL(string:"https://stackoverflow.com/users/4600136/mr-javed-multani?tab=profile")
          let shareAll = [text , myWebsite ?? "nil"] as [Any]
          let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
          activityViewController.popoverPresentationController?.sourceView = self.view
          self.present(activityViewController, animated: true, completion: nil)
       }

    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************

    
}
