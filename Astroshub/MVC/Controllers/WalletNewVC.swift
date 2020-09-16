//
//  WalletNewVC.swift
//  Astroshub
//
//  Created by Kriscent on 21/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class WalletNewVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var tbl_timeslot: UITableView!
    @IBOutlet var lbl_amount: UILabel!
    var arrWaletList = [[String:Any]]()
    var return_Response1 = [[String:Any]]()
    var index_value = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_timeslot.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.walletApiCallMethods()
    }
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func walletApiCallMethods() {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id,"location":CurrentLocation]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.RECHARGE.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            self.arrWaletList = [[String:Any]]()
                                            
                                            self.return_Response1 = [[String:Any]]()
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            
                                            
                                            let amount = dict_Data["wallet"] as! String
                                            let amount1 = String(amount)
                                            self.lbl_amount.text = "Available Balance: " + amount1
                                            
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=dict_Data["recharge"] as! [[String:Any]]
                                            
                                            for i in 0..<arrProducts.count
                                            {
                                                var dict_Products = arrProducts[i]
                                                dict_Products["isSelectedDeselected"] = "0"
                                                dict_Products["id"] = i+1
                                                self.index_value = i
                                                
                                                self.arrWaletList.append(dict_Products)
                                            }
                                            
                                            self.return_Response1 = self.arrWaletList
                                            print("arrTimeList is:- ",self.arrWaletList)
                                            print("return_Response is:- ",self.return_Response1)
                                            
//                                            self.tbl_timeslot.reloadData()
//                                            self.tbl_timeslot.isHidden = false
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                                self.tbl_timeslot.reloadData()
                                                self.tbl_timeslot.isHidden = false
                                            }
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
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 1
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        
        let cell_User3 = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! tablecell
        //set the data here
        //cell_User3.cv.tag = indexPath.row;
        
        cell_User3.cv.delegate = self
        cell_User3.cv.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2)
        {
            cell_User3.consHgtCv.constant = cell_User3.cv.contentSize.height + 400
            //cell_User3.cv.contentSize.height + 100
        }
        
        cell_User3.cv.tag=3
        cell_User3.cv.reloadData()
        return cell_User3
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        
        
        
        return  1
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        
        return self.return_Response1.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionCell
        
        let dict_eventpoll = self.return_Response1[indexPath.row]
        
        
        
        let str_IsSelectedDeselected = dict_eventpoll["isSelectedDeselected"] as! String
        print("str_IsSelectedDeselected is:-",str_IsSelectedDeselected)
        
        // cell.VIEW1.layer.cornerRadius = 8
        // cell.VIEW1.layer.borderWidth = 2
        // cell.VIEW1.layer.borderColor = UIColor(red: 39/255.0, green: 138/255.0, blue: 163/255.0, alpha: 1.0).cgColor
        
        if str_IsSelectedDeselected == "0"
        {
            cell.VIEW1.layer.cornerRadius = 6
            cell.VIEW1.layer.borderWidth = 1
            cell.VIEW1.layer.borderColor = UIColor .black.cgColor
            // cell.VIEW1.backgroundColor = UIColor .white
            cell.lbl_UserName.textColor = UIColor .black
            //cell.lbl_Groupmember?.textColor = UIColor .init(red: 243.0/255.0, green: 50.0/255.0, blue: 115.0/255.0, alpha: 1.0)
        }
        else
        {
            cell.VIEW1.backgroundColor = UIColor (red: 31.0/255.0, green: 130.0/255.0, blue: 162.0/255.0, alpha: 1.0)
            cell.VIEW1.layer.borderWidth = 0
            cell.VIEW1.layer.cornerRadius = 6
            cell.lbl_UserName.textColor = UIColor .white
            //cell.lbl_Groupmember?.textColor = UIColor .white
        }
        
        let time = dict_eventpoll["wallet_amount"] as! String
        let currency = dict_eventpoll["currency"] as! String
        
        dollar = currency
        
        cell.lbl_UserName.text = "+ " + currency + " " + time
        
        cell.btn_click.tag = indexPath.row
        cell.btn_click.addTarget(self, action: #selector(btn_selection(_:)), for: .touchUpInside)
        
        
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (collectionView.bounds.size.width)/2.2   , height: 57);
        
        //  return CGSize(width: 119, height: 57)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
        
        
        
    }
    @IBAction func btn_selection(_ sender: UIButton)
        
    {
        let dict_eventpoll = self.return_Response1[sender.tag]
        OnTabWalletAmount = dict_eventpoll["wallet_amount"] as! String
        let PaymentInfo = self.storyboard?.instantiateViewController(withIdentifier: "PaymentInfoVC")
        self.navigationController?.pushViewController(PaymentInfo!, animated: true)
        
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
}
