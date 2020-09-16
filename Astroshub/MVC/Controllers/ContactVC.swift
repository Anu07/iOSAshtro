//
//  ContactVC.swift
//  Astroshub
//
//  Created by Kriscent on 20/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class ContactVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    var arrTerms = [[String:Any]]()
    @IBOutlet weak var txt_description: UITextView!
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_terms: UITableView!
    var pagedescriptionnnnnn = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_terms.tableFooterView = UIView()
        
       
        
        self.func_termsConditiondata()
        
        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_termsConditiondata() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"page_type":"contact-us"]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("cms", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            self.arrTerms = (tempDict["data"] as? [[String:Any]])!
                                            print("dict_Data is:- ",self.arrTerms)
                                            
                                            for i in 0..<self.arrTerms.count
                                            {
                                                let dict_Users = self.arrTerms[i]
                                                self.pagedescriptionnnnnn=dict_Users["page_description"] as! String
                                                
                                            }
                                            self.tbl_terms.reloadData()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let PackageList2 = tableView.dequeueReusableCell(withIdentifier: "BloddescrCell", for: indexPath) as! BloddescrCell
        
        PackageList2.lbl_Packagetitle.attributedText = pagedescriptionnnnnn.htmlToAttributedString
        
        return PackageList2
        
        
    }
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
}
