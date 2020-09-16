//
//  DoctorCell.swift
//  SearchDoctor
//
//  Created by Kriscent on 11/11/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class DoctorCell: UITableViewCell {

     @IBOutlet weak var view1: UIView!
     @IBOutlet weak var img_profile: UIImageView!
     @IBOutlet weak var lbl_doctorname: UILabel!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var lbl8: UILabel!
    @IBOutlet weak var lbl9: UILabel!
    
    @IBOutlet weak var btn_next: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
