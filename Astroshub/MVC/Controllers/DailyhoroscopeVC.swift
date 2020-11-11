//
//  DailyhoroscopeVC.swift
//  Astroshub
//
//  Created by Kriscent on 11/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class DailyhoroscopeVC: UIViewController ,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var arrhoroscope = [[String:Any]]()
    @IBOutlet weak var btntop: UIButton!
    var arrhoroscope1 = [[String:Any]]()
    var arrhoroscopeDiscription = [[String:Any]]()
    
    var return_Response = [[String:Any]]()
    var selectedZodiac = [String:Any]()
    var index_value = 0
    @IBOutlet var tbl_dashboard: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl_dashboard.isHidden = true
        self.horoscopeApiCallMethods()
        
        self.tbl_dashboard.delegate = self
        self.tbl_dashboard.dataSource = self
        
        
        let headername = "  " + ZodiacName
        
        btntop.setTitle(headername,for: .normal)
        
      self.horoscopeUserIdApiCallMethods()
        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func horoscopeApiCallMethods() {
        
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey.count > 0 ? user_apikey : "7bd679c21b8edcc185d1b6859c2e56ad" ,"user_id":user_id.count > 0 ? user_id: "CUSGUS","zodic_id":""]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.HOROSCOPE.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            //                                            if let arrSliderImages = tempDict["data"] as? [[String:Any]]
                                            //                                            {
                                            //                                                self.arrhoroscope = arrSliderImages
                                            //                                            }
                                            //                                            print("arrhoroscope is:- ",self.arrhoroscope)
                                            //
                                            
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=tempDict["data"] as! [[String:Any]]
                                            
                                            for i in 0..<arrProducts.count
                                            {
                                                var dict_Products = arrProducts[i]
                                                dict_Products["isSelectedDeselected"] = "0"
                                                dict_Products["id"] = i+1
                                                self.index_value = i
                                                self.arrhoroscope.append(dict_Products)
                                            }
                                            self.return_Response = self.arrhoroscope
                                            
                                            self.tbl_dashboard.reloadData()
                                            self.tbl_dashboard.isHidden = false
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
    func horoscopeUserIdApiCallMethods() {
        
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey.count > 0 ? user_apikey : "7bd679c21b8edcc185d1b6859c2e56ad" ,"user_id":user_id.count > 0 ? user_id: "CUSGUS","zodic_id":ZodiacID]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        // AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.HOROSCOPE.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        // AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            self.arrhoroscopeDiscription = [[String:Any]]()
                                            if let arrSliderImages = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrhoroscope1 = arrSliderImages
                                            }
                                            print("arrhoroscope is:- ",self.arrhoroscope1)
                                            
                                            for i in 0..<self.arrhoroscope1.count
                                            {
                                                let dict_Users = self.arrhoroscope1[i]
                                                self.arrhoroscopeDiscription = (dict_Users["discription"] as? [[String:Any]])!
                                                
                                            }
                                            
                                            self.tbl_dashboard.reloadData()
                                            self.tbl_dashboard.isHidden = false
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
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 2
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        if section==0
            
        {
            return 1
            
        }
            
        else
        {
            return self.arrhoroscopeDiscription.count
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let VisitedCell = tableView.dequeueReusableCell(withIdentifier: "VisitedCell", for: indexPath) as! VisitedCell
            
            VisitedCell.colletionVisited.tag=1
            VisitedCell.colletionVisited.delegate = self
            VisitedCell.colletionVisited.dataSource = self
            VisitedCell.colletionVisited.reloadData()
            return VisitedCell
        }
        else
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
            
            cell_Add.view_back.layer.shadowColor = UIColor.lightGray.cgColor
            cell_Add.view_back.layer.shadowOpacity = 5.0
            cell_Add.view_back.layer.shadowRadius = 5.0
            cell_Add.view_back.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
            cell_Add.view_back.layer.masksToBounds = false
            cell_Add.view_back.layer.cornerRadius = 5.0
            
            
            let dict_eventpoll = self.arrhoroscopeDiscription[indexPath.row]
            let name=dict_eventpoll["name"] as! String
            let date=dict_eventpoll["discription"] as! String
            
            //let url = Constants.BASE_URL + Image
            
            cell_Add.lbl_blogdescription.textAlignment = .center
            cell_Add.lbl_blogtitle.text =  name
            cell_Add.lbl_blogdescription.text =  date
            
            return cell_Add
            
        }
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    //****************************************************
    // MARK: - Collectionview Method
    //****************************************************
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        
        return  1
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return 1//self.return_Response.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VisitedCollectionCell", for: indexPath) as? VisitedCollectionCell
        
        
        
//        let dict_eventpoll = self.return_Response[indexPath.row]
//        let str_IsSelectedDeselected = dict_eventpoll["isSelectedDeselected"] as! String
//
//        cell?.btn_click.tag = indexPath.row
//        cell?.btn_click.addTarget(self, action: #selector(btn_IsSelectedDeseleced(_:)), for: .touchUpInside)
        
        cell!.view_back.layer.cornerRadius = 8.0
        
        let Image=selectedZodiac["zodiac_category_img"] as! String
        let name=selectedZodiac["zodiac_category_name"] as! String
        let date=selectedZodiac["cms_zodiac_cms_date"] as! String
        
        let ind = indexPath.row
        
        
        
        //selectedRow = sender.tag
//
//        if str_IsSelectedDeselected == "0"
//        {
//
            cell!.view_back!.backgroundColor = UIColor .white
            cell?.lbl1?.textColor = UIColor .black
            cell?.lbl2?.textColor = UIColor .black
//            //cell.lbl_Groupmember?.textColor = UIColor .init(red: 243.0/255.0, green: 50.0/255.0, blue: 115.0/255.0, alpha: 1.0)
//        }
//        else
//        {
//
//            cell!.view_back!.backgroundColor = UIColor (red: 255.0/255.0, green: 123.0/255.0, blue: 24.0/255.0, alpha: 1.0)
//            cell!.view_back.clipsToBounds = true
//            cell?.lbl1?.textColor = UIColor .white
//            cell?.lbl2?.textColor = UIColor .white
//            //cell.lbl_Groupmember?.textColor = UIColor .white
//        }
        
        
        if ind == selectedRow
        {
            cell!.view_back!.backgroundColor = UIColor (red: 255.0/255.0, green: 123.0/255.0, blue: 24.0/255.0, alpha: 1.0)
            cell!.view_back.clipsToBounds = true
            cell?.lbl1?.textColor = UIColor .white
            cell?.lbl2?.textColor = UIColor .white
        }
        
        
        cell?.img_Category.sd_setImage(with: URL(string: Image), placeholderImage: UIImage(named: "Placeholder.png"))
        cell?.lbl1.text =  name
        cell?.lbl2.text =  date
        
        return cell!
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        //              let dict_eventpoll = self.arrhoroscope[indexPath.row]
        //              ZodiacID = dict_eventpoll["cms_zodiac_cms_id"] as! String
        //
        //              self.horoscopeUserIdApiCallMethods()
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: 96, height: 91)
        
        
        
    }
    @IBAction func btn_IsSelectedDeseleced(_ sender: UIButton)
        
    {
        
        print(return_Response)
        
        selectedRow = 10000
        
        let dict_eventpoll = self.arrhoroscope[sender.tag]
        ZodiacID = dict_eventpoll["cms_zodiac_cms_id"] as! String
        ZodiacName = dict_eventpoll["zodiac_category_name"] as! String
        let headername = "  " + ZodiacName
        
        btntop.setTitle(headername,for: .normal)
        self.horoscopeUserIdApiCallMethods()
        
        
        let str_UsersID = return_Response[sender.tag]["cms_zodiac_cms_id"] as! String
        
        
        print(str_UsersID)
        //        int_AddGroupId = return_Response[sender.tag]["id"] as! Int
        for i in 0..<arrhoroscope.count
        {
            print(arrhoroscope)
            
            let str_UsersSelectedID = arrhoroscope[i]["cms_zodiac_cms_id"] as! String
            
            print(str_UsersSelectedID)
            if str_UsersSelectedID == str_UsersID
            {
                var dict_IsSelectedDeselected =  arrhoroscope[i]
                print("dict_IsSelectedDeselected is:-",dict_IsSelectedDeselected)
                dict_IsSelectedDeselected["isSelectedDeselected"] = "1"
                arrhoroscope[i] = dict_IsSelectedDeselected
                
            }
            else
            {
                var dict_IsSelectedDeselected =  arrhoroscope[i]
                print("dict_IsSelectedDeselected is:-",dict_IsSelectedDeselected)
                dict_IsSelectedDeselected["isSelectedDeselected"] = "0"
                
                arrhoroscope[i] = dict_IsSelectedDeselected
            }
        }
        return_Response = arrhoroscope
        print(return_Response)
        
        
        tbl_dashboard.reloadData()
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
