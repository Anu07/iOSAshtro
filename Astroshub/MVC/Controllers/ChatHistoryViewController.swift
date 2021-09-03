//
//  ChatHistoryViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 03/06/21.
//  Copyright © 2021 Bhunesh Kahar. All rights reserved.
//

import UIKit

class ChatHistoryViewController: UIViewController {
  
    @IBOutlet weak var tblView: UITableView!
   
    @IBOutlet weak var lblTitle: UILabel!
    var astroId:String?
    
    var dictallData = Array<Any>()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = "Chat History"
        self.func_ChatHistory()
        // Do any additional setup after loading the view.
    }
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func func_ChatHistory() {
        let setparameters = ["user_api_key":user_apikey,"user_id":user_id,"astrologer_id":astroId ?? ""]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("Getmessages", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            let tempDictdata = tempDict.value(forKeyPath: "data") as? [String:Any]
                                            
                                            self.dictallData = tempDictdata?["data"] as? Array<Any> ?? []
                                            print(self.dictallData)
                                            self.tblView.reloadData()
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
// MARK: - Tableview datasource
extension ChatHistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.dictallData.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message =  self.dictallData[indexPath.row] as? [String:Any]
        
        if message?["recipient"] as? String != nil{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SentTVC", for: indexPath) as! SentTVC
            cell.lblTime.text =  ""
//            cell.labelForMsg.text = message?["recipient"] as? String
            if  message?["type"] as? String == "text" {
                cell.labelForMsg.isHidden = false
                cell.imgViewUser.isHidden = true
                cell.labelForMsg.text = message?["recipient"] as? String
                cell.imageHeight?.constant = 0

            } else if message?["type"] as? String == "image" {
                cell.labelForMsg.isHidden = true
                cell.imgViewUser.isHidden = false
                cell.imgViewUser.sd_setImage(with: URL(string: message?["recipient"] as? String ?? "" ), completed: nil)
                cell.imageHeight?.constant = 170
//                let imageTapped = UITapGestureRecognizer(target: self, action: #selector(imageTappedHandler(tap:)))
//                cell.imgViewUser.addGestureRecognizer(imageTapped)
//                cell.imgViewUser.isUserInteractionEnabled = true
            } else {
                cell.labelForMsg.isHidden = false
                cell.imgViewUser.isHidden = true
                cell.labelForMsg.text = message?["recipient"] as? String
                cell.imageHeight?.constant = 0

            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecievedTVC", for: indexPath) as! RecievedTVC
            cell.labelForReceiver.text = message?["sender"] as? String
            cell.lblTime.text =   ""
           
            return cell
        }
    }
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        //            formatter.dateStyle = .long
        //            formatter.timeStyle = .medium
        formatter.dateFormat = "MMM,dd HH:mm"
        
        return formatter.string(from: date as Date)
    }
}

// MARK: - Tableview Delegate
extension ChatHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}


