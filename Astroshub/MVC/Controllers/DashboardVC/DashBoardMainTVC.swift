//
//  DashBoardMainTVC.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 22/04/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import WOWRibbonView
class DashBoardMainTVC: UITableViewCell {

    @IBOutlet weak var newView: WOWRibbonView!
    @IBOutlet weak var imageviewNew: UIImageView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var imageViewDashBoard: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
