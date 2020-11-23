//
//  OffersViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 11/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class OffersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataStatus =  Array<Any>()
    var completionHandler:(([String : Any]) -> [String : Any])?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
        
        apiForGetmytras()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func apiForGetmytras() {
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id] 

        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.coupon.rawValue, params:setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            self.dataStatus = dict_Data["coupon_list"] as! Array<Any>
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
extension OffersViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell", for: indexPath) as! OffersTableViewCell
        let data = self.dataStatus[indexPath.row] as! [String:Any]
        cell.labelOfferName.text = "Coupon Code:  \(data["coupon_code"] as! String)"
        cell.labelDate.text = "Valid Till : \(data["coupon_expiry_date"] as! String)"
        cell.labelForDesc.text =  "\(data["coupon_description"] as? String ?? "")" 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let data = self.dataStatus[indexPath.row] as! [String:Any]
        //        idForMantras = data["id"] as? String
        //        self.tableView.reloadData()
        self.completionHandler!(data)
        self.navigationController?.popViewController(animated: false)

    }
}
