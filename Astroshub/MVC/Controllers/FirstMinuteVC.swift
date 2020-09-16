//
//  FirstMinuteVC.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 07/06/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class FirstMinuteVC: UIViewController {

    @IBOutlet weak var lblAstro: UILabel!
    var navigation : UINavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblAstro.text = AstrologerNameee
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.navigation?.popToRootViewController(animated: true)
        })
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
