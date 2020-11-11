//
//  HeaderSectionTableViewCell.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 11/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class HeaderSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var downloadOption: UIButton!
    @IBOutlet weak var labeForTime: UILabel!
    @IBOutlet weak var tableViewHeading: UILabel!
    @IBOutlet weak var imageViewForuser: UIImageView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
