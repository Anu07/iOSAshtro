//
//  BlogauthorCell.swift
//  SearchDoctor
//
//  Created by Kriscent on 14/11/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class BlogauthorCell: UITableViewCell {
    
    @IBOutlet weak var lbl_authorname: UILabel!
    @IBOutlet weak var lbl_authorspecl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
