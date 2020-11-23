//
//  QueryReportVC.swift
//  Astroshub
//
//  Created by Kriscent on 10/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import iOSDropDown
import FirebaseAuth
import FirebaseDatabase
import Firebase
import Razorpay


private var KEY_ID = "rzp_live_1idxRp4tPV0Llx"    //"rzp_test_pDqqc1wovvXUCn" // @"rzp_test_1DP5mmOlF5G5ag";
private let SUCCESS_TITLE = "Yay!"
private let SUCCESS_MESSAGE = "Your payment was successful. The payment ID is %@"
private let FAILURE_TITLE = "Uh-Oh!"
private let FAILURE_MESSAGE = "Your payment failed due to an error.\nCode: %d\nDescription: %@"
private let EXTERNAL_METHOD_TITLE = "Umm?"
private let EXTERNAL_METHOD_MESSAGE = """
You selected %@, which is not supported by Razorpay at the moment.\nDo \
you want to handle it separately?
"""
private let OK_BUTTON_TITLE = "OK"
class QueryReportVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, WWCalendarTimeSelectorProtocol,UITextViewDelegate, RazorpayPaymentCompletionProtocol {
    
    
    
    @IBOutlet weak var labelFoQueryNote: UILabel!
    
    
    @IBOutlet var viewblur: UIView!
    @IBOutlet var viewpopup: UIView!
    
    func onPaymentError(_ code: Int32, description str: String)
    {
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        // self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var btn_Done: ZFRippleButton!
    @IBOutlet weak var btn_Done1: ZFRippleButton!
    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var view_Report: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var kabel4: UILabel!
    @IBOutlet weak var label3: UILabel!
    var razorpay: RazorpayCheckout? = nil
    @IBOutlet var tbl_profile: UITableView!
    @IBOutlet var tbl_report: UITableView!
    fileprivate var singleDate: Date = Date()
    var malefemale = ""
    fileprivate var multipleDates: [Date] = []
    var date_Selectdate = ""
    var postdob = ""
    var ProfileuserName = ""
    var Email = ""
    var Mobilenumber = ""
    var ProfileuserName1 = ""
    var Email1 = ""
    var Mobilenumber1 = ""
    var Reportname = ""
    var ReportID = Int()
    var Message = ""
    var Placebirth = ""
    var Enquiry = ""
    var Timmeee = ""
    var Pob = ""
    var ProblemArea = ""
    var Price = ""
    var Locationnn = ""
    var dobandtimeclick = ""
    var countryArray = NSArray()
    var countryNameArray = [String]()
    var countryIdArray = [Int]()
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = self.PerformActionIfLogin()
        lbl1.isHidden = false
        lbl2.isHidden = true
        label3.isHidden = true
        kabel4.isHidden = true

        view_Report.isHidden = true
        viewblur.isHidden = true
        viewpopup.isHidden = true
        
        QueryReportFormshow = "query"
        
        
        if setCustomerdob != ""
        {
            self.date_Selectdate = self.formattedDateFromString(dateString: setCustomerdob, withFormat: "dd MMM yyyy")!
            self.postdob = self.formattedDateFromString(dateString: setCustomerdob, withFormat: "yyyy-MM-dd")!
        }
        
        
        // self.date_Selectdate = setCustomerdob
        self.Timmeee = setCustomertime
        
        razorpay = RazorpayCheckout.initWithKey(KEY_ID, andDelegate: self)
        
        ProfileuserName=setCustomername
        Email=setCustomeremail
        Mobilenumber=setCustomerphone
        ProfileuserName1=setCustomername
        Email1=setCustomeremail
        Mobilenumber1=setCustomerphone
        
        
        tbl_profile.reloadData()
        self.func_QueryName()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        print(userID)
        
        
        
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
        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        btn_Done.layer.insertSublayer(btnayer, at: 1)
        
        
        let btnayer1 = CAGradientLayer()
        btnayer1.frame = CGRect(x: 0.0, y: 0.0, width: btn_Done1.frame.size.width, height: btn_Done1.frame.size.height)
        btnayer1.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer1.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer1.endPoint = CGPoint(x: 1.0, y: 0.5)
        btn_Done1.layer.insertSublayer(btnayer1, at: 1)
        
        // self.Locationnn = userCountry
        // tbl_profile.reloadData()
        
        
    }
    
    
    func onPaymentSuccess(_ payment_id: String)
    {
        // self.func_rechargeamount()
        
        PaymentID =  payment_id
        
        showAlert(withTitle: SUCCESS_TITLE, andMessage: String(format: SUCCESS_MESSAGE, payment_id ))
        
        if QueryReportFormshow == "query"
        {
            self.func_QueryForm("0")
        }
        if QueryReportFormshow == "report"
        {
            self.func_ReportForm()
        }
        if QueryReportFormshow == "voice"
        {
            self.func_QueryForm("1")
        }
        if QueryReportFormshow == "remedy"
        {
            self.func_RemedyForm()
        }
    }
    
    func onPaymentError(_ code: Int, description str: String?) {
        showAlert(withTitle: FAILURE_TITLE, andMessage: String(format: FAILURE_MESSAGE, code, str ?? ""))
    }
    
    func onExternalWalletSelected(_ walletName: String, withPaymentData paymentData: [AnyHashable : Any]?) {
        showAlert(withTitle: EXTERNAL_METHOD_TITLE, andMessage: String(format: EXTERNAL_METHOD_MESSAGE, walletName ))
    }
    
    func showAlert(withTitle title: String?, andMessage message: String?) {
        if UIDevice.current.systemVersion.compare("8.0", options: .numeric, range: nil, locale: .current) != .orderedAscending {
            _ = UIAlertController(title: title, message: message, preferredStyle: .alert)
            _ = UIAlertAction(title: OK_BUTTON_TITLE, style: .cancel, handler: nil)
            //
            //  The converted code is limited to 1 KB.
            //  Please Sign Up (Free!) to double this limit.
            //
            //  %< ----------------------------------------------------------------------------------------- %<
            
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {    //delegate method
        
        
        if (textField.tag==1)
        {
            ProfileuserName=textField.text!
            
        }
            
        else if (textField.tag==2)
        {
            
            Email=textField.text!
        }
        else if (textField.tag==3)
        {
            
            Mobilenumber=textField.text!
        }
        else if (textField.tag==4)
        {
            
            Placebirth=textField.text!
        }
            //            else if (textField.tag==5)
            //            {
            //
            //                Enquiry=textField.text!
            //            }
        else if (textField.tag==6)
        {
            
            ProfileuserName1=textField.text!
        }
        else if (textField.tag==7)
        {
            
            Email1=textField.text!
        }
        else if (textField.tag==8)
        {
            
            Mobilenumber1=textField.text!
        }
        else if (textField.tag==9)
        {
            
            Reportname=textField.text!
        }
        //            else if (textField.tag==10)
        //            {
        //
        //                Message=textField.text!
        //            }
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        
        if (textField.tag==1)
        {
            ProfileuserName=textField.text!
            
        }
            
        else if (textField.tag==2)
        {
            
            Email=textField.text!
        }
        else if (textField.tag==3)
        {
            
            Mobilenumber=textField.text!
        }
        else if (textField.tag==4)
        {
            
            Placebirth=textField.text!
        }
            //            else if (textField.tag==5)
            //            {
            //
            //                Enquiry=textField.text!
            //            }
        else if (textField.tag==6)
        {
            
            ProfileuserName1=textField.text!
        }
        else if (textField.tag==7)
        {
            
            Email1=textField.text!
        }
        else if (textField.tag==8)
        {
            
            Mobilenumber1=textField.text!
        }
        else if (textField.tag==9)
        {
            
            Reportname=textField.text!
        }
        //            else if (textField.tag==10)
        //            {
        //
        //                Message=textField.text!
        //            }
        // return YES;
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.tag==5)
        {
            if textView.text == "Enter Your Query & Requirement"
            {
                textView.text = ""
                textView.textColor = UIColor.darkGray
            }
            
            Enquiry=textView.text!
            
        }
        if (textView.tag==10)
        {
            if textView.text == "Enter Message"
            {
                textView.text = ""
                textView.textColor = UIColor.darkGray
            }
            
            Message=textView.text!
            
        }
    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.tag==5)
        {
            if textView.text == ""
            {
                textView.text = "Enter Your Query & Requirement"
                textView.textColor = UIColor.lightGray
            }
            Enquiry=textView.text!
            
        }
        if (textView.tag==10)
        {
            if textView.text == ""
            {
                textView.text = "Enter Message"
                textView.textColor = UIColor.lightGray
            }
            Message=textView.text!
            
        }
    }
    
    func func_QueryName() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey]
        // let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("reportName", params: setparameters as [String : AnyObject],headers: nil,
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
                                                let id = dict_Products["sr"] as! Int
                                                let iddddd = Int(id)
                                                
                                                
                                                self.countryNameArray.append(name)
                                                self.countryIdArray.append(iddddd)
                                            }
                                            
                                            self.tbl_report.reloadData()
                                            
                                            
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
    func func_QueryForm(_ type:String) {
        
        let setparameters = ["app_type":"ios",
                             "app_version":"1.0",
                             "user_api_key":user_apikey,
                             "user_id":user_id ,
                             "name": ProfileuserName,
                             "phone":self.Mobilenumber,
                             "dob":self.postdob,
                             "tob":self.Timmeee,
                             "place_of_birth":self.Placebirth,
                             "email":self.Email,
                             "query":Enquiry,
                             "location":CurrentLocation,
                             "paymentid":PaymentID,"query_type":type] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("getQueryAstrologer", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true{
                                            let refreshAlert = UIAlertController(title: "Astroshubh", message: message, preferredStyle: UIAlertController.Style.alert)
                                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                {
                                                    (action: UIAlertAction!) in
                                                    self.backFun()
                                            }))
                                            self.present(refreshAlert, animated: true, completion: nil)
                                        }else{
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    func func_RemedyForm() {
        
        let setparameters = ["user_api_key":user_apikey,
                             "user_id":user_id ,
                             "name": ProfileuserName,
                             "phone":self.Mobilenumber,
                             "dob":self.postdob,
                             "birth_time":self.Timmeee,
                             "birth_place":self.Placebirth,
                             "email":self.Email,
                             "query":Enquiry,
                             "location":CurrentLocation,
                             "paymentid":PaymentID,"amount_report":(CurrentLocation == "India" ? FormRemedyPrice : FormRemedydollarPrice)] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("getRemedyAstrologer", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true{
                                            let refreshAlert = UIAlertController(title: "Astroshubh", message: message, preferredStyle: UIAlertController.Style.alert)
                                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                {
                                                    (action: UIAlertAction!) in
                                                    self.backFun()
                                            }))
                                            self.present(refreshAlert, animated: true, completion: nil)
                                        }else{
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    func func_ReportForm() {
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id ,"name": ProfileuserName1,"phone":self.Mobilenumber1,"email":self.Email1,"query_name":self.ReportID,"query":Message,"location":CurrentLocation,"paymentid":PaymentID] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("getReportAstrologer", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            let refreshAlert = UIAlertController(title: "Astroshubh", message: message, preferredStyle: UIAlertController.Style.alert)
                                            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                {
                                                    (action: UIAlertAction!) in
                                                    //            self.navigationController?.popToRootViewController(animated: true)
                                                    
                                                    self.backFun()
                                            }))
                                            
                                            self.present(refreshAlert, animated: true, completion: nil)
                                            
                                        }
                                        else {
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
                                        
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    func backFun()
    {
        for controller in self.navigationController!.viewControllers as Array
        {
            
            if controller.isKind(of: DashboardVC.self)
            {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
            else
            {
                // Fallback on earlier versions
            }
        }
    }
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        if tableView == tbl_profile
        {
            return 4
        }
        else
        {
            return 3
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tbl_profile
        {
            if indexPath.section == 0 {
                return 285
            } else if indexPath.section == 1 {
                return 190
                
            } else if indexPath.section == 2 {
                return 332
            } else {
                return 150
            }
        }
        else
        {
            if indexPath.section == 0 {
                return 285
            } else if indexPath.section == 1 {
                return 332
            } else {
                return 150
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        if tableView == tbl_profile
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
        else
        {
            if section == 0
            {
                return 1
                
            }
            else
                
            {
                return 1
                
            }
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tbl_profile
        {
            if indexPath.section == 0
            {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell1", for: indexPath) as! ProfileCell1
                
                
                cell_Add.txt_namee.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_Mobile.delegate = (self as UITextFieldDelegate)
                
                
                
                cell_Add.txt_namee.text = ProfileuserName
                cell_Add.txt_Email.text = Email
                cell_Add.txt_Mobile.text = Mobilenumber
                
                return cell_Add
            }
            else if indexPath.section == 1
            {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell3", for: indexPath) as! ProfileCell3
                
                cell_Add.btn_DOB.tag = indexPath.row
                cell_Add.btn_DOB.addTarget(self, action: #selector(self.btn_DobAction(_:)), for: .touchUpInside)
                
                cell_Add.btn_birthtime.tag = indexPath.row
                cell_Add.btn_birthtime.addTarget(self, action: #selector(self.btn_birthAction(_:)), for: .touchUpInside)
                
                
                
                if  self.date_Selectdate != ""
                {
                    
                    cell_Add.btn_DOB.setTitleColor(.black, for: .normal)
                    cell_Add.btn_DOB.setTitle(self.date_Selectdate,for: .normal)
                }
                
                if self.Timmeee != ""
                {
                    cell_Add.btn_birthtime.setTitleColor(.black, for: .normal)
                    cell_Add.btn_birthtime.setTitle(self.Timmeee,for: .normal)
                }
                
                
                
                return cell_Add
            }
            else if indexPath.section == 2
            {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell4", for: indexPath) as! ProfileCell4
                
                cell_Add.txtPlace.delegate = (self as UITextFieldDelegate)
                cell_Add.textQuery.delegate = (self as UITextViewDelegate)
                // cell_Add.txtQuery.delegate = (self as UITextFieldDelegate)
                if QueryReportFormshow == "remedy" {
                    cell_Add.labelForQuery.text = ""
                } else {
                    
                }
                return cell_Add
            } else {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCellTwoButtons", for: indexPath) as! ProfileCellTwoButtons
                cell_Add.buttonDone.addTarget(self, action: #selector(buttonDoneAction), for: .touchUpInside)
                cell_Add.buttonSample.addTarget(self, action: #selector(buttonSampleAction), for: .touchUpInside)
                return cell_Add
            }
        }
        else
        {
            if indexPath.section == 0
            {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell1", for: indexPath) as! ProfileCell1
                
                
                cell_Add.txt_namee.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_Email.delegate = (self as UITextFieldDelegate)
                cell_Add.txt_Mobile.delegate = (self as UITextFieldDelegate)
                
                
                
                
                cell_Add.txt_namee.text = ProfileuserName1
                cell_Add.txt_Email.text = Email1
                cell_Add.txt_Mobile.text = Mobilenumber1
                
                return cell_Add
            }
                
            else if indexPath.section == 1
            {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell4", for: indexPath) as! ProfileCell4
                
                
                // cell_Add.txtQuery.delegate = (self as UITextFieldDelegate)
                cell_Add.textQuery.delegate = (self as UITextViewDelegate)
                // cell_Add.txtPlace.delegate = (self as UITextFieldDelegate)
                cell_Add.mainDropDown.optionArray = self.countryNameArray
                cell_Add.mainDropDown.optionIds = self.countryIdArray
                cell_Add.mainDropDown.checkMarkEnabled = false
                
                // cell_Add.mainDropDown.text = CurrentLocation
                
                cell_Add.mainDropDown.didSelect{(selectedText , index , id) in
                    
                    let txtddddd = selectedText
                    let txtIdddddddd = id
                    print(txtddddd)
                    print(txtIdddddddd)
                    self.ReportID = id
                    self.Reportname = selectedText
                    
                }
                
                
                return cell_Add
            }
            else {
                let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCellTwoButtons", for: indexPath) as! ProfileCellTwoButtons
                cell_Add.buttonDone.addTarget(self, action: #selector(buttonDoneAction), for: .touchUpInside)
                cell_Add.buttonSample.addTarget(self, action: #selector(buttonSampleAction), for: .touchUpInside)
                return cell_Add
            }
            
        }
        
        
        
        
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
    @IBAction func btn_QueryAction(_ sender: Any)
    {
        view_Report.isHidden = true
        lbl1.isHidden = false
        lbl2.isHidden = true
        label3.isHidden = true
        kabel4.isHidden = true
        QueryReportFormshow = "query"
        
    }
    
    @IBAction func buttonVoiceQuery(_ sender: UIButton) {
        view_Report.isHidden = true
        lbl1.isHidden = true
        lbl2.isHidden = true
        label3.isHidden = true
        kabel4.isHidden = false
        QueryReportFormshow = "Voice"
    }
    
    @IBAction func btn_ReportAction(_ sender: Any)
    {
        lbl1.isHidden = true
        lbl2.isHidden = false
        label3.isHidden = true
        kabel4.isHidden = true

        view_Report.isHidden = false
        
        QueryReportFormshow = "report"
    }
    
    @IBAction func btnRemedy(_ sender: UIButton) {
        view_Report.isHidden = true
        lbl1.isHidden = true
        lbl2.isHidden = true
        label3.isHidden = false
        kabel4.isHidden = true

        QueryReportFormshow = "remedy"
    }
    
    @IBAction func btn_doneAction(_ sender: Any)
    {
        if Validate.shared.validatequeryform(vc: self)
        {
            self.viewblur.isHidden = false
            self.viewpopup.isHidden = false

        }
    }
    
    @objc func buttonDoneAction() {
        if self.PerformActionIfLogin() {
            if view_Report.isHidden {// show sample query
                if Validate.shared.validatequeryform(vc: self) {
                    self.viewblur.isHidden = false
                    self.viewpopup.isHidden = false
                }
            } else {
                if Validate.shared.validateReporform(vc: self)
                {
                    self.viewblur.isHidden = false
                    self.viewpopup.isHidden = false
                }
            }
        }
    }
    
    @objc func buttonSampleAction() {
        if view_Report.isHidden { // show sample query
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "MangaldoshVC") as! MangaldoshVC
            controller.isReport = false
            self.navigationController?.pushViewController(controller, animated: true)
        } else { // show sample report
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "MangaldoshVC") as! MangaldoshVC
            controller.isReport = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    @IBAction func btn_doneAction1(_ sender: Any)
    {
        if Validate.shared.validateReporform(vc: self)
        {
            
            self.viewblur.isHidden = false
            self.viewpopup.isHidden = false
            
        }
    }
    
    
    @IBAction func btn_paypalAction(_ sender: Any) {
        let allowed = self.checkPaymentGatewayAlert(isStripe:true)
        let currency = (CurrentLocation == "India" ? "INR" : "USD").lowercased()
        var amt = QueryReportFormshow == "query" ? "6" : "18"
        if QueryReportFormshow == "remedy"{
            amt = "6"
        }
        if allowed{
            guard let addNewCardVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as? AddNewCardVC else { return }
            addNewCardVC.stripePaymentParams = ["amount": amt,
                                                "currency": currency]
            addNewCardVC.delegateStripePay = self
            self.navigationController?.pushViewController(addNewCardVC, animated: true)
        }
        
    }
    
    @IBAction func btn_razorpayAction(_ sender: Any)
    {
        let multiplier = CurrentLocation == "India" ? 1.18 : 1
        let allowed = self.checkPaymentGatewayAlert(isStripe:false)
        if allowed{
            if QueryReportFormshow == "query"
            {
                if CurrentLocation == "India"{
                    mYCURRNECY = "INR"
                }else {
                    mYCURRNECY = "USD"
                }
                
                //let abcccc1 = Float(100.00)
                //let abcccc = Float(FormQueryPrice)
                //let abcccc2 = abcccc * abcccc1
                
                let rezorp = Double(FormQueryPrice) * 100.0
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                let options: [String:Any] = [
                    "amount" : finalGSTPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹\(FormQueryPrice) + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#FF7B18"
                    ]
                ]
                //                  razorpay?.open(options)
                razorpay?.open(options, displayController: self)
            }
            if QueryReportFormshow == "remedy"
            {
                if CurrentLocation == "India"{
                    mYCURRNECY = "INR"
                }else {
                    mYCURRNECY = "USD"
                }
                
                //let abcccc1 = Float(100.00)
                //let abcccc = Float(FormQueryPrice)
                //let abcccc2 = abcccc * abcccc1
                
                let rezorp = Double((CurrentLocation == "India" ? FormRemedyPrice : FormRemedydollarPrice)) * 100.0
                let finalGSTPrice = (rezorp * multiplier).round(to: 2)
                let options: [String:Any] = [
                    "amount" : finalGSTPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹\((CurrentLocation == "India" ? FormRemedyPrice : FormRemedydollarPrice)) + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#FF7B18"
                    ]
                ]
                //                  razorpay?.open(options)
                razorpay?.open(options, displayController: self)
            }
            if QueryReportFormshow == "report"
            {
                if CurrentLocation == "India"
                {
                    mYCURRNECY = "INR"
                }
                else
                {
                    mYCURRNECY = "USD"
                }
                FormReportPrice = CurrentLocation == "India" ? 700 : FormReportPrice
                let rezorp = Double(FormReportPrice) * 100.0
                let finalGSTAddedPrice = (rezorp * multiplier).round(to: 2)
                
                let options: [String:Any] = [
                    "amount" : finalGSTAddedPrice,
                    "currency" :  mYCURRNECY,
                    "description": "( ₹700 + 18% GST included)",
                    "image": "http://kriscenttechnohub.com/demo/astroshubh/admin/assets/images/astroshubh_full-log.png",
                    "name": setCustomername,
                    "prefill": [
                        "contact": setCustomerphone,
                        "email": setCustomeremail
                    ],
                    "theme": [
                        "color": "#FF7B18"
                    ]
                ]
                //                  razorpay?.open(options)
                razorpay?.open(options, displayController: self)
            }
        }
        
    }
    @IBAction func btn_crossAction(_ sender: Any)
    {
        self.viewblur.isHidden = true
        self.viewpopup.isHidden = true
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        //   self.date_Selectdate = date.stringFromFormat("yyyy-MM-dd")
        
        if dobandtimeclick == "dob"
        {
            let dob = date.stringFromFormat("yyyy-MM-dd")
            self.date_Selectdate = self.formattedDateFromString(dateString: dob, withFormat: "dd MMM yyyy")!
            self.postdob = date.stringFromFormat("yyyy-MM-dd")
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
        }else {
            // dateLabel.text = "No Date Selected"
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


//MARK:- Stripe PAYMENTS
extension QueryReportVC : DelegateStripePayment{
    func paymentDone(isSuccess : Bool , paymentId : String, msg : String){
        
        if isSuccess{
            self.showAlert(withTitle: SUCCESS_TITLE, andMessage: SUCCESS_MESSAGE)
            if QueryReportFormshow == "query" {
                self.func_QueryForm("0")
            }
            if QueryReportFormshow == "report"{
                self.func_ReportForm()
            }
            if QueryReportFormshow == "voice"{
                self.func_QueryForm("1")
            }
            if QueryReportFormshow == "remedy"{
                self.func_RemedyForm()
            }
        }else{
            self.showAlert(withTitle: "ERROR", andMessage: msg )
        }
        
    }
}

extension QueryReportVC: RazorpayPaymentCompletionProtocolWithData {
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        //        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        //        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}
