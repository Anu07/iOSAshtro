//
//  TermsandconditionVC.swift
//  Astroshub
//
//  Created by Kriscent on 19/03/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class TermsandconditionVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    var arrPrivacy = [[String:Any]]()
    @IBOutlet var tbl_terms: UITableView!
    
    @IBOutlet weak var txt_description: UITextView!
    var pagedescriptionnnnnn = ""
    @IBOutlet weak var view_top: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_terms.tableFooterView = UIView()
        
        
        self.func_privacyPolicydata()
        
        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_privacyPolicydata() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"page_type":"terms-condition"]
        
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
                                            self.arrPrivacy = (tempDict["data"] as? [[String:Any]])!
                                            print("dict_Data is:- ",self.arrPrivacy)
                                            
                                            for i in 0..<self.arrPrivacy.count
                                            {
                                                let dict_Users = self.arrPrivacy[i]
                                                self.pagedescriptionnnnnn=dict_Users["page_description"] as! String
                                                
                                                
                                            }
                                            
                                            // let url=dict_Data["page_link"] as! String
                                            
                                            // self.pagedescriptionnnnnn = dict_Data!["page_description"] as! String
                                            self.tbl_terms.reloadData()
                                            // self.txt_description.text = pagedescription
                                            
                                            //self.txt_description.attributedText = pagedescription.htmlToAttributedString
                                            
                                            
                                            
                                            
                                            
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
    
    
    
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //****************************************************
    // MARK: - Table Method
    //****************************************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let PackageList2 = tableView.dequeueReusableCell(withIdentifier: "BloddescrCell", for: indexPath) as! BloddescrCell
        
        PackageList2.lbl_Packagetitle.attributedText = pagedescriptionnnnnn.htmlToAttributedString
        
        //       let theString = "<h1>H1 title</h1><b>Logo</b><img src='http://www.aver.com/Images/Shared/logo-color.png'><br>~end~"
        //
        //        let theAttributedString = try! NSAttributedString(data: theString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!,
        //            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
        //            documentAttributes: nil)
        //
        //        PackageList2.lbl_Packagetitle.attributedText = theAttributedString
        
        return PackageList2
        
        // Cannot convert value of type 'NSAttributedString.DocumentAttributeKey' to expected dictionary key type 'NSAttributedString.DocumentReadingOptionKey'
    }
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
}
