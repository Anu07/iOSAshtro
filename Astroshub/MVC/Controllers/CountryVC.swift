//
//  CountryVC.swift
//  Astroshub
//
//  Created by Kriscent on 17/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class CountryVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet var tbl_timeslotlist: UITableView!
    @IBOutlet weak var view_top: UIView!
    var date_Selecttime = ""
    var arrstatecity = [[String:Any]]()
    
    var return_Response = [[String:Any]]()
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var txt_search: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_timeslotlist.tableFooterView = UIView()
        viewSearch.layer.shadowColor = UIColor.lightGray.cgColor
        viewSearch.layer.shadowOpacity = 5.0
        viewSearch.layer.shadowRadius = 5.0
        viewSearch.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        viewSearch.layer.masksToBounds = false
        viewSearch.layer.cornerRadius = 5.0
        
        view_top.layer.shadowColor = UIColor.lightGray.cgColor
        view_top.layer.shadowOpacity = 5.0
        view_top.layer.shadowRadius = 5.0
        view_top.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        view_top.layer.masksToBounds = false
        view_top.layer.cornerRadius = 5.0
        
        // print(arrcity)
        self.func_GetCOUNTRY()
        // tbl_timeslotlist.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    
    
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_GetCOUNTRY() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        //let setparameters = ["app_type":"ios","app_version":"1.0","user_id":UserUniqueID ,"user_api_key":UserApiKey,"state_id":userStateId]
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("country_code", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            //  let dict_data = tempDict["data"] as! [String:Any]
                                            //  print("dict_data is:- ",dict_data)
                                            
                                            
                                            
                                            if let arrtimeslot = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrstatecity = arrtimeslot
                                            }
                                            print("arrTimeList is:- ",self.arrstatecity)
                                            self.return_Response = self.arrstatecity
                                            
                                            self.tbl_timeslotlist.reloadData()
                                            
                                            
                                            
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
    @IBAction func btn_cancelAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func btn_doneAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func txt_Search(_ sender: Any)
    {
        
        self.arrstatecity = [[String:Any]]()
        
        for i in 0..<self.return_Response.count
        {
            let dict = self.return_Response[i]
            print("dict is:-",dict)
            
            //            let dict_1 = dict["users"] as! [String:Any]
            //            print("dict_1 is:-",dict_1)
            
            let target = dict["name"] as? String
            if ((target as NSString?)?.range(of: txt_search.text!, options: .caseInsensitive))?.location == NSNotFound
            {
                print("NOT SuccessFull")
                
            }
            else
            {
                self.arrstatecity.append(dict)
                print("  SuccessFull")
            }
        }
        
        if (txt_search.text! == "")
        {
            self.arrstatecity = self.return_Response
            
        }
        tbl_timeslotlist.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 51
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return self.arrstatecity.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let PackageList2 = tableView.dequeueReusableCell(withIdentifier: "PackageCell2", for: indexPath) as! PackageCell2
        let dict_eventpoll = self.arrstatecity[indexPath.row]
        
        let time = dict_eventpoll["name"] as! String
        
        PackageList2.lbl_Packagedescription.text = time
        
        return PackageList2
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dict_eventpoll = self.arrstatecity[indexPath.row]
        userCountry = dict_eventpoll["name"] as! String
        userCountrycode = dict_eventpoll["phonecode"] as! String
        LocationCountrycodeID = dict_eventpoll["id"] as! String
        self.navigationController?.popViewController(animated: false)

    }
    
    
    
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
}
