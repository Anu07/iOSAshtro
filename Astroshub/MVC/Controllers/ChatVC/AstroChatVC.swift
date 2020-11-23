//
//  AstroChatVC.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 03/06/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseFirestore
import Firebase
import SJSwiftSideMenuController

class AstroChatVC: UIViewController {
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var constraintviewBottom: NSLayoutConstraint!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constraintTxtViewHeight: NSLayoutConstraint!
    var allMessages = [AstroMessage]()
    private let helper = ChatHelper()
    
    var firstMessageData = FirstMessageData()
    var sendOnce = true
    var duration = Int()
    var totalduration = Int()
    var timer: Timer?
    var astroFirstMessage = false
    var startTime = ""
    var endTime = ""
    let user = User([:])
    var convesationStarted = false
    var dict:NSDictionary!
    var data :[String:Any]?
    var anotherUserId :String?
    var messageArray : [messageModel] = []
    
    private var datasource = [(String, [AstroMessage])]() {
        didSet {
            tblView?.reloadData()
        }
    }
    
    var thread: ChatThread? {
        didSet {
            listner?.remove()
            listner = nil
            threadListner?.remove()
            threadListner = nil
            allMessages.removeAll()
            datasource.removeAll()
            prepareAndActivateListner()
        }
    }
    
    private var listner: ListenerRegistration?
    private var threadListner: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRequiredObservers()
        self.txtView.delegate = self
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.lblTitle.text = AstrologerNameee
        self.tblView.delegate = self
        self.tblView.dataSource = self
        if data == nil{
            anotherUserId = OnTabfcmUserID
        } else {
            anotherUserId = data!["astroFcmId"] as? String
            AstrologerUniID = data!["astro_uni_id"] as! String
        }
        if anotherUserId == "" {
            anotherUserId = OnTabfcmUserIDD
            
        }
        observeMessage()
        //        self.sendFirstMessage()
        //        observeMessage()
        //        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SingleThreadUpdation"), object: nil, queue: .main) { (notification) in
        //            guard let node = notification.userInfo?["id"] as? String,
        //                node == self.thread?.node else { return }
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        //                self.tblView.reloadData()
        //            }
        //        }
        
        
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationRejected(notification:)), name: Notification.Name("NotificationIdentifierRejected"), object: nil)
        if chatStartorEnd == "Astrologer Accepted Chat Request" {
            chatStartorEnd = ""
            txtView.isUserInteractionEnabled  = true
            btnChat.isUserInteractionEnabled = true
            let dataPrice = data?["price"] as! Array<Any>
            if AstrologerrPrice == "" {
                let chatPrice = dataPrice[0] as! [String:Any]
                if CurrentLocation == "India" {
                    AstrologerrPrice = chatPrice["astro_price_inr"] as! String
                } else {
                    AstrologerrPrice = chatPrice["astro_price_dollar"] as! String
                }
            }
            var callDuration = ""
            if let getPrice = Double(AstrologerrPrice) {
                let value = convertMaximumCallDuration(price: getPrice)
                user.totalSecondsForCall = value.1
                self.totalduration = user.totalSecondsForCall
            }
            astroFirstMessage = true
            self.sendFirstMessage()
            self.setStartTime()
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(callFirstMessage), userInfo: nil, repeats: false)
            Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(callMessageAfter5Min), userInfo: nil, repeats: false)
        } else if chatStartorEnd == "Astrologer Rejected Chat Request" {
//            chatStartorEnd = ""
//            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
//            controller.modalPresentationStyle = .overCurrentContext
//            controller.astroId = AstrologerUniID
//            controller.completionHandler = {
//                print("hell")
//                let refreshAlert = UIAlertController(title: "AstroShubh", message: "Your Review is Added Successfully", preferredStyle: UIAlertController.Style.alert)
//                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
//                                                        {
//                                                            (action: UIAlertAction!) in
//
//
//                                                            self.moveToDashBoardVC()
//                                                            //                                                      self.navigationController?.popToRootViewController(animated: true)
//                                                        }))
//                self.present(refreshAlert, animated: true, completion: nil)
//            }
//            self.present(controller, animated: true, completion: nil)
        
    }
        else {
            txtView.isUserInteractionEnabled  = false
            btnChat.isUserInteractionEnabled = false
        }
        
        
    }
    func convertMaximumCallDuration(price:Double) -> (String,Int) {
        let balance = walletBalanceNew
        if balance < 0 {
            return ("00:00:00",0)
        } else if price == 0 {
            return ("--:--:--",0)
        }
        let maximumTimeInMin = balance/price
        print(maximumTimeInMin)
        print(maximumTimeInMin * 60)
        let maxTimeInSec = Int(maximumTimeInMin * 60)
        return (self.convertMinToHours(min: Int(maximumTimeInMin)),maxTimeInSec)
    }
    
    func convertMinToHours(min:Int) -> String {
        let hours = String(format: "%02d", min/60)
        let minutes = String(format: "%02d", min%60)
        return "\(hours):\(minutes):00"
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if chatStartorEnd == "Astrologer Accepted Chat Request" {
            txtView.isUserInteractionEnabled  = true
            btnChat.isUserInteractionEnabled = true
            astroFirstMessage = true
            data = notification.userInfo as? [String : Any]
            anotherUserId = data!["astroFcmId"] as? String
            self.setStartTime()
            self.sendFirstMessage()
        } else if chatStartorEnd == "Astrologer Rejected Chat Request" {
            setEndTime()
        } else {
            txtView.isUserInteractionEnabled  = false
            btnChat.isUserInteractionEnabled = false
        }
    }
    
    @objc func methodOfReceivedNotificationRejected(notification: Notification) {
        if chatStartorEnd == "Astrologer Rejected Chat Request" {
//            setEndTime()
            self.moveToDashBoardVC()
        } else {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
        controller.modalPresentationStyle = .overCurrentContext
        controller.astroId = AstrologerUniID
        controller.completionHandler = {
            print("hell")
            let refreshAlert = UIAlertController(title: "AstroShubh", message: "Your Review is Added Successfully", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                                                    {
                                                        (action: UIAlertAction!) in
                                                        self.moveToDashBoardVC()
                                                        //                                                      self.navigationController?.popToRootViewController(animated: true)
                                                    }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
        self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    @objc func callFirstMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            CommenModel.showDefaltAlret(strMessage: "Welcome to Astroshubh\nOur expert will be available in 3-4 minutes, We appreciate your patience", controller: self)
        }
    }
    
    @objc func callMessageAfter5Min() {
        if self.astroFirstMessage {
            
            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Oops!! we are extremely sorry. Our astrologer is busy. Please try another astrologer", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                                                    {
                                                        (action: UIAlertAction!) in
                                                        self.duration = 0
                                                        self.func_chatEnd()
                                                    }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    @objc func callMessageForkundliInProgress() {
        CommenModel.showDefaltAlret(strMessage: "Our expert is ready to guide you, please wait for two minutes, meanwhile, our astrologer is preparing your chart.As we value our customer's money. We will start deducting money from the wallet after two minutes only", controller: self)
    }
    
    func observeMessage()
    {
        self.messageArray.removeAll()
        
        let userMessageRef = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(anotherUserId ?? "")
        let userMessageRef1 = Database.database().reference().child("messages").child(anotherUserId ?? "").child(Auth.auth().currentUser!.uid)
        userMessageRef.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(self.anotherUserId ?? "").child(messageId)
            //  messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dict = snapshot.value as? [String: AnyObject] else {
                    return
                }
                self.messageArray.append(messageModel(dict: dict))
                self.tblView.reloadData()
            }, withCancel: nil)
        }, withCancel: nil)
        
//        userMessageRef1.observe(.childAdded, with: { (snapshot) in
//            let UserId = snapshot.key
//            let messagesRef = Database.database().reference().child("messages").child(self.anotherUserId ?? "").child(Auth.auth().currentUser!.uid).child(UserId)
//            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
//
//                guard let dict = snapshot.value as? [String: AnyObject] else {
//                    return
//                }
//                self.messageArray.append(messageModel(dict: dict))
//                self.tblView.reloadData()
//            }, withCancel: nil)
//        }, withCancel: nil)
//
        
    }
    
    
    //MARK: Manage timer
    
    func initializeTimer() {
        self.runTimer()
    }
    
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer()
    {
        self.totalduration -= 1
        self.duration += 1
        if self.totalduration == 0
        {
            self.timer?.invalidate()
            self.timer = nil
            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Your Balance Finished Please Recharge Your Wallet", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                    {
                                                        (action: UIAlertAction!) in
                                                        //end chat api
                                                        self.func_chatEnd()
                                                        
                                                    }))
            self.present(refreshAlert, animated: true, completion: nil)
            return
        }
        //This will decrement(count down)the seconds.
        self.lblTimer.text = self.convertSecToHours(min: totalduration) //This will update the label.
    }
    
    func convertSecToHours(min:Int) -> String {
        let hours = String(format: "%02d", min/3600)
        let minutes = String(format: "%02d", (min/60)%60)
        let sec = String(format: "%02", min%60)
        return "\(hours):\(minutes):\(sec)"
    }
    
    
    private func prepareAndActivateListner() {
        guard let threadUnwrapped = thread else { return }
        listner = FireBase.Reference.threads.document(threadUnwrapped.node)
            .collection(FireBase.Thread.messages).order(by: FireBase.Message.time)
            .addSnapshotListener { [weak self] (snapshot, error) in
                guard let data = snapshot?.documentChanges else { return }
                if threadUnwrapped.justCreated {
                    self?.threadListnerForNew(thread: threadUnwrapped)
                } else {
                    self?.resetMessageInboxCount()
                    
                }
                let newMessages = data.map { AstroMessage($0.document.data()) }
                self?.helper.updateLastSeen(for: threadUnwrapped)
                self?.allMessages.append(contentsOf: newMessages)
                self?.groupMessagesByDate()
            }
    }
    
    private func threadListnerForNew(thread: ChatThread) {
        threadListner = FireBase.Reference.threads.document(thread.node)
            .addSnapshotListener { [weak self] (snapshot, error) in
                guard let data = snapshot?.data() else { return }
                self?.thread?.delegate = self
                self?.thread?.justCreated = false
                let thread = ChatThread(data)
                thread.delegate = self
                self?.thread?.reassign(from: thread)
                self?.tblView.reloadData()
                self?.resetMessageInboxCount()
            }
    }
    
    private func groupMessagesByDate(_ shouldScrollDown: Bool = true) {
        let dictionary = Dictionary(grouping: allMessages) { $0.groupingTime }
        let sorted = dictionary.sorted { $0.value[0].time < $1.value[0].time }
        datasource = sorted
        guard shouldScrollDown else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { self.scrollToBottom() }
    }
    
    func resetMessageInboxCount() {
        if let threadUnwrapped = self.thread {
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0) {
                self.helper.resetReadCount(for: threadUnwrapped)
            }
        }
    }
    
    /// add observesrs for keyboard
    private func addRequiredObservers() {
        let getTap = UITapGestureRecognizer(target: self,
                                            action: #selector(UIInputViewController.dismissKeyboard))
        tblView.addGestureRecognizer(getTap)
        NotificationCenter.default
            .addObserver(self,  selector: #selector(keyboardWillShow(_:)),
                         name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default
            .addObserver(self, selector: #selector(keyboardWillHide),
                         name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setStartTime() {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = Date()
        self.startTime = dateFormatter.string(from: date)
    }
    
    func setEndTime() {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = Date()
        self.endTime = dateFormatter.string(from: date)
    }
    
    //MARK: API
    
    func func_chatEnd() {
        let dateFormatter : DateFormatter = DateFormatter()
        //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "hh:mm a"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        // let interval = date.timeIntervalSince1970
        
        let setparameters = ["app_type":"ios",
                             "app_version":kAppVersion,
                             "user_id":user_id ,
                             "user_api_key":user_apikey,
                             "astrologer_id":AstrologerUniID,
                             "endtime": self.endTime,
                             "starttime":self.startTime,
                             "chat_id": data!["uniqeid"] as? String ?? "",
                             "duration": self.duration,
                             "busy_status":0,
                             "location":CurrentLocation,"end_type": "0"] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("chatEnd", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            let data =  tempDict["data"] as! [String:Any]
                                            let randomcoupon  = data["random_coupon"]
                                            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
                                            controller.modalPresentationStyle = .overCurrentContext
                                            controller.astroId = AstrologerUniID
                                            controller.completionHandler = {
                                                print("hell")
                                                let refreshAlert = UIAlertController(title: "AstroShubh", message: "Your Review is Added Successfully", preferredStyle: UIAlertController.Style.alert)
                                                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                                                                                        {
                                                                                            (action: UIAlertAction!) in
                                                                                            self.moveToDashBoardVC()
                                                                                            //                                                      self.navigationController?.popToRootViewController(animated: true)
                                                                                        }))
                                                self.present(refreshAlert, animated: true, completion: nil)
                                            }
                                            self.present(controller, animated: true, completion: nil)
                                            
                                        }
                                        
                                        else
                                        {
                                            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Something went wrong.", preferredStyle: UIAlertController.Style.alert)
                                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                                                    {
                                                                                        (action: UIAlertAction!) in
                                                                                        //end chat api
                                                                                        self.moveToDashBoardVC()
                                                                                        //                                                    self.navigationController?.popToRootViewController(animated: true)
                                                                                        
                                                                                    }))
                                            self.present(refreshAlert, animated: true, completion: nil)
                                        }
                                        
                                        
                                      }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Something went wrong.", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                    {
                                                        (action: UIAlertAction!) in
                                                        //end chat api
                                                        self.moveToDashBoardVC()
                                                        //                    self.navigationController?.popToRootViewController(animated: true)
                                                        
                                                    }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    func moveToDashBoardVC() {
        
        let months = DateFormatter().monthSymbols
        let days = DateFormatter().weekdaySymbols
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = SJSwiftSideMenuController()
        
        let sideVC_L : SideMenuController = (mainStoryboardIpad.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_L.menuItems = months as NSArray? ?? NSArray()
        
        let sideVC_R : SideMenuController = (mainStoryboardIpad.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_R.menuItems = days as NSArray? ?? NSArray()
        
        let initialViewControlleripad  = mainStoryboardIpad.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        
        SJSwiftSideMenuController.setUpNavigation(rootController: initialViewControlleripad, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)
        
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        
        SJSwiftSideMenuController.enableDimbackground = true
        SJSwiftSideMenuController.leftMenuWidth = 340
        
        let navigationController = UINavigationController(rootViewController: mainVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    // MARK: IBActions
    
    @IBAction func actionBack(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Astroshubh", message: "Are You Sure to end the chat? ", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler:
                                                {
                                                    (action: UIAlertAction!) in
                                                    self.setEndTime();                                           self.func_chatEnd()
                                                }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:
                                                {
                                                    (action: UIAlertAction!) in
                                                    refreshAlert .dismiss(animated: true, completion: nil)
                                                }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func sendFirstMessage() {
        let firstmessage =  "Name : " + (self.data?["user_name"] as! String) + "\n" + "Gender : " + (self.data?["user_gender"] as! String) + "\n" + "Date of Birth : " + (self.data?["user_dob"] as! String) + "\n" + "Date of Time : " +  (self.data?["user_dob"] as! String) + "\n" + "Pob : " +  (self.data?["user_pob"] as! String) + "\n" + "Problem : " +  (self.data?["problem_area"] as! String) + "\n" + "Location : " +  (self.data?["user_pob"] as! String)
        self.sendOnce = false
        
        let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(anotherUserId ?? "")
        let childRef = ref.childByAutoId()
        //            let toId = anotherUserId
        
        let timeStamp = Int(truncating: NSNumber(value: Date().timeIntervalSince1970))
        let values: [String : Any] = ["from":Auth.auth().currentUser!.uid as AnyObject,"message": firstmessage,"seen":"false", "time":ServerValue.timestamp(),"type":"text"]
        
        childRef.updateChildValues(values)
        
        childRef.observe(.childAdded) { (snapshot) in
            
            print(snapshot)
            //                            self.moveToLastComment()
            
        }
        
        
    }
    
    @IBAction func action(_ sender: Any) {
        if sendOnce {
            self.sendFirstMessage()
            self.sendOnce = false
        }
        
        let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(anotherUserId ?? "")
        let childRef = ref.childByAutoId()
        //        let toId = anotherUserId
        
        let timeStamp = Int(truncating: NSNumber(value: Date().timeIntervalSince1970))
        let values: [String : Any] = ["from":Auth.auth().currentUser!.uid as AnyObject,"message": txtView.text!,"seen":"false", "time":ServerValue.timestamp(),"type":"text"]
        childRef.updateChildValues(values)
        
        childRef.observe(.childAdded) { (snapshot) in
            
            print(snapshot)
            //                            self.moveToLastComment()
            
        }
        
        
        
        
        
        
        
    }
}

// MARK: - Tableview datasource
extension AstroChatVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message =  messageArray[indexPath.row].from
        let timestamp = messageArray[indexPath.row].time
        let date = NSDate(timeIntervalSince1970:TimeInterval(Float(timestamp)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        print(date)
        print("formatted date is =  \(dateString)")
        if message == anotherUserId{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecievedTVC", for: indexPath) as! RecievedTVC
            cell.lblTime.text =  dateString
            cell.labelForReceiver.text = messageArray[indexPath.row].message
            return cell
        } else {
            if astroFirstMessage {
                astroFirstMessage = false
                self.initializeTimer()
                self.setStartTime()
                Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(callMessageForkundliInProgress), userInfo: nil, repeats: false)
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "SentTVC", for: indexPath) as! SentTVC
            cell.labelForMsg.text = messageArray[indexPath.row].message
            cell.lblTime.text =  dateString
            return cell
        }
    }
    
}

// MARK: - Tableview Delegate
extension AstroChatVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - textview delegates
extension AstroChatVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        let count = (textView.text.trimmingCharacters(in: .whitespacesAndNewlines).count -
                        range.length + text.trimmingCharacters(in: .whitespacesAndNewlines).count)
        btnChat.isEnabled = count != 0
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let newSize = textView.sizeThatFits(CGSize(width: textView.bounds.width,
                                                   height: CGFloat.greatestFiniteMagnitude))
        constraintTxtViewHeight.constant = newSize.height
    }
}

extension AstroChatVC: ChatThreadDelegate {
    func membersUpdated(of thread: ChatThread) {
        tblView.reloadData()
    }
}


extension UIDataSourceTranslating {
    
    /**
     Last IndexPath of collectionview or tableview
     */
    var lastIndexPath: IndexPath? {
        if let table = self as? UITableView {
            guard table.numberOfSections > 0 else { return nil }
            let section = table.numberOfSections - 1
            return IndexPath(row: (table.numberOfRows(inSection: section) - 1),
                             section:  section)
        }else {
            return nil
        }
    }
}


@objc extension AstroChatVC {
    func scrollToBottom() {
        if allMessages.count == 0 {
            return
        }
        tblView.scrollToRow(at: IndexPath(row: allMessages.count - 1, section: 0), at: .bottom, animated: true)
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 2436:
                    constraintviewBottom.constant = keyboardFrame.cgRectValue.height - 30
                default:
                    constraintviewBottom.constant = keyboardFrame.cgRectValue.height
                }
            }
        }
        view.layoutIfNeeded()
        scrollToBottom()
    }
    
    func keyboardWillHide() {
        constraintviewBottom.constant = 0
        view.layoutIfNeeded()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}






class SentTVC: UITableViewCell {
    
    //    @IBOutlet private weak var viewImage: UIView!
    //    @IBOutlet private weak var imgViewUser: UIImageView!
    //    @IBOutlet  weak var txtViewMessage: UITextView!
    @IBOutlet  weak var lblTime: UILabel!
    //    @IBOutlet private weak var imgViewReadStatus: UIImageView!
    
    @IBOutlet weak var labelForMsg: UILabel!
    
    var thread: ChatThread?
    var shouldHideImage: Bool = false {
        willSet {
            //            viewImage.isHidden = newValue
        }
    }
    
    //    var message: AstroMessage? {
    //        didSet {
    //            txtViewMessage.text = self.message?.content
    //            imgViewUser.sd_setImage(with: URL(string: UserImageurl), placeholderImage: UIImage(named: "user2"))
    //            lblTime.text = Date.formatted(time: self.message?.time ?? 0)
    //            setBuleTick(newTime: Int(self.message?.time ?? 0.0))
    //        }
    //    }
    
    //    func setBuleTick(newTime: Int){
    //        var readcount = 0
    //        guard let lastSeenDict = thread?.threadLastSeen else { return }
    //        if thread?.members.count != lastSeenDict.count{
    //            self.imgViewReadStatus.tintColor = .gray
    //            return
    //        }else{
    //            for (_ , lastSeenTime) in lastSeenDict {
    //                if lastSeenTime < newTime {
    //                    break
    //                } else {
    //                    readcount += 1
    //                }
    //            }
    //            self.imgViewReadStatus.tintColor = lastSeenDict.count == readcount ? .blue : .gray
    //        }
    //
    //    }
    
}

class RecievedTVC: UITableViewCell {
    
    @IBOutlet private weak var viewImage: UIView!
    @IBOutlet private weak var imgViewUser: UIImageView!
    @IBOutlet  weak var txtViewMessage: UITextView!
    @IBOutlet  weak var lblTime: UILabel!
    
    @IBOutlet weak var labelForReceiver: UILabel!
    var thread: ChatThread?
    var shouldHideImage: Bool = false {
        willSet {
            viewImage.isHidden = newValue
        }
    }
    
    //    var message: AstroMessage? {
    //        willSet {
    //            txtViewMessage.text = newValue?.content
    //            imgViewUser.sd_setImage(with: URL(string: (thread?.members.first?.image ?? "")), placeholderImage: UIImage(named: "user2"))
    //            lblTime.text = Date.formatted(time: newValue?.time ?? 0)
    //        }
    //    }
    
}


extension Date {
    static func formatted(time value: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(value))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date).uppercased()
    }
}
class messageModel:NSObject{
    
    var from = ""
    var message = ""
    var seen = ""
    var time = ""
    var type = ""
    
    init(dict: [String: AnyObject]) {
        
        self.from    = "\(dict["from"]!)"
        self.message = "\(dict["message"]!)"
        self.seen    = "\(dict["seen"]!)"
        self.time    = "\(dict["time"]!)"
        self.type    = "\(dict["type"]!)"
        
        
    }
    
}
