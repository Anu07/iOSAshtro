//
//  ProfileCell.swift
//  SearchDoctor
//
//  Created by Kriscent on 09/11/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var circlImage: UIImageView!
    @IBOutlet weak var tagList: TagListView!
    @IBOutlet weak var labelforOnline: UILabel!
    @IBOutlet var colletionCategoryyy: UICollectionView!
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_camera: UIButton!
    @IBOutlet weak var view_fullname: UIView!
    @IBOutlet weak var txt_Fullname: UITextField!
    @IBOutlet weak var view_camera: UIView!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var view_email: UIView!
    @IBOutlet weak var txt_Email: UITextField!
    
    @IBOutlet weak var lblNextOnlineTime: UILabel!
    @IBOutlet weak var view_mobile: UIView!
    @IBOutlet weak var txt_Mobile: UITextField!
    
    @IBOutlet weak var view_gender: UIView!
    @IBOutlet weak var btn_male: UIButton!
    @IBOutlet weak var btn_female: UIButton!
    
    @IBOutlet weak var view_dob: UIView!
    @IBOutlet weak var btn_DOB: UIButton!
    
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_language: UILabel!
    @IBOutlet weak var lbl_exp: UILabel!
    @IBOutlet weak var lbl_onlinetime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
