//
//  PanchangListVC.swift
//  Astroshub
//
//  Created by Kriscent on 24/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit


class PanchangListVC: UIViewController ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var tbl_panchang: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    
    
    
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 211
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return 5
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "PanchangListingCell", for: indexPath) as! PanchangListingCell
        
        return cell_Add
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //            tbl_productcategory.deselectRow(at: indexPath as IndexPath, animated: true)
        //            let EnquiryShop = self.storyboard?.instantiateViewController(withIdentifier: "EnquiryShopVC")
        //            self.navigationController?.pushViewController(EnquiryShop!, animated: true)
        
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
    
}
class PanchangListingCell: UITableViewCell {
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    
    
    
    // Initialization code
}
