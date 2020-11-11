//
//  SupportVC.swift
//  Astroshub
//
//  Created by Kriscent on 08/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import iOSDropDown
class SupportVC: UIViewController {
    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var mainDropDown: DropDown!
    
    
    @IBOutlet weak var stateDropDown: DropDown!
    @IBOutlet weak var cityDropDown: DropDown!
    @IBOutlet weak var valueLabel: UILabel!
    
    var countryArray = NSArray()
    var countryNameArray = [String]()
    var countryIdArray = [Int]()
    
    var stateArray = NSArray()
    var stateNameArray = [String]()
    var stateIdArray = [Int]()
    
    var cityArray = NSArray()
    var cityNameArray = [String]()
    var cityIdArray = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(mainDropDown)
        self.func_GetCOUNTRY()
        self.func_GetStates()
        //view_top.layer.cornerRadius = 5.0
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
                                            
                                            
                                            
                                            if let arrtimeslot = tempDict["data"] as? NSArray
                                            {
                                                self.countryArray = arrtimeslot
                                            }
                                            print("arrTimeList is:- ",self.countryArray)
                                            
                                            for i in 0..<self.countryArray.count
                                            {
                                                let dict_Products = self.countryArray[i] as! NSDictionary
                                                let name = dict_Products["name"] as! String
                                                let id = dict_Products["id"] as! String
                                                let iddddd = Int(id)
                                                
                                                
                                                self.countryNameArray.append(name)
                                                self.countryIdArray.append(iddddd!)
                                            }
                                            
                                            self.mainDropDown.optionArray = self.countryNameArray
                                            self.mainDropDown.optionIds = self.countryIdArray
                                            self.mainDropDown.checkMarkEnabled = false
                                            
                                            self.mainDropDown.didSelect{(selectedText , index , id) in
                                                self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
                                                
                                                let txtddddd = selectedText
                                                let txtIdddddddd = id
                                                print(txtddddd)
                                                print(txtIdddddddd)
                                                
                                            }
                                            
                                            self.mainDropDown.arrowSize = 20
                                            
                                            
                                            
                                            
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
    
    func func_GetStates() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        // let setparameters = ["app_type":"ios","app_version":"1.0","user_id":UserUniqueID ,"user_api_key":UserApiKey]
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("states", params: setparameters as [String : AnyObject],headers: nil,
              success: { (respose) in
                AutoBcmLoadingView.dismiss()
                let tempDict = respose as! NSDictionary
                print(tempDict)
                let success=tempDict["response"] as!   Bool
                let message=tempDict["msg"] as!   String
                
                if success == true
                {
                let dict_data = tempDict["data"] as! [String:Any]
                print("dict_data is:- ",dict_data)
                self.stateArray = NSArray()
                
                
                
                if let arrtimeslot = dict_data["states"] as? NSArray
                {
                    self.stateArray = arrtimeslot
                }
                print("arrTimeList is:- ",self.stateArray)
                
                for i in 0..<self.stateArray.count
                {
                    let dict_Products = self.stateArray[i] as! NSDictionary
                    let name = dict_Products["state_name"] as! String
                    let id = dict_Products["state_id"] as! String
                    let iddddd = Int(id)
                    
                    
                    
                    
                    self.stateNameArray.append(name)
                    self.stateIdArray.append(iddddd!)
                    
                    
                }
                
                self.stateDropDown.optionArray = self.stateNameArray
                self.stateDropDown.optionIds = self.stateIdArray
                self.stateDropDown.checkMarkEnabled = false
                
                self.stateDropDown.didSelect{(selectedText , index , id) in
                    self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
                    
                    let txtddddd = selectedText
                    let txtIdddddddd = id
                    print(txtddddd)
                    print(txtIdddddddd)
                    
                    self.cityDropDown.text = ""
                    self.cityNameArray = [String]()
                    self.cityIdArray = [Int]()
                    userStateId = String(txtIdddddddd)
                    //  self.cityArray = NSArray()
                    self.func_GetCity()
                    
                }
                
                self.stateDropDown.arrowSize = 20
                
                
                
                
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
    
    func func_GetCity() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        //let setparameters = ["app_type":"ios","app_version":"1.0","user_id":UserUniqueID ,"user_api_key":UserApiKey,"state_id":userStateId]
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey,"state_id":userStateId]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("cityByStateId", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            let dict_data = tempDict["data"] as! [String:Any]
                                            print("dict_data is:- ",dict_data)
                                            self.cityArray = NSArray()
                                            
                                            
                                            
                                            
                                            if let arrtimeslot = dict_data["cities"] as? NSArray
                                            {
                                                self.cityArray = arrtimeslot
                                            }
                                            print("arrTimeList is:- ",self.cityArray)
                                            
                                            for i in 0..<self.cityArray.count
                                            {
                                                let dict_Products = self.cityArray[i] as! NSDictionary
                                                let name = dict_Products["city_name"] as! String
                                                let id = dict_Products["city_id"] as! String
                                                let iddddd = Int(id)
                                                
                                                
                                                self.cityNameArray.append(name)
                                                self.cityIdArray.append(iddddd!)
                                            }
                                            
                                            self.cityDropDown.optionArray = self.cityNameArray
                                            self.cityDropDown.optionIds = self.cityIdArray
                                            self.cityDropDown.checkMarkEnabled = false
                                            
                                            self.cityDropDown.didSelect{(selectedText , index , id) in
                                                self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index) \n Id: \(id)"
                                                
                                                let txtddddd = selectedText
                                                let txtIdddddddd = id
                                                print(txtddddd)
                                                print(txtIdddddddd)
                                                
                                            }
                                            
                                            self.cityDropDown.arrowSize = 20
                                            
                                            
                                            
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
    
    
    @IBAction func txt_Search(_ sender: Any)
    {
        //let option =  Options()
        
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
