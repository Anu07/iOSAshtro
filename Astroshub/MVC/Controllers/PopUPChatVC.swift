//
//  PopUPChatVC.swift
//  Astroshub
//
//  Created by Kriscent on 09/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class PopUPChatVC: UIViewController, WWCalendarTimeSelectorProtocol {
    
    @IBOutlet weak var view_pop: UIView!
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var btn_date: UIButton!
    @IBOutlet weak var btn_done: UIButton!
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var date_Selectdate = ""
    var postdob = ""
    fileprivate var today: Date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_pop.layer.cornerRadius = 10.0
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.view.addGestureRecognizer(gesture)
        
        let data_IsLogin = UserDefaults.standard.value(forKey: "isUserData") as? Data
        let dict_IsLogin = NSKeyedUnarchiver.unarchiveObject(with:data_IsLogin!) as! [String:Any]
        print("dict_IsLogin is:-",dict_IsLogin)
        
        //               is_ONOFF = dict_IsLogin["astro_call_status"] as! String
        //               astro_call_online_date = dict_IsLogin["astro_call_online_date"] as! String
        //               astro_call_online_time = dict_IsLogin["astro_call_online_time"] as! String
        
        
        
        user_id = dict_IsLogin["user_uni_id"] as! String
        user_apikey = dict_IsLogin["user_api_key"] as! String
        
        btn_cancel.layer.borderWidth = 1
        btn_cancel.layer.borderColor = UIColor.lightGray.cgColor
        btn_cancel.layer.cornerRadius = 6
        
        btn_done.layer.borderWidth = 1
        btn_done.layer.borderColor = UIColor.lightGray.cgColor
        btn_done.layer.cornerRadius = 6
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    @objc func someAction(_ sender:UITapGestureRecognizer){
        print("view was clicked")
        
        // self.removeAnimate()
    }
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            //    self.popupTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: false)
            
            
            
            
            //self.removeAnimate()
        });
    }
    @objc func runTimedCode() {
        
        self.removeAnimate()
        
        //notificationTimer.invalidate()
        
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                
                let EnterCode_VC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC")
                self.navigationController?.pushViewController(EnterCode_VC!, animated: false)
                
                //  let CheckinViewController = self.storyboard?.instantiateViewController(withIdentifier: "CheckinViewController") as! CheckinViewController
                //  self.navigationController?.pushViewController(CheckinViewController, animated: false)
            }
        });
    }
    
    @IBAction func btn_CrossAction(_ sender: Any)
    {
        self.removeAnimate()
        
    }
    @IBAction func btn_DoneAction(_ sender: Any)
    {
        //self.CallstatusMethods()
        
        if Validate.shared.validatepopCHAT(vc: self)
        {
            self.ChatstatusMethods()
        }
        
        
    }
    @IBAction func btn_dateAction(_ sender: Any)
    {
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        
        
        present(selector, animated: true, completion: nil)
    }
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd, 'h':'mma "
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        //   self.date_Selectdate = date.stringFromFormat("yyyy-MM-dd")
        print(self.date_Selectdate)
        
        let dob = date.stringFromFormat("dd-MMM-yyy hh:mm a")
        //  self.date_Selectdate = self.formattedDateFromString(dateString: dob, withFormat: "dd MMM yyyy , 'h':'mma")!
        
        btn_date.setTitleColor(.black, for: .normal)
        btn_date.setTitle(dob,for: .normal)
        
        self.postdob = date.stringFromFormat("yyyy-MM-dd hh:mm")
        
        // dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
    }
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool
    {
        let order = NSCalendar.current.compare(today, to: date, toGranularity: .day)
        if order == .orderedDescending
        {
            //Date selection will be disabled for past days
            return false
        }
        else
        {
            //Allows to select from today
            return true
        }
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        if let date = dates.first {
            singleDate = date
            //  dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
        }
        else {
            // dateLabel.text = "No Date Selected"
        }
        multipleDates = dates
    }
    func ChatstatusMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"astrologer_id":user_id,"astrologer_api_key":user_apikey,"datetime":self.postdob,"status":is_ONOFFCHAT]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.UPDATECHATSTATUS.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            let dict_Data = tempDict["data"] as! NSDictionary
                                            print("dict_Data is:-",dict_Data)
                                            
                                            
                                            let onoff = dict_Data["astro_chat_status"] as! String
                                            let astro_call_online_date1 = dict_Data["astro_online_chat_date"] as! String
                                            let astro_call_online_time1 = dict_Data["astro_online_chat_time"] as! String
                                            
                                            UserDefaults.standard.setValue(onoff, forKey: "chatstatus")
                                            UserDefaults.standard.setValue(astro_call_online_date1, forKey: "astro_chat_date")
                                            UserDefaults.standard.setValue(astro_call_online_time1, forKey: "astro_chat_time")
                                            
                                            
                                            //                                                   is_ONOFF = dict_Data["astro_call_status"] as! String
                                            //                                                   astro_call_online_date = dict_Data["astro_call_online_date"] as! String
                                            //                                                   astro_call_online_time = dict_Data["astro_call_online_time"] as! String
                                            self.removeAnimate()
                                            
                                            
                                            
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
