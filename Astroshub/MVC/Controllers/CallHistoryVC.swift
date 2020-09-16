//
//  CallHistoryVC.swift
//  Astroshub
//
//  Created by Kriscent on 08/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class CallHistoryVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_callhistory: UITableView!
    var arrCallHistory = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_callhistory.tableFooterView = UIView()
        
         
         


        
       view_top.layer.shadowColor = UIColor.lightGray.cgColor
       view_top.layer.shadowOpacity = 5.0
       view_top.layer.shadowRadius = 5.0
       view_top.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
       view_top.layer.masksToBounds = false
       //view_top.layer.cornerRadius = 5.0
        
        self.callHistoryApiCallMethods()

        // Do any additional setup after loading the view.
    }
    

    //****************************************************
    // MARK: - Custom Method
    //****************************************************

    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func callHistoryApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"astrologer_id":user_id ,"astrologer_api_key":user_apikey]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("astroCallHistory", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            if let arrtimeslot = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrCallHistory = arrtimeslot
                                            }
                                            print("arrBlogs is:- ",self.arrCallHistory)

                                            self.tbl_callhistory.reloadData()
                                            

                                            
                                        }
                                            
                                        else
                                        {
                                                self.tbl_callhistory.isHidden = true
                                            
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
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
       {
           return 249
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
       {
           
        return self.arrCallHistory.count
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "CallHistoryCell", for: indexPath) as! CallHistoryCell
            cell_Add.view1.layer.shadowColor = UIColor.lightGray.cgColor
            cell_Add.view1.layer.shadowOpacity = 5.0
            cell_Add.view1.layer.shadowRadius = 5.0
            cell_Add.view1.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
            cell_Add.view1.layer.masksToBounds = false
            cell_Add.view1.layer.cornerRadius = 5.0
        
           let dict_eventpoll = self.arrCallHistory[indexPath.row]
           let orederid = dict_eventpoll["id"] as! String
           let namee = dict_eventpoll["user_name"] as! String
           let dob = dict_eventpoll["user_dob"] as! String
           let gender = dict_eventpoll["user_gender"] as! String
           let pob = dict_eventpoll["user_pob"] as! String
           let pbarea = dict_eventpoll["problem_area"] as! String
           let ordertime = dict_eventpoll["order_date"] as! String
           let duration = dict_eventpoll["duration"] as! Int
           let status = dict_eventpoll["call_status"] as! String
           cell_Add.lbl1.text = orederid
           cell_Add.lbl2.text = namee
           cell_Add.lbl3.text = dob
           cell_Add.lbl4.text = gender
           cell_Add.lbl5.text = pob
           cell_Add.lbl6.text = pbarea
           cell_Add.lbl7.text = ordertime
           cell_Add.lbl8.text = String(duration) + " hours"
        
           if status == "9"
           {
             cell_Add.lbl9.text = "Complete"
             cell_Add.lbl9.textColor = UIColor.green
           }
           else
           {
             cell_Add.lbl9.text = "Pending"
             cell_Add.lbl9.textColor = UIColor.red
           }
          
            
            return cell_Add
           
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
       {
           
           
       }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************

}
class CallHistoryCell: UITableViewCell {

    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!

    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var lbl8: UILabel!
    @IBOutlet weak var lbl9: UILabel!

    @IBOutlet weak var btn_next: UIButton!



    // Initialization code
}
