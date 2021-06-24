//
//  HistorytotalVC.swift
//  Astroshub
//
//  Created by Kriscent on 24/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import ObjectMapper
class HistorytotalVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var labelChat: UILabel!
    
    @IBOutlet weak var label6: UILabel!
    
    @IBOutlet var tbl_querylist: UITableView!
    @IBOutlet weak var view_Report: UIView!
    @IBOutlet weak var view_Chat: UIView!
    @IBOutlet weak var view_Call: UIView!
    @IBOutlet var tbl_reportlist: UITableView!
    @IBOutlet var tbl_chatlist: UITableView!
    @IBOutlet var tbl_calllist: UITableView!
    var arrQuery: DataQuery?
    var arrVoiceQuery = [[String:Any]]()
    var docController:UIDocumentInteractionController!

    var arrReport = [[String:Any]]()
    var arrChat = [[String:Any]]()
    var arrCall = [[String:Any]]()
    var arrRemedy =  [User_id]()
    var strForRemedyreport :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true
        lbl4.isHidden = true
        labelChat.isHidden = true
        label6.isHidden = true
        view_Report.isHidden = true
        view_Chat.isHidden = true
        view_Call.isHidden = true
        self.func_QuerytFormListing()
        tbl_querylist.reloadData()
        strForRemedyreport = "Query"
        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_QuerytFormListing() {
        
        
    let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id]
    print(setparameters)
    AutoBcmLoadingView.show("Loading......")
    AppHelperModel.requestPOSTURL("viewQueryUser", params: setparameters as [String : AnyObject],headers: nil,
      success: { (respose) in
        AutoBcmLoadingView.dismiss()
        let tempDict = respose as! NSDictionary
        print(tempDict)
        let success=tempDict["response"] as!   Bool
        let message=tempDict["msg"] as!   String
        
        if success == true
        {
            
            if let responseObject = respose as? [String:Any] {
                if let loginData = Mapper<QueryVoIceText>().map(JSONObject: responseObject) {
                    self.arrQuery = loginData.data
                }
            }
//            
//            self.arrQuery = [[String:Any]]()
            
            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
//            let dict_Data = tempDict["data"] as! [String:Any]
//            print("dict_Data is:- ",dict_Data)
//            if let arrqry = dict_Data["user_id"] as? [[String:Any]]
//            {
//                self.arrQuery = arrqry[""]
//                self.arrVoiceQuery =  arrqry["audio"]
//            }
//            print("arrBlogs is:- ",self.arrQuery)
            // self.view_Report.isHidden = true
            // self.lbl1.isHidden = false
            // self.lbl2.isHidden = true
            self.tbl_querylist.reloadData()
            
            
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
    
    
    
    func func_ReportFormListing() {
        
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("viewReportUser", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            self.arrReport = [[String:Any]]()
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            if let arrqry = dict_Data["user_id"] as? [[String:Any]]
                                            {
                                                self.arrReport = arrqry
                                            }
                                            print("arrBlogs is:- ",self.arrReport)
                                            
                                            self.tbl_reportlist.reloadData()
                                            
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
    func func_ChatFormListing() {

        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id,"location":CurrentLocation]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("getUserChatListing", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            self.arrChat = [[String:Any]]()
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                            //                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            //                                            print("dict_Data is:- ",dict_Data)
                                            if let arrqry = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrChat = arrqry
                                            }
                                            print("arrBlogs is:- ",self.arrChat)
                                            
                                            self.tbl_chatlist.reloadData()
                                            
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
    func func_CallFormListing() {
        
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id,"location":CurrentLocation]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("userCallHistory", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            self.arrCall = [[String:Any]]()
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                            // let dict_Data = tempDict["data"] as! [String:Any]
                                            // print("dict_Data is:- ",dict_Data)
                                            if let arrqry = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrCall = arrqry
                                            }
                                            print("arrBlogs is:- ",self.arrCall)
                                            
                                            self.tbl_calllist.reloadData()
                                            
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
    
    
    func func_RemedyFormListing() {
        
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id,"location":CurrentLocation]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("getRemedyHistory", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            if let responseObject = respose as? [String:Any] {
                                                if let loginData = Mapper<RemedyBase>().map(JSONObject: responseObject) {
                                                    self.arrRemedy = loginData.data?.user_id ?? []
                                                }
                                            }
                                            self.tbl_querylist.reloadData()
                                            
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
    @IBAction func btn_QueryAction(_ sender: Any)
    {
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true
        lbl4.isHidden = true
        labelChat.isHidden = true
        label6.isHidden = true
        strForRemedyreport = "Query"
       
        view_Report.isHidden = true
        view_Chat.isHidden = true
        view_Call.isHidden = true
        self.func_QuerytFormListing()
        tbl_querylist.reloadData()
    }
    @IBAction func btn_VoiceQuery(_ sender: UIButton) {
        
        lbl1.isHidden = true
        lbl2.isHidden = false
        lbl3.isHidden = true
        lbl4.isHidden = true
        labelChat.isHidden = true
        label6.isHidden = true
        
        strForRemedyreport = "voice"
        
        view_Report.isHidden = true
        view_Chat.isHidden = true
        view_Call.isHidden = true
        self.func_QuerytFormListing()
        
    }
    @IBAction func btn_ReportAction(_ sender: Any)
    {
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = false
        lbl4.isHidden = true
        labelChat.isHidden = true
        view_Report.isHidden = false
        view_Chat.isHidden = true
        view_Call.isHidden = true
        self.func_ReportFormListing()
    }
    @IBAction func btn_chatAction(_ sender: Any)
    {
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = true
        lbl4.isHidden = true
        labelChat.isHidden = false
        label6.isHidden = true
        
        view_Report.isHidden = true
        view_Chat.isHidden = false
        view_Call.isHidden = true
        
        self.func_ChatFormListing()
    }
    @IBAction func btn_callAction(_ sender: Any)
    {
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = true
        lbl4.isHidden = true
        labelChat.isHidden = true
        label6.isHidden = false
        
        view_Report.isHidden = true
        view_Chat.isHidden = true
        view_Call.isHidden = false
        self.func_CallFormListing()
    }
    
    @IBAction func btnRemdy(_ sender: UIButton) {
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = true
        lbl4.isHidden = false
        labelChat.isHidden = true
        label6.isHidden = true
        
        view_Report.isHidden = true
        view_Chat.isHidden = true
        view_Call.isHidden = true
        strForRemedyreport = "Remedy"
        
        func_RemedyFormListing()
    }
    
    //****************************************************
    // MARK: - Table Method
    //****************************************************
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tbl_querylist
        {
            return 246
        }
        else if tableView == tbl_reportlist
        {
            return 211
        }
        else if tableView == tbl_chatlist
        {
            return 249
        }
        else
        {
            return 270
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        if tableView == tbl_querylist
        {
            if strForRemedyreport == "Query" {
                return self.arrQuery?.user_id?.text?.count ?? 0
            } else if strForRemedyreport == "voice" {
                return self.arrQuery?.user_id?.audio?.count ?? 0
            }
            else {
                return self.arrRemedy.count
            }
            
        }
        else if tableView == tbl_reportlist
        {
            return self.arrReport.count
            
        }
        else if tableView == tbl_chatlist
        {
            return self.arrChat.count
        }
        else
        {
            return self.arrCall.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        if tableView == tbl_querylist
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "QueryListingCellN", for: indexPath) as! QueryListingCellN
            if strForRemedyreport == "Query" {
                cell_Add.btnDownload.tag = indexPath.row
                cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction(_:)), for: .touchUpInside)
                cell_Add.btnDownload.isHidden = true
                let dict_eventpoll = self.arrQuery?.user_id?.text?[indexPath.row]
                if dict_eventpoll?.status ?? "" == "Pending"
                {
                    cell_Add.lbl7.textColor = UIColor.red
                    cell_Add.btnDownload.isHidden = true
                }
                else if dict_eventpoll?.status  ?? "" == "Complete"
                {
                    cell_Add.lbl7.textColor = UIColor.green
                    cell_Add.btnDownload.isHidden = false
                }
                else
                {
                    cell_Add.lbl7.textColor = UIColor.green
                    cell_Add.btnDownload.isHidden = true
                }
                
                cell_Add.lbl1.text = (dict_eventpoll?.asked_query_name ?? "")
                cell_Add.lbl2.text = (dict_eventpoll?.asked_query_contact_no ?? "")
                cell_Add.lbl3.text = (dict_eventpoll?.asked_query_email ?? "")
                cell_Add.lbl4.text = dict_eventpoll?.asked_query_dob ?? ""
                cell_Add.lbl5.text = (dict_eventpoll?.asked_query_time_of_birth ?? "")
                cell_Add.lbl6.text = (dict_eventpoll?.asked_query_message ?? "")
                cell_Add.lbl7.text = (dict_eventpoll?.status ?? "")
            } else if strForRemedyreport == "voice" {
                cell_Add.btnDownload.tag = indexPath.row
                cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction(_:)), for: .touchUpInside)
                cell_Add.btnDownload.isHidden = true
                let dict_eventpoll = self.arrQuery?.user_id?.audio?[indexPath.row]
                if dict_eventpoll?.status  ?? "" == "Pending"
                {
                    cell_Add.lbl7.textColor = UIColor.red
                    cell_Add.btnDownload.isHidden = true
                }
                else if dict_eventpoll?.status  ?? "" == "Complete"
                {
                    cell_Add.lbl7.textColor = UIColor.green
                    cell_Add.btnDownload.isHidden = false
                }
                else
                {
                    cell_Add.lbl7.textColor = UIColor.green
                    cell_Add.btnDownload.isHidden = true
                }
                
                cell_Add.lbl1.text = dict_eventpoll?.asked_query_name ?? ""
                cell_Add.lbl2.text = dict_eventpoll?.asked_query_contact_no ?? ""
                cell_Add.lbl3.text = dict_eventpoll?.asked_query_email ?? ""
                cell_Add.lbl4.text = dict_eventpoll?.asked_query_dob ?? ""
                cell_Add.lbl5.text = dict_eventpoll?.asked_query_time_of_birth ?? ""
                cell_Add.lbl6.text = dict_eventpoll?.asked_query_message ?? ""
                cell_Add.lbl7.text = dict_eventpoll?.status ?? ""
            }
            
            else {
                cell_Add.btnDownload.tag = indexPath.row
                
                cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction(_:)), for: .touchUpInside)
                cell_Add.btnDownload.isHidden = true
                if arrRemedy[indexPath.row].status == "Pending"
                {
                    cell_Add.lbl7.textColor = UIColor.red
                    cell_Add.btnDownload.isHidden = true
                }
                else if arrRemedy[indexPath.row].status == "Complete"
                {
                    cell_Add.lbl7.textColor = UIColor.green
                    cell_Add.btnDownload.isHidden = false
                }
                else
                {
                    cell_Add.lbl7.textColor = UIColor.green
                    cell_Add.btnDownload.isHidden = true
                }
                
                cell_Add.lbl1.text = arrRemedy[indexPath.row].remedy_name
                cell_Add.lbl2.text = arrRemedy[indexPath.row].remedy_contact_no
                cell_Add.lbl3.text = arrRemedy[indexPath.row].remedy_email
                cell_Add.lbl4.text = arrRemedy[indexPath.row].remedy_dob
                cell_Add.lbl5.text = arrRemedy[indexPath.row].remedy_time_of_birth
                cell_Add.lbl6.text = arrRemedy[indexPath.row].remedy_message
                cell_Add.lbl7.text =  arrRemedy[indexPath.row].status
            }
            return cell_Add
        }
        else if tableView == tbl_reportlist
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ReportListingCellN", for: indexPath) as! ReportListingCellN
            //            if strForRemedyreport == "Report" {
            cell_Add.btnDownload.tag = indexPath.row
            cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction1(_:)), for: .touchUpInside)
            let dict_eventpoll = self.arrReport[indexPath.row]
            cell_Add.btnDownload.isHidden = true
            if dict_eventpoll["status"] as! String == "Pending"
            {
                cell_Add.lbl6.textColor = UIColor.red
                cell_Add.btnDownload.isHidden = true
            } else if dict_eventpoll["status"] as! String == "Complete" {
                cell_Add.lbl6.textColor = UIColor.green
                cell_Add.btnDownload.isHidden = false
            } else {
                cell_Add.lbl6.textColor = UIColor.green
                cell_Add.btnDownload.isHidden = true
            }
            cell_Add.lbl1.text = (dict_eventpoll["asked_report_customer_name"] as! String )
            cell_Add.lbl2.text = ( dict_eventpoll["asked_report_customer_phone_no"] as! String)
            cell_Add.lbl3.text = (dict_eventpoll["asked_report_customer_email"] as! String)
            cell_Add.lbl4.text = (dict_eventpoll["asked_report_customer_report_name"] as! String)
            cell_Add.lbl5.text = (dict_eventpoll["asked_report_customer_text_message"] as! String)
            cell_Add.lbl6.text = (dict_eventpoll["status"] as! String)
            return cell_Add
        }
        else if tableView == tbl_chatlist
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ChatListingCellN", for: indexPath) as! ChatListingCellN
            let dict_eventpoll = self.arrChat[indexPath.row]
            cell_Add.lbl1.text = dict_eventpoll["AstroName"] as? String
            cell_Add.lbl2.text = (dict_eventpoll["customername"] as! String)
            cell_Add.lbl3.text = dict_eventpoll["problem_area"] as? String
            cell_Add.lbl4.text = (dict_eventpoll["order_date"] as! String)
            cell_Add.lbl5.text = (dict_eventpoll["duration"] as! String)
            cell_Add.lbl6.text = (dict_eventpoll["price"] as! String)
            cell_Add.btnRefundRequest.layer.cornerRadius = 10.0
            cell_Add.btnRefundRequest.clipsToBounds = true
            
            cell_Add.seeChat.layer.cornerRadius = 10.0
            cell_Add.seeChat.clipsToBounds = true
            cell_Add.btnRefundRequest.tag = indexPath.row
            cell_Add.btnRefundRequest.addTarget(self, action: #selector(self.btn_RefundApi(_:)), for: .touchUpInside)
            
            cell_Add.seeChat.tag = indexPath.row
            cell_Add.seeChat.addTarget(self, action: #selector(self.btn_seechat(_:)), for: .touchUpInside)
            let array = (dict_eventpoll["order_date"] as! String).components(separatedBy: "(")
print(array)
//            let strForDate = (dict_eventpoll["order_date"] as! String).replacingCharacters(in: "()", with: "")
            let get_OutputStr = convertDateFormat(inputDate:array[0])

//            if let date1 = get_OutputStr {
                if let diff = Calendar.current.dateComponents([.hour], from: get_OutputStr, to: Date()).hour, diff > 48 {
                    //do something
                    cell_Add.btnRefundRequest.isHidden = true
                    
                } else {
                    cell_Add.btnRefundRequest.isHidden = false

                }
//            }
            return cell_Add
        }
        else
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "CallListingCellN", for: indexPath) as! CallListingCellN
            //            let dict_eventpoll = self.arrReport[indexPath.row]
            //
            cell_Add.refundrequest.tag = indexPath.row
            cell_Add.refundrequest.addTarget(self, action: #selector(self.btn_RefundCallApi(_:)), for: .touchUpInside)
            let dict_eventpoll = self.arrCall[indexPath.row]
            
            let orderid = dict_eventpoll["orderid"] as! String
            let customername = dict_eventpoll["customername"] as! String
            let user_gender = dict_eventpoll["user_gender"] as! String
            let user_dob = dict_eventpoll["user_dob"] as! String
            let order_date = dict_eventpoll["order_date"] as! String
            let duration = dict_eventpoll["duration"] as! String
            let status = dict_eventpoll["status"] as! String
            let price = dict_eventpoll["total_amount"] as! String
            
            
            if status == "Pending"
            {
                cell_Add.lbl7.textColor = UIColor.red
            }
            else if status == "Complete"
            {
                cell_Add.lbl7.textColor = UIColor.green
                
            }
            else
            {
                cell_Add.lbl7.textColor = UIColor.red
            }
            let array = (dict_eventpoll["order_date"] as! String).components(separatedBy: "(")
print(array)
//            let strForDate = (dict_eventpoll["order_date"] as! String).replacingCharacters(in: "()", with: "")
            let get_OutputStr = convertDateFormat(inputDate:array[0])

//            if let date1 = get_OutputStr {
                if let diff = Calendar.current.dateComponents([.hour], from: get_OutputStr, to: Date()).hour, diff > 48 {
                    //do something
                    cell_Add.refundrequest.isHidden = true
                    
                } else {
                    cell_Add.refundrequest.isHidden = false

                }
//            }
            cell_Add.lbl1.text = orderid
            cell_Add.lbl2.text = customername
            cell_Add.lbl3.text = user_gender
            cell_Add.lbl4.text = user_dob
            cell_Add.lbl5.text = order_date
            cell_Add.lbl6.text = duration
            cell_Add.lbl7.text = status
            cell_Add.lbl8.text =  price
            return cell_Add
        }
        
        
    }
    func convertDateFormat(inputDate: String) -> Date {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "dd-MMM-yyyy"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
let str =  convertDateFormatter.string(from: oldDate!)
        return convertDateFormatter.date(from: str) ?? Date()
           
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //            tbl_productcategory.deselectRow(at: indexPath as IndexPath, animated: true)
        //            let EnquiryShop = self.storyboard?.instantiateViewController(withIdentifier: "EnquiryShopVC")
        //            self.navigationController?.pushViewController(EnquiryShop!, animated: true)
    }
    
    
    func dayDifference(from interval : TimeInterval) -> String
    {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: interval)
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(-day) days ago" }
            else { return "In \(day) days" }
        }
    }
    @objc func btn_seechat(_ sender: UIButton)
    {
        let dict_eventpoll = self.arrChat[sender.tag]
        guard let chat = self.storyboard?.instantiateViewController(withIdentifier: "ChatHistoryViewController")
        as? ChatHistoryViewController else {
            return
        }
        chat.astroId = dict_eventpoll["astrologer_id"] as? String ?? ""
        self.navigationController?.show(chat, sender: self)
    }
    
    @objc func btn_RefundApi(_ sender: UIButton)
    {
        let dict_eventpoll = self.arrChat[sender.tag]
        func_RefundChat(dict_eventpoll["uniqeid"] as? String ?? "", title: dict_eventpoll["AstroName"] as? String ?? "", message: dict_eventpoll["AstroName"] as? String ?? "", type: "chat")
    }
    
    @objc func btn_RefundCallApi(_ sender: UIButton)
    {
        let dict_eventpoll = self.arrCall[sender.tag]
        func_RefundChat(dict_eventpoll["uniqeid"] as? String ?? "", title: dict_eventpoll["AstroName"] as? String ?? "", message: dict_eventpoll["AstroName"] as? String ?? "", type: "call")
    }
    func func_RefundChat(_ uniqueId:String, title:String, message:String,type:String) {
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id,"refund_unique_id":uniqueId,"title":title,"message":message,"type":type]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("refundRequest", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
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
    
    @objc func btn_downloadAction(_ sender: UIButton)
    {
        if strForRemedyreport == "Query" {
          AutoBcmLoadingView.show("Loading......")
            let dict_eventpoll = self.arrQuery?.user_id?.text?[sender.tag]
            let querydownload = dict_eventpoll?.asked_query_download ?? ""
            self.downloadpdf(pdfURL: querydownload)
        } else  if strForRemedyreport == "voice" {
            AutoBcmLoadingView.show("Loading......")
            let dict_eventpoll = self.arrQuery?.user_id?.audio?[sender.tag]
            let querydownload = dict_eventpoll?.asked_query_download ?? ""
            self.downloadpdf(pdfURL: querydownload)
        }
        else {
            AutoBcmLoadingView.show("Loading......")
            let querydownload = arrRemedy[sender.tag].asked_redemy_download ?? ""
            self.downloadpdf(pdfURL: querydownload)
        }
    }
    

    func downloadpdf(pdfURL : String){
        let urlString = pdfURL
        _ = URL(string: urlString)
        if !urlString.isEmpty{
            checkBookFileExists(withLink: urlString){ [weak self] downloadPath in
                guard self != nil else{
                    return
                }
            }
        }
    }
    func checkBookFileExists(withLink link: String, completion: @escaping ((_ filePath: URL)->Void)){
        
        let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        if let url  = URL.init(string: urlString ?? ""){
            let fileManager = FileManager.default
            if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){
                let filePath = documentDirectory.appendingPathComponent(url.lastPathComponent, isDirectory: false)
                do {
                    AutoBcmLoadingView.dismiss()
                    if try filePath.checkResourceIsReachable() {
                        print("file exist")
                        completion(filePath)
                        
                        self.open_pdf(pdfUrl : filePath)
                    } else {
                        print("file doesnt exist")
                        downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
                    }
                } catch {
                    print("file doesnt exist")
                    downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
                }
            } else {
                print("file doesnt exist")
            }
        } else {
            print("file doesnt exist")
        }
    }
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
        AutoBcmLoadingView.dismiss()
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data.init(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                print("saved at \(filePath.absoluteString)")
                self.open_pdf(pdfUrl : filePath)
                DispatchQueue.main.async {
                    completion(filePath)
                }
            } catch {
                print("an error happened while downloading or saving the file")
            }
        }
    }
    func open_pdf(pdfUrl : URL) {
        
        //        if let fileURL = NSBundle.mainBundle().URLForResource("MyImage", withExtension: "jpg") {
        // Instantiate the interaction controller
        
        //        if (pdfUrl != "") {
        // Initialize Document Interaction Controller
        self.docController = UIDocumentInteractionController(url: pdfUrl)
        
        // Configure Document Interaction Controller
        self.docController.delegate = self
        DispatchQueue.main.async {
        // Present Open In Menu
//            DispatchQueue.global().async {
            self.docController.presentOptionsMenu(from: self.view.frame, in: self.view, animated: true)
        }
     
    }
    
    @objc func btn_downloadAction1(_ sender: UIButton)
    {
        //        CommenModel.showDefaltAlret(strMessage:"Report emailed to you", controller: self)
        //
        //        return
                AutoBcmLoadingView.show("Loading......")
                let dict_eventpoll = self.arrReport[sender.tag]
        
                let querydownload = dict_eventpoll["asked_report_customer_download"] as! String
                self.downloadpdf(pdfURL: querydownload)
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
   
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
}
class ChatListingCellN: UITableViewCell {
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var lbl8: UILabel!
    
    @IBOutlet weak var seeChat: UIButton!
    @IBOutlet weak var btnRefundRequest: UIButton!
    
    
    // Initialization code
}
class CallListingCellN: UITableViewCell {
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var lbl8: UILabel!
    
    @IBOutlet weak var refundrequest: UIButton!
    
    // Initialization code
}
extension HistorytotalVC:UIDocumentInteractionControllerDelegate{
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}
extension Date
{

  func dateAt(hours: Int, minutes: Int) -> Date
  {
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!

    //get the month/day/year componentsfor today's date.


    var date_components = calendar.components(
      [NSCalendar.Unit.year,
       NSCalendar.Unit.month,
       NSCalendar.Unit.day],
      from: self)

    //Create an NSDate for the specified time today.
    date_components.hour = hours
    date_components.minute = minutes
    date_components.second = 0

    let newDate = calendar.date(from: date_components)!
    return newDate
  }
}
