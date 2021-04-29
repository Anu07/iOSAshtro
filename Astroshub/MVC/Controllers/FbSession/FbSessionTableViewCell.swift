//
//  FbSessionTableViewCell.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 29/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class FbSessionTableViewCell: UITableViewCell {

    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewuser: UIImageView!
    @IBOutlet weak var imageViewBg: UIImageView!
    @IBOutlet weak var fbButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
