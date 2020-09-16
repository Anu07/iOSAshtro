//
//  WaitListVC.swift
//  Astroshub
//
//  Created by Kriscent on 08/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class WaitListVC: UIViewController {
    @IBOutlet weak var view_top: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       view_top.layer.shadowColor = UIColor.lightGray.cgColor
       view_top.layer.shadowOpacity = 5.0
       view_top.layer.shadowRadius = 5.0
       view_top.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
       view_top.layer.masksToBounds = false
        // view_top.layer.cornerRadius = 5.0
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
       //****************************************************
       // MARK: - Memory CleanUP
       //****************************************************
}
