//
//  WalletCell.swift
//  SearchDoctor
//
//  Created by Kriscent on 09/11/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class WalletCell: UITableViewCell {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var btn_cross: UIButton!
    
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
