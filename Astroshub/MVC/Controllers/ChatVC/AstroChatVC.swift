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
import CoreServices
import FirebaseStorage
//@available(iOS 13.0, *)
class AstroChatVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var stopTimer: Timer?
    var typingTimer: Timer?
    var valueRef = ""
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var constraintviewBottom: NSLayoutConstraint!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblForTyping: UILabel!

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
    let store = Storage.storage()
    let storeRef = Storage.storage().reference()
    private var datasource = [(String, [AstroMessage])]() {
        didSet {
            tblView?.reloadData()
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
//        observeMessageForTyping()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(callFirstMessage), userInfo: nil, repeats: false)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationRejected(notification:)), name: Notification.Name("NotificationIdentifierRejected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationEnded(notification:)), name: Notification.Name("NotificationIdentifierEnded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object:  nil)
        self.timer =  Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(self.callMessageAfter5Min), userInfo: nil, repeats: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //observeTyping()
        moveToLastComment()
        //self.observeUserMessages()
        
    }
    
    // MARK:- Typing Status Methods
    func sendIsTypingStatus() {
        
        if self.typingTimer == nil {
            let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(valueRef)
            print(ref)
            ref.updateChildValues(["isTypingUser": true])

            //self.viewModel.typingRoom(true)
        }
        
        self.removeTimerFunctionsForTyping()
        
        self.typingTimer = Timer.scheduledTimer(timeInterval: 4.0,
                                                target: self,
                                                selector: #selector(invalidateTypingTimer),
                                                userInfo: nil,
                                                repeats: false)
        
        self.stopTimer = Timer.scheduledTimer(timeInterval: 6.0,
                                              target: self,
                                              selector: #selector(stopTyping),
                                              userInfo: nil,
                                              repeats: false)
    }
    
    @objc func stopTyping() {
        self.removeTimerFunctionsForTyping()
        let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(valueRef)
        ref.updateChildValues(["isTypingUser": false])
    }
    
    @objc private func invalidateTypingTimer() {
        typingTimer?.invalidate()
        typingTimer = nil
    }
    
    func removeTimerFunctionsForTyping() {
        self.typingTimer?.invalidate()
        self.typingTimer = nil
        self.stopTimer?.invalidate()
        self.stopTimer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moveToLastComment()
        
        
        if chatStartorEnd == "Astrologer Accepted Chat Request" {
          
            if self.astroFirstMessage == true {
                
            } else  {
                self.timer?.invalidate()
                self.timer = nil
                txtView.isUserInteractionEnabled  = true
                btnChat.isUserInteractionEnabled = true
                if AstrologerrPrice == "" {
                    let dataPrice = data?["price"] as? Array<Any>
                    let chatPrice = dataPrice?[0] as? [String:Any]
                    if CurrentLocation == "India" {
                        AstrologerrPrice = chatPrice?["astro_price_inr"] as? String ?? ""
                    } else {
                        AstrologerrPrice = chatPrice?["astro_price_dollar"] as? String ?? ""
                    }
                }
                var callDuration = ""
                if self.totalduration == 0 {
                    if let getPrice = Double(AstrologerrPrice) {
                        let value = convertMaximumCallDuration(price: getPrice)
                        user.totalSecondsForCall = value.1
                        self.totalduration = user.totalSecondsForCall
                    }
                }
                astroFirstMessage = true
                if sendOnce {
                    self.sendFirstMessage()
                    self.sendOnce = false
                    //                let duration = UserDefaults.standard.value(forKey: "duration") as? Int
                    //                self.totalduration = duration ?? 0
                    self.initializeTimer()
                }
                //            self.sendFirstMessage()
                self.setStartTime()
            }
        } else if chatStartorEnd == "Astrologer Rejected Chat Request" || chatStartorEnd == "Chat Request Rejected"{
            //            chatStartorEnd = ""
//            callMessageAfter5Min()
        } else if chatStartorEnd == "Chat Ended" {
            //            chatStartorEnd = ""
//            self.func_chatEndForAstroSide()
        }
        else {
            txtView.isUserInteractionEnabled  = false
            btnChat.isUserInteractionEnabled = false
        }
        
        
    }
    func convertMaximumCallDuration(price:Double) -> (String,Int) {
        let balance = UserDefaults.standard.value(forKey: "balance") as? Double
        //        let balance = walletBalanceNew
        if balance ?? 0.0 < 0 {
            return ("00:00:00",0)
        } else if price == 0 {
            return ("--:--:--",0)
        }
        let maximumTimeInMin = balance ?? 0.0/price
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
            
            if self.astroFirstMessage == true {
                
            } else  {
                self.timer?.invalidate()
                self.timer = nil
                self.txtView.isUserInteractionEnabled  = true
                self.btnChat.isUserInteractionEnabled = true
                self.astroFirstMessage = true
                self.data = notification.userInfo as? [String : Any]
                self.anotherUserId = data!["astroFcmId"] as? String
                self.setStartTime()
                if AstrologerrPrice == "" {
                    let dataPrice =  self.data?["price"] as? Array<Any>
                    let chatPrice = dataPrice?[0] as? [String:Any]
                    if CurrentLocation == "India" {
                        AstrologerrPrice = chatPrice?["astro_price_inr"] as? String ?? ""
                    } else {
                        AstrologerrPrice = chatPrice?["astro_price_dollar"] as? String ?? ""
                    }
                }
                var callDuration = ""
                if  self.totalduration == 0 {
                    if let getPrice = Double(AstrologerrPrice) {
                        let value =  self.convertMaximumCallDuration(price: getPrice)
                        self.user.totalSecondsForCall = value.1
                        self.totalduration =  self.user.totalSecondsForCall
                    }
                }
                //            let duration = data?["duration"] as? String
                //          self.totalduration = Int(duration)
                
                if self.sendOnce {
                    self.sendFirstMessage()
                    self.sendOnce = false
                    //                let duration = UserDefaults.standard.value(forKey: "duration") as? Int
                    //                self.totalduration = duration ?? 0
                    self.initializeTimer()
                }
                //
                //            chatStartorEnd = ""
                
                //
                //                let refreshAlert = UIAlertController(title: "Astroshubh", message: "This chat session will be deleted  for privacy purposes. Please keep the notes of important messages.", preferredStyle: UIAlertController.Style.alert)
                //                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                //                                                        {
                //                                                            (action: UIAlertAction!) in
                //                                                            refreshAlert .dismiss(animated: true, completion: nil)
                //                                                        }))
                //                present(refreshAlert, animated: true, completion: nil)
            }
        } else if chatStartorEnd == "Astrologer Rejected Chat Request"  || chatStartorEnd == "Chat Request Rejected" {
            setEndTime()
//            UserDefaults.standard.setValue("", forKey: "ChatResume")
//            UserDefaults.standard.setValue(false, forKey: "ChatBool")
            //            chatStartorEnd = ""
        } else {
            txtView.isUserInteractionEnabled  = false
            btnChat.isUserInteractionEnabled = false
        }
    }
    
    @objc func methodOfReceivedNotificationRejected(notification: Notification) {
        if chatStartorEnd == "Astrologer Rejected Chat Request"  || chatStartorEnd == "Chat Request Rejected" {
            //            setEndTime()
//            UserDefaults.standard.setValue("", forKey: "ChatResume")
//            UserDefaults.standard.setValue(false, forKey: "ChatBool")
            self.timer?.invalidate()
            self.timer = nil
            self.moveToDashBoardVC()
            //            chatStartorEnd = ""
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
            controller.modalPresentationStyle = .overCurrentContext
            controller.astroId = AstrologerUniID
            controller.strForCloseDisable = "chat"
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
    @objc func methodOfReceivedNotificationEnded(notification: Notification) {
//        UserDefaults.standard.setValue("", forKey: "ChatResume")
//        UserDefaults.standard.setValue(false, forKey: "ChatBool")
        //func_chatEndForAstroSide()
        self.timer?.invalidate()
        self.timer = nil
        self.moveToDashBoardVC()
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
        if self.astroFirstMessage == false {
            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Oops!! we are extremely sorry. Our astrologer is busy. Please try another astrologer", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                                                    {
                                                        (action: UIAlertAction!) in
                                                        self.duration = 0
                                                        self.func_chatEndForAstroSide()
                                                    }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    @objc func callMessageForkundliInProgress() {
        CommenModel.showDefaltAlret(strMessage: "Our expert is ready to guide you, please wait for two minutes, meanwhile, our astrologer is preparing your chart.As we value our customer's money. We will start deducting money from the wallet after one minutes only", controller: self)
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
                
                //                self.scrollToBottom()
                let scrollPoint = CGPoint(x: 0, y: self.tblView.contentSize.height - self.tblView.frame.size.height)
                self.tblView.setContentOffset(scrollPoint, animated: false)
                self.tblView.reloadData()
            }, withCancel: nil)
        }, withCancel: nil)
        
    }
    
    
    //MARK: Manage timer
    
    func initializeTimer() {
        self.runTimer()
    }
    
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer ?? Timer(), forMode: .common)
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
        self.lblTimer.text = "\(self.convertSecToHours(min: totalduration))" //This will update the label.

        //This will decrement(count down)the seconds.
        if self.astroFirstMessage == false {
            let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(valueRef)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                 let dict = snapshot.value as? [String: AnyObject]
                let value = dict?["isTypingAstrologer"] as? Bool
                if value != nil {
                self.lblForTyping.text = value == false ? "" : "isTyping..."
                } else {
                    self.lblForTyping.text = ""
                }
                
            }, withCancel: nil)
        }

    }
    
    func convertSecToHours(min:Int) -> String {
        let hours = String(format: "%02d", min/3600)
        let minutes = String(format: "%02d", (min/60)%60)
        let sec = String(format: "%02", min%60)
        return "\(hours):\(minutes):\(sec)"
    }
    
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // MARK: CLIP IMAGE BUTTON PRESSED METHOD
    
    @objc func clipImageButtonPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (alertAction) in
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                imagePicker.sourceType = .camera
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//        }))
        alert.addAction(UIAlertAction(title: "Open Photo Library", style: .default, handler: { (alertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.systemRed, forKey: "titleTextColor")
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.handelSelectedImageForInfo(info: info)
            self.uploadImage(image: originalImage) { (storageRef, image, mediaName) in
                self.downloadImage(storageRef, image, mediaName)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
//        UserDefaults.standard.setValue("", forKey: "ChatResume")
//        UserDefaults.standard.setValue(false, forKey: "ChatBool")
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        let setparameters = ["app_type":"ios",
                             "app_version":kAppVersion,
                             "user_id":user_id ,
                             "user_api_key":user_apikey,
                             "astrologer_id":AstrologerUniID,
                             "endtime": self.endTime ,
                             "starttime":self.startTime ,
                             "chat_id": data?["uniqeid"] as? String ?? ChatuNIQid,
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
                                            UserDefaults.standard.setValue(nil, forKey: "duration")
                                            let data =  tempDict["data"] as! [String:Any]
                                            self.timer?.invalidate()
                                            self.timer = nil
                                            chatStartorEnd = ""
                                            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
                                            controller.modalPresentationStyle = .overCurrentContext
                                            controller.astroId = AstrologerUniID
                                            controller.completionHandler = {
                                                print("hell")
                                                let refreshAlert = UIAlertController(title: "AstroShubh", message: "Your Review is Added Successfully", preferredStyle: UIAlertController.Style.alert)
                                                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                                                                                        {
                                                                                            (action: UIAlertAction!) in
                                                                                            if (data["random_coupon"] as? String) != nil {
                                                                                                let scratch = self.storyboard?.instantiateViewController(withIdentifier: "ScratchCardViewController") as! ScratchCardViewController
                                                                                                scratch.modalPresentationStyle = .overCurrentContext
                                                                                                scratch.randomcoupon = [:]
                                                                                                self.present(scratch, animated: true, completion: nil)
                                                                                            }
                                                                                            if let randomcoupon  = data["random_coupon"] as? [String:Any]{
                                                                                                
                                                                                                
                                                                                                if randomcoupon.count == 0 {
                                                                                                    //                                                                                                    self.moveToDashBoardVC()
                                                                                                    
                                                                                                    let scratch = self.storyboard?.instantiateViewController(withIdentifier: "ScratchCardViewController") as! ScratchCardViewController
                                                                                                    scratch.modalPresentationStyle = .overCurrentContext
                                                                                                    scratch.randomcoupon = [:]
                                                                                                    self.present(scratch, animated: true, completion: nil)
                                                                                                    
                                                                                                }
                                                                                                else {
                                                                                                    let scratch = self.storyboard?.instantiateViewController(withIdentifier: "ScratchCardViewController") as! ScratchCardViewController
                                                                                                    scratch.modalPresentationStyle = .overCurrentContext
                                                                                                    scratch.randomcoupon = randomcoupon
                                                                                                    self.present(scratch, animated: true, completion: nil)
                                                                                                    
                                                                                                } }
                                                                                            else
                                                                                            {
                                                                                                if let randomcoupon  = data["random_coupon"] as? String {
                                                                                                    if    randomcoupon == ""
                                                                                                    {
                                                                                                        
                                                                                                        let scratch = self.storyboard?.instantiateViewController(withIdentifier: "ScratchCardViewController") as! ScratchCardViewController
                                                                                                        scratch.modalPresentationStyle = .overCurrentContext
                                                                                                        scratch.randomcoupon = [:]
                                                                                                        self.present(scratch, animated: true, completion: nil)
                                                                                                    }
                                                                                                    
                                                                                                } else {
                                                                                                    self.moveToDashBoardVC()
                                                                                                }
                                                                                            }
                                                                                            //                                                                                         }   self.moveToDashBoardVC()
                                                                                            //                                                    self.navigationController?.popToRootViewController(animated: true)
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
                                                                                        //                                                                                        self.moveToDashBoardVC()
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
                                                        //                                                        self.moveToDashBoardVC()
                                                        //                    self.navigationController?.popToRootViewController(animated: true)
                                                        
                                                    }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    func func_chatEndForAstroSide() {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        let setparameters = ["app_version":MethodName.APPVERSION.rawValue,"app_type":MethodName.APPTYPE.rawValue,"user_id":user_id,"user_api_key":user_apikey,"chat_id":ChatuNIQid,"end_type":"2"]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("chatExits", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            UserDefaults.standard.setValue(nil, forKey: "duration")
                                            
                                            self.timer?.invalidate()
                                            self.timer = nil
                                            chatStartorEnd = ""
                                            self.moveToDashBoardVC()
                                            
                                        } else {
                                            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Something went wrong.", preferredStyle: UIAlertController.Style.alert)
                                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                                                    {
                                                                                        (action: UIAlertAction!) in
                                                                                        //end chat api
                                                                                        //                                                                                        self.moveToDashBoardVC()
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
                                                        //                                                        self.moveToDashBoardVC()
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
        if chatStartorEnd == "Astrologer Accepted Chat Request" {
            
            
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
        } else {
            moveToDashBoardVC()
        }
    }
    
    func sendFirstMessage() {
        let firstmessage =  "Name : " + ((self.data?["user_name"] as? String) ?? firstMessageData.name) + "\n" + "Gender : " + ((self.data?["user_gender"] as? String) ?? firstMessageData.gender ) + "\n" + "Date of Birth : " + ((self.data?["user_dob"] as? String) ?? firstMessageData.dob ) + "\n" + "Date of Time : " +  ((self.data?["user_dob"] as? String) ?? firstMessageData.dot ) + "\n" + "Pob : " +  ((self.data?["user_pob"] as? String) ?? firstMessageData.dot )  + "\n" + "Problem : " +  ((self.data?["problem_area"] as? String) ?? firstMessageData.problem ) + "\n" + "Location : " +  ((self.data?["user_pob"] as? String) ?? firstMessageData.location )
        self.sendOnce = false
        self.astroFirstMessage = true
        let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(anotherUserId ?? "")
        let childRef = ref.childByAutoId()
        let timeStamp = Int(truncating: NSNumber(value: Date().timeIntervalSince1970))
        let values: [String : Any] = ["from":Auth.auth().currentUser!.uid as AnyObject,"message": firstmessage,"seen":"false", "time":ServerValue.timestamp(),"type":"text","isTypingAstrologer":false,"isTypingUser":false,"pushID":childRef.key ?? "","imageUrl":""]
        valueRef = childRef.key ?? ""
        childRef.updateChildValues(values)
        self.moveToLastComment()
        childRef.observe(.childAdded) { (snapshot) in
            
            print(snapshot)
            
            self.moveToLastComment()
            
        }
        
        
    }
    
    @IBAction func action(_ sender: Any) {
        
        
        if sendOnce {
            self.sendFirstMessage()
            self.sendOnce = false
        }
        if txtView.text == ""{
            
        } else{
            let ref = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(anotherUserId ?? "")
            let childRef = ref.childByAutoId()
            //        let toId = anotherUserId
            
            let timeStamp = Int(truncating: NSNumber(value: Date().timeIntervalSince1970))
            let values: [String : Any] = ["from":Auth.auth().currentUser!.uid as AnyObject,"message": txtView.text!,"seen":"false", "time":ServerValue.timestamp(),"type":"text","pushID": "","imageUrl":""]
            childRef.updateChildValues(values)
            self.txtView.text = ""
            childRef.observe(.childAdded) { (snapshot) in
                print(snapshot)
                self.scrollToBottom()
            }
        }
    }
    
    @IBAction func buttonForAddImage(_ sender: UIButton) {
        self.clipImageButtonPressed()
    }
    
    
    func uploadImage(image: UIImage, completion: @escaping (_ storageRef: StorageReference, _ image: UIImage, _ name: String) -> Void){
        let mediaName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("message-img").child(mediaName)
        if let jpegName = image.jpegData(compressionQuality: 0.1) {
            let uploadTask = storageRef.putData(jpegName, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                return completion(storageRef, image, mediaName)
            }
//            countTimeRemaining(uploadTask)
        }
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    func downloadImage(_ ref: StorageReference, _ image: UIImage, _ id: String) {
        ref.downloadURL { (url, error) in
            guard let url = url else { return }
            self.sendMediaMessage(url: url.absoluteString, image, id)
        }
    }
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    // MARK: SEND MEDIA MESSAGE METHOD
    
    private func sendMediaMessage(url: String, _ image: UIImage, _ id: String){
        if sendOnce {
            self.sendFirstMessage()
            self.sendOnce = false
        }
        let senderRef = Database.database().reference().child("messages").child(Auth.auth().currentUser!.uid).child(anotherUserId ?? "").childByAutoId()
        let values =  ["from":Auth.auth().currentUser!.uid as AnyObject,"message": "","seen":"false", "time":ServerValue.timestamp(),"type":"image","imageUrl": url, "storageID": id,"pushID": ""] as [String : Any]
        senderRef.updateChildValues(values)
        senderRef.observe(.childAdded) { (snapshot) in
            print(snapshot)
            self.scrollToBottom()
        }
//        self.runTimer()
    }
    
    
    private func countTimeRemaining(_ uploadTask: StorageUploadTask) {
        uploadTask.observe(.progress) { (snap) in
            guard let progress = snap.progress else { return }
            let percentCompleted = 100.0 * Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
            var tempName = "Uploading File: \(round(100*percentCompleted)/100)% completed"
            if percentCompleted == 100.0 {
                tempName = "Almost done..."
            }
//            self.updateNavBar(tempName)
        }
    }
    
    
    func moveToLastComment() {
        if self.tblView.contentSize.height > self.tblView.frame.height {
            // First figure out how many sections there are
            let lastSectionIndex = self.tblView!.numberOfSections - 1
            
            // Then grab the number of rows in the last section
            let lastRowIndex = self.tblView!.numberOfRows(inSection: lastSectionIndex) - 1
            
            // Now just construct the index path
            let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
            
            // Make the last row visible
            self.tblView?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
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
        dateFormatter.dateFormat = "MMM,dd HH:mm"
        dateFormatter.timeZone = NSTimeZone.local
        
        //        dateFormatter.timeZone = NSTimeZone(name: "en_US") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        print(date)
        print("formatted date is =  \(dateString)")
        
        let str = convertTimestamp(serverTimestamp: Double(timestamp) ?? 0.0)
        print(str)
        
        if message == anotherUserId{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecievedTVC", for: indexPath) as! RecievedTVC
            cell.lblTime.text =  str
            cell.labelForReceiver.text = messageArray[indexPath.row].message
            return cell
        } else {
            if astroFirstMessage == true {
                astroFirstMessage = false
                self.setStartTime()
                Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(callMessageForkundliInProgress), userInfo: nil, repeats: false)
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "SentTVC", for: indexPath) as! SentTVC
            
            if  messageArray[indexPath.row].imageUrl == nil {
                cell.labelForMsg.isHidden = false
                cell.imgViewUser.isHidden = true
                cell.labelForMsg.text = messageArray[indexPath.row].message
                cell.imageHeight?.constant = 0

            } else if messageArray[indexPath.row].imageUrl != "" {
                cell.labelForMsg.isHidden = true
                cell.imgViewUser.isHidden = false
                cell.imgViewUser.sd_setImage(with: URL(string: messageArray[indexPath.row].imageUrl ?? ""), completed: nil)
                cell.imageHeight?.constant = 170
//                let imageTapped = UITapGestureRecognizer(target: self, action: #selector(imageTappedHandler(tap:)))
//                cell.imgViewUser.addGestureRecognizer(imageTapped)
//                cell.imgViewUser.isUserInteractionEnabled = true
            } else {
                cell.labelForMsg.isHidden = false
                cell.imgViewUser.isHidden = true
                cell.labelForMsg.text = messageArray[indexPath.row].message
                cell.imageHeight?.constant = 0

            }
            cell.lblTime.text =  str
            return cell
        }
    }
    

    func imageTappedHandler(_ sender: UITapGestureRecognizer) {
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
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
extension AstroChatVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
        self.sendIsTypingStatus()
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
        tblView.scrollToRow(at: IndexPath(row: allMessages.count, section: 0), at: .bottom, animated: true)
        //        let indexPath = IndexPath(row: self.allMessages.count-1, section: 0)
        //          self.tblView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
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
    
    @IBOutlet  weak var imgViewUser: UIImageView!
    @IBOutlet  weak var lblTime: UILabel!
    @IBOutlet weak var labelForMsg: UILabel!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    var thread: ChatThread?
    var shouldHideImage: Bool = false {
        willSet {
            //            viewImage.isHidden = newValue
        }
    }
    
}

class RecievedTVC: UITableViewCell {
    @IBOutlet  weak var lblTime: UILabel!
    @IBOutlet weak var labelForReceiver: UILabel!
    var thread: ChatThread?
    var shouldHideImage: Bool = false {
        willSet {
        }
    }
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
    var isTypingAstrologer:Bool?
    var isTypingUser:Bool?
    var pushID:String?
    var imageUrl:String?
    var storageID:String?
    init(dict: [String: AnyObject]) {
        
        self.from    = "\(dict["from"]!)"
        self.message = "\(dict["message"]!)"
        self.seen    = "\(dict["seen"]!)"
        self.time    = "\(dict["time"]!)"
        self.type    = "\(dict["type"]!)"
        self.isTypingAstrologer    = dict["isTypingAstrologer"] as? Bool
        self.isTypingUser    = dict["isTypingUser"] as? Bool
        self.pushID    = dict["pushID"] as? String
        self.imageUrl    = dict["imageUrl"] as? String
        self.storageID    = dict["storageID"] as? String
    }
    
}



