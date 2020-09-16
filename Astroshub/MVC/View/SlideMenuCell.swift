//
//  SlideMenuCell.swift
//  Carclean
//
//  Created by Kriscent on 03/10/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class SlideMenuCell: UITableViewCell {
    
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var lbl_Username: UILabel!
    @IBOutlet weak var lbl_mobile: UILabel!
    @IBOutlet weak var view_back: UIView!
    
    @IBOutlet weak var btn_profile: UIButton!
    
    @IBOutlet weak var img_varify: UIImageView!
    @IBOutlet weak var img_varify1: UIImageView!
    @IBOutlet weak var lbl_varify: UILabel!
    //@IBOutlet weak var btn_Profile: UIButton!
    //@IBOutlet weak var btn_Changepassword: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
