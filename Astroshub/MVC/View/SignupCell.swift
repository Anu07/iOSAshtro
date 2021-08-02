//
//  SignupCell.swift
//  Carclean
//
//  Created by Kriscent on 01/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class SignupCell: UITableViewCell {
    
    
    @IBOutlet weak var txtReferalCode: UITextField!
    @IBOutlet weak var img_Header: UIImageView!
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var viewForCode: UIView!
    @IBOutlet weak var txt_MobileNo: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_CnfPassword: UITextField!
    @IBOutlet weak var txt_referalcode: UITextField!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var btn_Signin: UIButton!
    @IBOutlet weak var view_Signup: UIView!
    @IBOutlet weak var btn_Back: UIButton!
    
    @IBOutlet weak var btn_box: UIButton!
    @IBOutlet weak var img_box: UIImageView!
    @IBOutlet weak var btn_visibility1: UIButton!
    @IBOutlet weak var btn_visibility2: UIButton!
    @IBOutlet weak var btn_countrycode: UIButton!
    @IBOutlet weak var view_code: UIView!
    @IBOutlet weak var view_Name: UIView!
    @IBOutlet weak var view_MobileNo: UIView!
    @IBOutlet weak var view_Email: UIView!
    @IBOutlet weak var view_Password: UIView!
    @IBOutlet weak var view_CnfPassword: UIView!
    @IBOutlet weak var view_referalcode: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
