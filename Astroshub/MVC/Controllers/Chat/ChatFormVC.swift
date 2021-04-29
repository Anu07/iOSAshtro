//
//  ChatFormVC.swift
//  Astroshub
//
//  Created by Kriscent on 21/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import iOSDropDown
import FirebaseAuth
import FirebaseDatabase
import Firebase
class ChatFormVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, WWCalendarTimeSelectorProtocol{
    
    @IBOutlet weak var btn_Done: ZFRippleButton!
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_profile: UITableView!
    fileprivate var singleDate: Date = Date()
    var malefemale = ""
    fileprivate var multipleDates: [Date] = []
    var date_Selectdate = ""
    var postdob = ""
    var ProfileuserName = ""
    var Timmeee = ""
    var Pob = ""
    var ProblemArea = ""
    var Price = ""
    var Locationnn = ""
    var couponCode = ""
    var duration = ""

    var dobandtimeclick = ""
    var countryArray = NSArray()
    var countryNameArray = [String]()
    var countryIdArray = [Int]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_profile.reloadData()
        self.func_GetCOUNTRY()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print(userID)
        
        Locationnn = CurrentLocation
        
        
        
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
        // Generating the chat id
        let refChats = ref!.child("chats")
        let refChat = refChats.childByAutoId()
        
        // Accessing the "chatIds branch" from a user based on
        // his id
        let currentUserId = uid
        let refUsers = ref!.child("users")
        let refUser = refUsers.child(currentUserId!)
        let refUserChatIds = refUser.child("chatIds")
        
        // Setting the new Chat Id key created before
        // on the "chatIds branch"
        let chatIdKey = refChat.key
        let refUserChatId = refUserChatIds.child(chatIdKey!)
        refUserChatIds.setValue(chatIdKey)
        
        let dictMovieRefAvengers: [String: String] = ["name": "Avengers", "senderID": "", "receiverID": "", "AstroID": "", "message": ""]
        
        // Saving the values in movie1 node
        refUserChatId.setValue(dictMovieRefAvengers) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
        
        
        // let uid = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value,  with: {
            (snapshot) in
            print("1")
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print("2")
                self.navigationItem.title = dictionary["name"] as? String
            }
        }, withCancel: nil)
        
        
        let btnayer = CAGradientLayer()
        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: btn_Done.frame.size.width, height: btn_Done.frame.size.height)
//        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        btn_Done.layer.insertSublayer(btnayer, at: 1)
        
        // self.Locationnn = userCountry
        // tbl_profile.reloadData()
        
        
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    func textFieldDidBeginEditing(_ textField: UITextField)
    {    //delegate method
        
        
        if (textField.tag==1)
        {
            ProfileuserName=textField.text!
            
        }
            
        else if (textField.tag==2)
        {
            
            Pob=textField.text!
        }
        else if (textField.tag==3)
        {
            
            ProblemArea=textField.text!
        }
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        
        if (textField.tag==1)
        {
            ProfileuserName=textField.text!
            
        }
            
        else if (textField.tag==2)
        {
            
            Pob=textField.text!
        }
        else if (textField.tag==3)
        {
            
            ProblemArea=textField.text!
        }
        
        // return YES;
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
    func callToAstrologerAPI() {
        if let getNumber = self.user?.phone {
            let params = ["num":getNumber ,"userid": self.user?.userId]
            AppHelperModel.requestPOSTURL("CallingAPI \(getNumber) \(self.user?.userId ?? "") ", params: nil, headers: nil,
                                          success: { (respose) in
                                            print(respose)
                                            
            }) { (error) in
                print(error)
            }
        }
    }
    
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
                                        //print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            if let arrtimeslot = tempDict["data"] as? NSArray
                                            {
                                                self.countryArray = arrtimeslot
                                            }
                                            //print("arrTimeList is:- ",self.countryArray)
                                            
                                            for i in 0..<self.countryArray.count
                                            {
                                                let dict_Products = self.countryArray[i] as! NSDictionary
                                                let name = dict_Products["name"] as! String
                                                let id = dict_Products["id"] as! String
                                                let iddddd = Int(id)
                                                
                                                
                                                self.countryNameArray.append(name)
                                                self.countryIdArray.append(iddddd!)
                                            }
                                            
                                            self.tbl_profile.reloadData()
                                            
                                            
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
    func func_chatStartForm() {
        let setparameters = ["app_type":"ios",
                             "app_version":"1.0",
                             "user_api_key":user_apikey,
                             "user_id":user_id,
                             "astrologer_id": AstrologerUniID,
                             "name":self.ProfileuserName,
                             "gender":self.malefemale,
                             "dob":self.postdob,
                             "time":self.Timmeee,
                             "pob":self.Pob,
                             "problem_area":self.ProblemArea,
                             "price":AstrologerrPrice,
                             "location":self.Locationnn,
                             "busy_status":1,"coupon_id":couponCode,"duration":duration] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("chatStartForm", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            self.callToAstrologerAPI()
                                            
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            
                                            let dict_Data1 = dict_Data["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data1)
                                            
                                            
                                            ChatTime = dict_Data1["chat_time"] as! String
                                            ChatuNIQid = dict_Data1["chatUniId"] as! String
                                            ChatCreatedat = dict_Data1["created_at"] as! String
                                            let firstMessageObj = FirstMessageData()
                                            firstMessageObj.name = self.ProfileuserName
                                            firstMessageObj.gender = self.malefemale
                                            firstMessageObj.dob = self.postdob
                                            firstMessageObj.dot = self.Timmeee
                                            firstMessageObj.problem = self.Pob
                                            firstMessageObj.pob = self.ProblemArea
                                            firstMessageObj.location = self.Locationnn
                                            if let getUser = self.user {
                                                let ChatForm = self.storyboard?.instantiateViewController(withIdentifier: "AstroChatVC") as! AstroChatVC
                                                ChatForm.totalduration = getUser.totalSecondsForCall
                                                let defaults = UserDefaults.standard
                                                defaults.set(getUser.totalSecondsForCall, forKey: "duration")
                                                ChatForm.thread = ChatHelper.thread(with: getUser, orFrom: [])
                                                ChatForm.firstMessageData = firstMessageObj
//                                                ChatForm.data = dict_Data1["chatarr"] as! [String : Any]
                                                self.navigationController?.pushViewController(ChatForm, animated: true)
                                            }
                                            //                                            let ChatHistory = self.storyboard?.instantiateViewController(withIdentifier: "ChatHistoryVC")
                                            //                                            self.navigationController?.pushViewController(ChatHistory!, animated: true)
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
    
    func func_callStartForm() {
        
        let setparameters = ["app_type":"ios",
                             "app_version":"1.0",
                             "user_api_key":user_apikey,
                             "user_id":user_id ,
                             "astrologer_id": AstrologerUniID,
                             "name":self.ProfileuserName,
                             "gender":self.malefemale,
                             "dob":self.postdob,
                             "time":self.Timmeee,
                             "pob":self.Pob,
                             "problem_area":self.ProblemArea,
                             "price":AstrologerrPrice,
                             "location":self.Locationnn,
                             "busy_status":1,"coupon_id":couponCode] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("callStartForm", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
//                                            let controller = self.storyboard?.instantiateViewController(withIdentifier: "FirstMinuteVC") as! FirstMinuteVC
//                                            controller.modalPresentationStyle = .overCurrentContext
//                                            controller.navigation = self.navigationController
//                                            self.present(controller, animated: true, completion: nil)
                                           CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if section == 0
        {
            return 1
            
        }
        else if section == 1
        {
            return 1
            
        }
        else
            
        {
            return 1
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell1", for: indexPath) as! ProfileCell1
            
            cell_Add.btn_MALE.tag = indexPath.row
            cell_Add.btn_MALE.addTarget(self, action: #selector(self.btn_maleAction(_:)), for: .touchUpInside)
            
            cell_Add.btn_FEMALE.tag = indexPath.row
            cell_Add.btn_FEMALE.addTarget(self, action: #selector(self.btn_femaleAction(_:)), for: .touchUpInside)
            
            cell_Add.btn_DOB.tag = indexPath.row
            cell_Add.btn_DOB.addTarget(self, action: #selector(self.btn_DobAction(_:)), for: .touchUpInside)
            
            cell_Add.txt_Usename.delegate = (self as UITextFieldDelegate)
            
            
            if malefemale == "Male"
            {
                cell_Add.btn_MALE.layer.cornerRadius = 8
                cell_Add.btn_MALE.layer.backgroundColor = UIColor(red: 246/255.0, green: 197/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
                cell_Add.btn_MALE.setTitleColor(.white, for: .normal)
                // cell_Add.btn_FEMALE.setTitleColor(UIColor(red: 31/255.0, green: 130/255.0, blue: 162/255.0, alpha: 1.0), for: .normal)
                cell_Add.btn_FEMALE.setTitleColor(.black, for: .normal)
                cell_Add.btn_FEMALE.backgroundColor = UIColor.white
                
            }
            else if malefemale == "Female"
            {
                cell_Add.btn_FEMALE.layer.cornerRadius = 8
                cell_Add.btn_FEMALE.layer.backgroundColor =  UIColor(red: 246/255.0, green: 197/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
                cell_Add.btn_FEMALE.setTitleColor(.white, for: .normal)
                
                cell_Add.btn_MALE.layer.cornerRadius = 0
                cell_Add.btn_MALE.backgroundColor = UIColor.white
                cell_Add.btn_MALE.setTitleColor(.black, for: .normal)
                // cell_Add.btn_MALE.setTitleColor(UIColor(red: 31/255.0, green: 130/255.0, blue: 162/255.0, alpha: 1.0), for: .normal)
                
            }
            else
            {
                cell_Add.btn_MALE.layer.cornerRadius = 0
                cell_Add.btn_MALE.backgroundColor = UIColor.white
                cell_Add.btn_MALE.setTitleColor(.black, for: .normal)
                
                cell_Add.btn_FEMALE.setTitleColor(.black, for: .normal)
                cell_Add.btn_FEMALE.backgroundColor = UIColor.white
            }
            
            if  self.date_Selectdate != ""
            {
                
                cell_Add.btn_DOB.setTitleColor(.black, for: .normal)
                cell_Add.btn_DOB.setTitle(self.date_Selectdate,for: .normal)
            }
            
            
            
            return cell_Add
        }
        else if indexPath.section == 1
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell3", for: indexPath) as! ProfileCell3
            
            cell_Add.txt_email.delegate = (self as UITextFieldDelegate)
            cell_Add.txt_mobilenumber.delegate = (self as UITextFieldDelegate)
            return cell_Add
        }
        else
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell4", for: indexPath) as! ProfileCell4
            
            cell_Add.btn_birthtime.tag = indexPath.row
            cell_Add.btn_birthtime.addTarget(self, action: #selector(self.btn_birthAction(_:)), for: .touchUpInside)
            
            //cell_Add.txtage.delegate = (self as UITextFieldDelegate)
            cell_Add.mainDropDown.optionArray = self.countryNameArray
            cell_Add.mainDropDown.optionIds = self.countryIdArray
            cell_Add.mainDropDown.checkMarkEnabled = false
            
            cell_Add.mainDropDown.text = CurrentLocation
            
            cell_Add.mainDropDown.didSelect{(selectedText , index , id) in
                
                let txtddddd = selectedText
                let txtIdddddddd = id
                print(txtddddd)
                print(txtIdddddddd)
                self.Locationnn = selectedText
                
            }
            
            cell_Add.mainDropDown.arrowSize = 20
            cell_Add.buttonViewOffers.tag = indexPath.row
            cell_Add.buttonViewOffers.addTarget(self, action: #selector(self.viewOffers(_:)), for: .touchUpInside)
            
            
            if self.Timmeee != ""
            {
                cell_Add.btn_birthtime.setTitleColor(.black, for: .normal)
                cell_Add.btn_birthtime.setTitle(self.Timmeee,for: .normal)
            }
            return cell_Add
        }
        
        
        
    }
    
    @objc  func viewOffers(_ sender:UIButton) {
        let point = sender.convert(CGPoint.zero, to: self.tbl_profile)
        let indexPath = self.tbl_profile.indexPathForRow(at: point)
        let cell = self.tbl_profile.cellForRow(at: indexPath!) as! ProfileCell4
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OffersViewController") as! OffersViewController
        vc.screenCome = .chat
        vc.completionHandler = { text in
            cell.textFieldPromoCode.text = text["coupon_code"] as? String
            print("text = \(text)")
            self.couponCode = text["id"] as! String
            return text
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btn_maleAction(_ sender: UIButton)
    {
        
        malefemale = "Male"
        tbl_profile.reloadData()
        
    }
    
    @objc  func btn_femaleAction(_ sender: UIButton)
    {
        //isChecked = true
        malefemale = "Female"
        tbl_profile.reloadData()
    }
    
    @objc func btn_CountryAction(_ sender: UIButton)
    {
        let Country = self.storyboard?.instantiateViewController(withIdentifier: "CountryVC")
        self.navigationController?.pushViewController(Country!, animated: true)
    }
    
    @objc func btn_DobAction(_ sender: UIButton)
    {
        dobandtimeclick = "dob"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        
        present(selector, animated: true, completion: nil)
        
    }
    
    @objc func btn_birthAction(_ sender: UIButton)
    {
        dobandtimeclick = "time"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        
        present(selector, animated: true, completion: nil)
    }
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btn_doneAction(_ sender: Any)
    {
        if Validate.shared.validatechatform(vc: self)
        {
            if chatcallingFormmm == "Chat"
            {
                self.func_chatStartForm()
            }
            if chatcallingFormmm == "Calling"
            {
                self.func_callStartForm()
            }
        }
    }
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        //   self.date_Selectdate = date.stringFromFormat("yyyy-MM-dd")
        
        if dobandtimeclick == "dob"
        {
            let dob = date.stringFromFormat("yyyy-MM-dd")
            self.date_Selectdate = self.formattedDateFromString(dateString: dob, withFormat: "dd MMM yyyy")!
            self.postdob = date.stringFromFormat("dd-MM-yyyy")
            self.tbl_profile.reloadData()
        }
        else
        {
            let time = date.stringFromFormat("hh:mm a")
            self.Timmeee = time
            self.tbl_profile.reloadData()
        }
        print(self.date_Selectdate)
        
        // dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        if let date = dates.first {
            singleDate = date
            //  dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
        }
        multipleDates = dates
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
}


class FirstMessageData {
    var name = ""
    var gender = ""
    var dob = ""
    var dot = ""
    var pob = ""
    var problem = ""
    var location = ""
}
