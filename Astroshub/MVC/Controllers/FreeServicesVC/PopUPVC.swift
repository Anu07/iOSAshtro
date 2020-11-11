//
//  PopUPVC.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 04/10/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class PopUPVC: UIViewController {

    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var viewForPopUp: UIView!
    var arrForData  = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewForPopUp.layer.cornerRadius = 10
        viewForPopUp.clipsToBounds = true
        label1.text = arrForData[0]
        label2.text = arrForData[1]
        label3.text = arrForData[2]
    }

    @IBAction func okButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
