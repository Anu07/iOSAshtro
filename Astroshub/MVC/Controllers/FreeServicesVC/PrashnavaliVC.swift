//
//  PrashnavaliVC.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 26/09/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class PrashnavaliVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func ButtonImage(_ sender: UIButton) {
        apiForGetPransvlai()
    }
    
    func apiForGetPransvlai() {
        let setparameters = ["user_api_key":user_apikey,"user_id":user_id]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.getParnsavli.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            let dataStatus = dict_Data["status"] as! [String:Any]
                                            let controller = self.storyboard?.instantiateViewController(withIdentifier: "PopUPVC") as! PopUPVC
                                            controller.arrForData.append((dataStatus["dohaMeaning"] as! String))
                                            controller.arrForData.append((dataStatus["doha"] as! String))
                                            controller.arrForData.append((dataStatus["DohaFall"] as! String))
                                            self.navigationController?.present(controller, animated: true)
//                                            let alertMessage = UIAlertController(title:(dataStatus["dohaMeaning"] as! String), message:String(format: "%@/n %@",  (dataStatus["doha"] as! String), (dataStatus["DohaFall"] as! String)), preferredStyle: UIAlertController.Style.alert)
//
//                                            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                                                //                                                        NotificationCenter.default.post(name: Notification.Name("OkTapped"), object: nil)
//                                            }))
//                                            self.present(alertMessage, animated: true, completion: nil)
                                            
                                            
                                            //                                                self.arrWaletList = [[String:Any]]()
                                            //
                                            //                                                self.return_Response1 = [[String:Any]]()
                                            //                                                let dict_Data = tempDict["data"] as! [String:Any]
                                            //                                                print("dict_Data is:- ",dict_Data)
                                            //
                                            //
                                            //                                                let amount = dict_Data["wallet"] as! String
                                            //                                                let amount1 = String(amount)
                                            //                                                self.lbl_amount.text = "Available Balance: " + amount1
                                            //
                                            //                                                var arrProducts = [[String:Any]]()
                                            //                                                arrProducts=dict_Data["recharge"] as! [[String:Any]]
                                            //
                                            //                                                for i in 0..<arrProducts.count
                                            //                                                {
                                            //                                                    var dict_Products = arrProducts[i]
                                            //                                                    dict_Products["isSelectedDeselected"] = "0"
                                            //                                                    dict_Products["id"] = i+1
                                            //                                                    self.index_value = i
                                            //
                                            //                                                    self.arrWaletList.append(dict_Products)
                                            //                                                }
                                            //
                                            //                                                self.return_Response1 = self.arrWaletList
                                            //                                                print("arrTimeList is:- ",self.arrWaletList)
                                            //                                                print("return_Response is:- ",self.return_Response1)
                                            //
                                            //    //                                            self.tbl_timeslot.reloadData()
                                            //    //                                            self.tbl_timeslot.isHidden = false
                                            //
                                            //                                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                            //                                                    self.tbl_timeslot.reloadData()
                                            //                                                    self.tbl_timeslot.isHidden = false
                                            //                                                }
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
