//
//  BlogCell.swift
//  SearchDoctor
//
//  Created by Kriscent on 08/11/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class BlogCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var img_blog: UIImageView!
    @IBOutlet weak var lbl_blogtitle: UILabel!
    @IBOutlet weak var lbl_views: UILabel!
    @IBOutlet weak var lbl_blogdescription: UILabel!
    @IBOutlet weak var btn_blog: UIButton!
    @IBOutlet weak var btn_like: UIButton!
    @IBOutlet weak var btn_deleteblog: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
