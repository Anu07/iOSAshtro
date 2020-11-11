//
//  MytrasViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 11/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class MytrasViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataStatus =  Array<Any>()
    var idForMantras :String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "HeaderSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderSectionTableViewCell")
   
        apiForGetmytras()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
  

    func apiForGetmytras() {

        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.getMytras.rawValue, params:nil,headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            self.dataStatus = dict_Data["mantra_list"] as! Array<Any>
                                            self.tableView.reloadData()
                                            }
                                      
                                            
                                        else
                                        {
                                            
                                            
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                        }
                                        
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
        
        
        
    }
    

}
extension MytrasViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSectionTableViewCell", for: indexPath) as! HeaderSectionTableViewCell
        let data = self.dataStatus[indexPath.row] as! [String:Any]
        cell.tableViewHeading.text = data["mantra_title"] as? String
        cell.labeForTime.text = data["created_date"] as? String
        cell.imageViewForuser.layer.cornerRadius =  cell.imageViewForuser.frame.height/2
        cell.imageViewForuser.clipsToBounds = true
        cell.imageViewForuser.sd_setImage(with: URL(string: data["mantra_image"] as? String ??
        ""), placeholderImage:#imageLiteral(resourceName: "astroshubhL"))
        if data["id"] as? String == idForMantras {
            cell.view2.isHidden = false
//            cell.label1.text =  data["mantra_content"] as? String
            cell.label1.attributedText =  (data["mantra_content"] as? String)?.htmlToAttributedString

        }
        else{
            cell.view2.isHidden = true

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = self.dataStatus[indexPath.row] as! [String:Any]

        if data["id"] as? String == idForMantras {
        return 170
        } else {
            return 100
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.dataStatus[indexPath.row] as! [String:Any]
        idForMantras = data["id"] as? String
        self.tableView.reloadData()
    }
}
