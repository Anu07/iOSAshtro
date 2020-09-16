//
//  LoginCell.swift
//  Carclean
//
//  Created by Kriscent on 01/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class LoginCell: UITableViewCell {
    
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var btn_Signin: ZFRippleButton!
    @IBOutlet weak var btn_terms: UIButton!
    @IBOutlet weak var view_login: UIView!
    @IBOutlet weak var view_email: UIView!

    @IBOutlet weak var btnGuest: ZFRippleButton!
    @IBOutlet weak var buttonCountryCode: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
