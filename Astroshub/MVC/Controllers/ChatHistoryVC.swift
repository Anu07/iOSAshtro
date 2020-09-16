//
//  ChatHistoryVC.swift
//  Astroshub
//
//  Created by Kriscent on 08/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
//import JSQMessagesViewController

class ChatHistoryVC: UIViewController ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate{
    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txt_message: UITextField!
    @IBOutlet weak var btn_backk: UIButton!
    var cellIdentifier = "SenderCell"
    var arrSaveDataListadd = [[String:Any]]()
    @IBOutlet weak var lbl_time: UILabel!
    //var dict:NSMutableDictionary!
    let arrMsg = NSMutableArray()
    
    var postData = [String]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    let arrUserList = NSMutableArray()
    
    var messages = [Message]()
    
    var newmessages = [MessageNew]()
    
    var messageDictionary = [String:Message]()
    
    
    
    var arrSortedchatList = [[String:Any]]()
    var time: NSNumber?
    var CurrentChatTime = Int()
    var duration = Int()
    var totalduration = Int()
    var timer:Timer?
    var isTimerRunning = false
    var channelRef: DatabaseReference?
    var StartTime = ""
    
    
    
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dateFormatter : DateFormatter = DateFormatter()
        //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = Date()
        StartTime = dateFormatter.string(from: date)
        
        CurrentChatTime = Int(ChatTime)!
        
        self.runTimer()
        // lbl_time.text = TiiiiimeString(time: TimeInterval(CurrentChatTime))
        
        let seconds = NSDate().timeIntervalSince1970
        let milliseconds = seconds * 1000.0
        
        print(milliseconds)
        
        view_top.layer.shadowColor = UIColor.lightGray.cgColor
        view_top.layer.shadowOpacity = 5.0
        view_top.layer.shadowRadius = 5.0
        view_top.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        view_top.layer.masksToBounds = false
        // view_top.layer.cornerRadius = 5.0
        
        let name = "  " + AstrologerNameee
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.FirtMessage()
        
        
        btn_backk.setTitle(name,for: .normal)
        arrchatList = [[String:Any]]()
        
        let toId = OnTabfcmUserID
        let fromId = Auth.auth().currentUser!.uid
        ref = Database.database().reference().child("messages").child(fromId).child(toId)
        
        arrchatList = [[String:Any]]()
        
        self.observeMessage()
        // Finalmessages.append(message)
        Finalmessages.sort { (Double($0.timestamp!)) < (Double($1.timestamp!)) }
        
        //self.messages = Finalmessages
        // self.moveToLastComment()
        self.tableView.reloadData()
        
        ref!.observe(.childAdded) { (snapshot) in
            //  self.observeMessage()
            self.moveToLastComment()
            
        }
        ref!.observe(.childChanged) { (snapshot) in
            self.moveToLastComment()
            
        }
        ref!.observe(.childRemoved) { (snapshot) in
            self.moveToLastComment()
            
        }
        
    }
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer()
    {
        CurrentChatTime -= 1
        
        duration = Int(ChatTime)! - CurrentChatTime
        //totalduration = 1
        
        
        
        if CurrentChatTime == 0
        {
            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Your Balance Finished Please Recharge Your Wallet", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                {
                    (action: UIAlertAction!) in
                    //            self.navigationController?.popToRootViewController(animated: true)
                    
                    //self.rechargeFun()
                    self.backFun()
            }))
            //            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:
            //                {
            //                    (action: UIAlertAction!) in
            //                     self.rechargecancelFun()
            //
            //            }))
            //
            self.present(refreshAlert, animated: true, completion: nil)
            return
        }
        //This will decrement(count down)the seconds.
        self.lbl_time.text = "\(TiiiiimeString(time: TimeInterval(CurrentChatTime)))" //This will update the label.
    }
    func rechargeFun()
    {
        let WalletNew = self.storyboard?.instantiateViewController(withIdentifier: "WalletNewVC")
        self.navigationController?.pushViewController(WalletNew!, animated: true)
    }
    func rechargecancelFun()
    {
        let Dash = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC")
        self.navigationController?.pushViewController(Dash!, animated: false)
    }
    func TiiiiimeString(time: TimeInterval) -> String
    {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        // return formated string
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
    func FirtMessage()
    {
        
        //UsersendFirstData
        
        let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(OnTabfcmUserID)
        let childRef = ref.childByAutoId()
        let toId = OnTabfcmUserID
        let fromId = Auth.auth().currentUser!.uid
        
        
        
        
        let timeStamp = Int(truncating: NSNumber(value: Date().timeIntervalSince1970))
        //let timeStamp = Int(1000 * Date().timeIntervalSince1970)
        let Name =  UsersendFirstData["Name"] as! String
        let Gender =  UsersendFirstData["Gender"] as! String
        let DateofBirth =  UsersendFirstData["Date of Birth"] as! String
        let DateofTime =  UsersendFirstData["Date of Time"] as! String
        let Pob =  UsersendFirstData["Pob"] as! String
        let Problem =  UsersendFirstData["Problem"] as! String
        let Location =  UsersendFirstData["Location"] as! String
        
        
        let string =  "Name : " + Name + "\n" + "Gender : " + Gender + "\n" + "Date of Birth : " + DateofBirth + "\n" + "Date of Time : " +  DateofTime + "\n" + "Pob : " +  Pob + "\n" + "Problem : " +  Problem + "\n" + "Location : " +  Location
        
        
        let string1 = string.replacingOccurrences(of: "/n", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        print(string1)
        
        //let test = String(string.filter { !"/n".contains($0) })
        
        // "app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue"
        
        let values: [String : Any] = ["from":fromId as AnyObject,"message": string1,"seen":"false", "time":timeStamp as Any,"type":"text"]
        
        childRef.updateChildValues(values)
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            self.txt_message.text = ""
            let userMessageRef = Database.database().reference().child("user-messages").child(fromId).child(toId)
            let messageId = childRef.key
            userMessageRef.updateChildValues([messageId: 1])
            
            let recipentUserMessageRef = Database.database().reference().child("user-messages").child(toId).child(fromId)
            recipentUserMessageRef.updateChildValues([messageId: 1])
        }
    }
    
    func observeMessage() {
        //  let toIdd = OnTabfcmUserID
        guard let uid = Auth.auth().currentUser?.uid ,let toIdd = OnTabfcmUserIDD  else {
            return
        }
        
        let userMessageRef = Database.database().reference().child("messages").child(uid).child(toIdd)
        let userMessageRef1 = Database.database().reference().child("messages").child(toIdd).child(uid)
        userMessageRef.observe(.childAdded, with: { (snapshot) in
            let UserId = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(uid).child(toIdd).child(UserId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dict = snapshot.value as? [String: AnyObject] else {
                    return
                }
                let message = Message(fromDictionary: dict)
                //let Mess = dict["message"] as! String
                //message.setValuesForKeys(dict)
                // arrchatList.append(dict)
                self.messages.append(message)
                self.messages.sort { (Double($0.timestamp!)) < (Double($1.timestamp!)) }
                DispatchQueue.main.async {
                    self.sortedobserveUserMessages()
                    self.moveToLastComment()
                    
                }
            }, withCancel: nil)
        }, withCancel: nil)
        userMessageRef1.observe(.childAdded, with: { (snapshot) in
            let UserId = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(toIdd).child(uid).child(UserId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dict = snapshot.value as? [String: AnyObject] else {
                    return
                }
                let message = Message(fromDictionary: dict)
                //let Mess = dict["message"] as! String
                //message.setValuesForKeys(dict)
                // arrchatList.append(dict)
                self.messages.append(message)
                self.messages.sort { (Double($0.timestamp!)) < (Double($1.timestamp!)) }
                
                DispatchQueue.main.async {
                    
                    self.sortedobserveUserMessages()
                    self.moveToLastComment()
                    
                    
                }
            }, withCancel: nil)
        }, withCancel: nil)
        
        
        
        
        // self.sortedobserveUserMessages()
    }
    
    
    func sortedobserveUserMessages()
    {
        
        messages.sort { (Double($0.timestamp!)) < (Double($1.timestamp!)) }
        self.moveToLastComment()
        self.tableView.reloadData()
        
        
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    func getCurrentTimeStamp() -> String {
        return "\(Double(NSDate().timeIntervalSince1970 * 1000))"
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: arrchatList.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    func convertIntoJSONString(arrayObject: [Any]) -> String? {
        
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }
            
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    
    func func_bulkchatInsert() {
        
        let jsonString = convertIntoJSONString(arrayObject: arrSaveDataListadd)
        print("jsonString - \(jsonString ?? "nil")")
        
        let setparameters = [
            "app_type":"ios",
            "app_version":"1.0",
            "user_id":user_id ,
            "user_api_key":user_apikey,
            "data":jsonString
            
        ]
        print(setparameters)
        var _: Error? = nil
        let str_FullUrl = "bulkChatInsert"
        print("str_FullUrl is:-",str_FullUrl)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(str_FullUrl, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        //AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            // self.doctorScheduledaysApiCallMethods()
                                            // CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                            self.func_chatEnd()
                                            
                                            
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
    func func_chatEnd() {
        
        
        
        let dateFormatter : DateFormatter = DateFormatter()
        //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        // let interval = date.timeIntervalSince1970
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"astrologer_id":AstrologerUniID,"endtime":dateString,"starttime":StartTime,"chat_id":ChatuNIQid,"duration":duration] as [String : Any]
        
        print(setparameters)
        //AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("chatEnd", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            //let Dash = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC")
                                            
                                            // self.navigationController?.pushViewController(Dash!, animated: false)
                                            
                                            
                                            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showpopUp") as! showpopUp
                                            
                                            self.addChild(popOverVC)
                                            popOverVC.view.frame = self.view.frame
                                            self.view.addSubview(popOverVC.view)
                                            popOverVC.didMove(toParent: self)
                                            
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
        // self.navigationController?.popViewController(animated: true)
        
        let refreshAlert = UIAlertController(title: "Astroshubh", message: "Do you want to close Your Chat", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
            {
                (action: UIAlertAction!) in
                //            self.navigationController?.popToRootViewController(animated: true)
                
                self.backFun()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:
            {
                (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
    }
    func backFun()
    {
        //self.getmessagesss()
        //self.func_bulkchatInsert()
        self.reloadmessagesss()
        
    }
    
    func getmessagesss()
    {
        //        guard let uid = Auth.auth().currentUser?.uid ,let toIdd = OnTabfcmUserIDD  else {
        //            return
        //        }
        //
        //        let userMessageRef = Database.database().reference().child("messages").child(uid).child(toIdd)
        //        let userMessageRef1 = Database.database().reference().child("messages").child(toIdd).child(uid)
        //        userMessageRef.observe(.childAdded, with: { (snapshot) in
        //            let UserId = snapshot.key
        //            let messagesRef = Database.database().reference().child("messages").child(uid).child(toIdd).child(UserId)
        //            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
        //
        //                guard let dict = snapshot.value as? [String: AnyObject] else {
        //                    return
        //                }
        //                let message = Message(fromDictionary: dict)
        //
        //                self.messages.append(message)
        //                self.reloadmessagesss()
        //               // self.messages.sort { (Double($0.timestamp!)) < (Double($1.timestamp!)) }
        //
        //            }, withCancel: nil)
        //        }, withCancel: nil)
        //        userMessageRef1.observe(.childAdded, with: { (snapshot) in
        //            let UserId = snapshot.key
        //            let messagesRef = Database.database().reference().child("messages").child(toIdd).child(uid).child(UserId)
        //            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
        //
        //                guard let dict = snapshot.value as? [String: AnyObject] else {
        //                    return
        //                }
        //                let message = Message(fromDictionary: dict)
        //                self.reloadmessagesss()
        //                self.messages.append(message)
        //              //  self.messages.sort { (Double($0.timestamp!)) < (Double($1.timestamp!)) }
        //
        //
        //            }, withCancel: nil)
        //        }, withCancel: nil)
        //
        
    }
    
    func reloadmessagesss()
    {
        for j in 0..<self.messages.count
        {
            
            let dict2 = self.messages[j]
            // let checkeddddd = dict2["checked"] as! Int
            let message = dict2.text
            let dict = [
                "uniqeid" : ChatuNIQid,
                "chat_by_id" : user_id,
                "chat_for_id" : AstrologerUniID,
                "msg" : message ?? "nil",
                "created_at" : ChatCreatedat
                ] as [String : Any]
            arrSaveDataListadd.append(dict)
            
        }
        
        
        print(arrSaveDataListadd)
        
        self.func_bulkchatInsert()
    }
    
    
    //****************************************************
    // MARK: - Table Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return  self.messages.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        
        let dictttt =  self.messages[indexPath.row]
        let fromId = dictttt.fromId
        
        
        
        
        if  fcmUserID == fromId
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ChatTableViewCell
            //let cell = tableView.dequeueReusableCell(withIdentifier: CellIdetifier.reciever.rawValue) as! ChatTableViewCell
            let model =  self.messages[indexPath.row]
            
            let timestamp = model.timestamp
            
            
            let date = NSDate(timeIntervalSince1970:TimeInterval(timestamp!))
            
            //Date formatting
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:a"
            dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
            let dateString = dateFormatter.string(from: date as Date)
            
            cell.lblTime.text =  dateString
            
            
            cell.lblText.text =  model.text
            return cell
        }
        else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdetifier.reciever.rawValue) as! ChatTableViewCell
            let dict = self.messages[indexPath.row]
            
            let timestamp = dict.timestamp
            
            let date = NSDate(timeIntervalSince1970:TimeInterval(timestamp!))
            
            //Date formatting
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:a"
            dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
            let dateString = dateFormatter.string(from: date as Date)
            
            cell.lblTime.text =  dateString
            
            cell.lblText.text =  dict.text
            return cell
        }
        
        
        
    }
    enum CellIdetifier: String
    {
        case sender = "SenderCell",
        reciever = "RecieverCell"
        //reciever1 = "RecieverCellMessaging"
    }
    
    @IBAction func btn_SendAction(_ sender: Any)
    {
        if (txt_message.text == "" || txt_message.text == " ")
        {
            let alert = UIAlertController(title: "Alert", message: "Please type a Message", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
            //                let myApplication = UIApplication.shared.delegate as! AppDelegate
            //                myApplication.registerAPNSServicesForApplication(UIApplication.shared) { (granted) -> (Void) in
            //
            //                    if #available(iOS 10.0, *) {
            //
            //                        if granted {
            //
            //                        }else {
            //
            //                        }
            //
            //                    }else {
            //
            //                        // will not be returned because iOS 9 has no completion block for granting the permission it will require special way.
            //
            //                    }
            //
            //                }
            
            
            let sender = PushNotificationSender()
            sender.sendPushNotification(to: OnTabfcmUserTOKEN, title: setCustomername, body: txt_message.text!)
            
            let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(OnTabfcmUserID)
            let childRef = ref.childByAutoId()
            let toId = OnTabfcmUserID
            let fromId = Auth.auth().currentUser!.uid
            
            
            let timeStamp = Int(truncating: NSNumber(value: Date().timeIntervalSince1970))
            //let timeStamp = Int(1000 * Date().timeIntervalSince1970)
            
            let values: [String : Any] = ["from":fromId as AnyObject,"message": txt_message.text!,"seen":"false", "time":timeStamp as Any,"type":"text"]
            
            childRef.updateChildValues(values)
            
            childRef.updateChildValues(values) { (error, ref) in
                if error != nil {
                    print(error!)
                    return
                }
                self.txt_message.text = ""
                let userMessageRef = Database.database().reference().child("user-messages").child(fromId).child(toId)
                let messageId = childRef.key
                userMessageRef.updateChildValues([messageId: 1])
                
                let recipentUserMessageRef = Database.database().reference().child("user-messages").child(toId).child(fromId)
                recipentUserMessageRef.updateChildValues([messageId: 1])
            }
            childRef.observe(.childAdded) { (snapshot) in
                
                print(snapshot)
                self.moveToLastComment()
                
            }
            
            
            
            
        }
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // self.sortedobserveUserMessages()
        moveToLastComment()
    }
    
    
    func moveToLastComment() {
        if self.tableView.contentSize.height > self.tableView.frame.height {
            // First figure out how many sections there are
            let lastSectionIndex = self.tableView!.numberOfSections - 1
            
            // Then grab the number of rows in the last section
            let lastRowIndex = self.tableView!.numberOfRows(inSection: lastSectionIndex) - 1
            
            // Now just construct the index path
            let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
            
            // Make the last row visible
            self.tableView?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
    }
    
}

//****************************************************
// MARK: - Memory CleanUP
//****************************************************


class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var lblText1: UILabel!
}
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970)
    }
}
