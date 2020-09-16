//
//  NewPasswordCell.swift
//  Carclean
//
//  Created by Kriscent on 04/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class NewPasswordCell: UITableViewCell {
    
   
    @IBOutlet weak var txt_NewPassword: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    @IBOutlet weak var btn_Submit: UIButton!
    
   @IBOutlet weak var view_NEWPASS: UIView!
   @IBOutlet weak var view_CNFPASS: UIView!
    
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
