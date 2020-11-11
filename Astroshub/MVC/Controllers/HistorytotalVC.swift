//
//  HistorytotalVC.swift
//  Astroshub
//
//  Created by Kriscent on 24/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class HistorytotalVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var labelChat: UILabel!
    
    
    @IBOutlet var tbl_querylist: UITableView!
    @IBOutlet weak var view_Report: UIView!
    @IBOutlet weak var view_Chat: UIView!
    @IBOutlet weak var view_Call: UIView!
    @IBOutlet var tbl_reportlist: UITableView!
    @IBOutlet var tbl_chatlist: UITableView!
    @IBOutlet var tbl_calllist: UITableView!
    var arrQuery = [[String:Any]]()
    var arrReport = [[String:Any]]()
    var arrChat = [[String:Any]]()
    var arrCall = [[String:Any]]()
    var arrRemedy = [[String:Any]]()
    var strForRemedyreport :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true
        lbl4.isHidden = true
        labelChat.isHidden = true

        view_Report.isHidden = true
        view_Chat.isHidden = true
        view_Call.isHidden = true
        self.func_QuerytFormListing()
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
                                            self.arrQuery = [[String:Any]]()
                                            
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            if let arrqry = dict_Data["user_id"] as? [[String:Any]]
                                            {
                                                self.arrQuery = arrqry
                                            }
                                            print("arrBlogs is:- ",self.arrQuery)
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
                                            
                                            self.arrRemedy = [[String:Any]]()
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                            // let dict_Data = tempDict["data"] as! [String:Any]
                                            // print("dict_Data is:- ",dict_Data)
                                            if let arrqry = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrRemedy = arrqry
                                            }
                                            print("arrBlogs is:- ",self.arrRemedy)
                                            
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
        strForRemedyreport = "Query"

        view_Report.isHidden = true
        view_Chat.isHidden = true
        view_Call.isHidden = true
        self.func_QuerytFormListing()

    }
    @IBAction func btn_ReportAction(_ sender: Any)
    {
        lbl1.isHidden = true
        lbl2.isHidden = false
        lbl3.isHidden = true
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
        lbl4.isHidden = false
        labelChat.isHidden = true

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
        labelChat.isHidden = false

        view_Report.isHidden = true
        view_Chat.isHidden = true
        view_Call.isHidden = false
        self.func_CallFormListing()
    }
    
    @IBAction func btnRemdy(_ sender: UIButton) {
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = false
        lbl4.isHidden = true
        labelChat.isHidden = true
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
            return 249
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        if tableView == tbl_querylist
        {
            if strForRemedyreport == "Query" {
            return self.arrQuery.count
            } else {
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
            let dict_eventpoll = self.arrQuery[indexPath.row]
            if dict_eventpoll["status"] as! String == "Pending"
            {
                cell_Add.lbl7.textColor = UIColor.red
                cell_Add.btnDownload.isHidden = false
            }
            else if dict_eventpoll["status"] as! String == "Complete"
            {
                cell_Add.lbl7.textColor = UIColor.green
                cell_Add.btnDownload.isHidden = false
            }
            else
            {
                cell_Add.lbl7.textColor = UIColor.green
                cell_Add.btnDownload.isHidden = true
            }
            
            cell_Add.lbl1.text = (dict_eventpoll["asked_query_name"] as! String)
            cell_Add.lbl2.text = (dict_eventpoll["asked_query_contact_no"] as! String)
            cell_Add.lbl3.text = (dict_eventpoll["asked_query_email"] as! String)
            cell_Add.lbl4.text = (dict_eventpoll["asked_query_dob"] as! String)
            cell_Add.lbl5.text = (dict_eventpoll["asked_query_time_of_birth"] as! String)
            cell_Add.lbl6.text = (dict_eventpoll["asked_query_message"] as! String)
            cell_Add.lbl7.text = (dict_eventpoll["status"] as! String)
            } else {
                
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
                }
                else if dict_eventpoll["status"] as! String == "Complete"
                {
                    cell_Add.lbl6.textColor = UIColor.green
                    cell_Add.btnDownload.isHidden = false
                }
                else
                {
                    cell_Add.lbl6.textColor = UIColor.green
                    cell_Add.btnDownload.isHidden = true
                }
                
                cell_Add.lbl1.text = (dict_eventpoll["asked_report_customer_name"] as! String )
                cell_Add.lbl2.text = ( dict_eventpoll["asked_report_customer_phone_no"] as! String)
                cell_Add.lbl3.text = (dict_eventpoll["asked_report_customer_email"] as! String)
                cell_Add.lbl4.text = (dict_eventpoll["asked_report_customer_report_name"] as! String)
                cell_Add.lbl5.text = (dict_eventpoll["asked_report_customer_text_message"] as! String)
                cell_Add.lbl6.text = (dict_eventpoll["status"] as! String)
//            } else {
//
//            }
            
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
            cell_Add.btnRefundRequest.tag = indexPath.row
            cell_Add.btnRefundRequest.addTarget(self, action: #selector(self.btn_RefundApi(_:)), for: .touchUpInside)
            return cell_Add
        }
        else
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "CallListingCellN", for: indexPath) as! CallListingCellN
            //            let dict_eventpoll = self.arrReport[indexPath.row]
            //
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //            tbl_productcategory.deselectRow(at: indexPath as IndexPath, animated: true)
        //            let EnquiryShop = self.storyboard?.instantiateViewController(withIdentifier: "EnquiryShopVC")
        //            self.navigationController?.pushViewController(EnquiryShop!, animated: true)
    }
    
    @objc func btn_RefundApi(_ sender: UIButton)
    {
        let dict_eventpoll = self.arrChat[sender.tag]
        func_RefundChat(dict_eventpoll["uniqeid"] as? String ?? "", title: dict_eventpoll["AstroName"] as? String ?? "", message: dict_eventpoll["AstroName"] as? String ?? "")
//        refundRequest
        
    }
    
    
    func func_RefundChat(_ uniqueId:String, title:String, message:String) {
//        map.put("app_version", "" + Config.App_Version);
//                map.put("app_type", "" + Config.App_Type);
//                map.put("user_id", sessionManager.getPreferences(getActivity(), Config.User_uni_id));
//                map.put("user_api_key", sessionManager.getPreferences(getActivity(), Config.User_api_key));
//                map.put("refund_unique_id", "" + chat_id);
//                map.put("title", "" + title);
//                map.put("message", "" + message);
//                map.put("type", "call");
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id,"refund_unique_id":uniqueId,"title":title,"message":message,"type":"chat"]
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
    
    @objc func btn_downloadAction(_ sender: UIButton)
    {
//        CommenModel.showDefaltAlret(strMessage:"Report emailed to you", controller: self)
//        
//        
//        return
                AutoBcmLoadingView.show("Loading......")
                let dict_eventpoll = self.arrQuery[sender.tag]
        
                let querydownload = dict_eventpoll["asked_query_download"] as! String
        
                self.downloadpdf(pdfURL: querydownload)
        //
    }
    
    @objc func btn_downloadAction1(_ sender: UIButton)
    {
//        CommenModel.showDefaltAlret(strMessage:"Report emailed to you", controller: self)
//
//        return
        //        AutoBcmLoadingView.show("Loading......")
        //        let dict_eventpoll = self.arrReport[sender.tag]
        //
        //        let querydownload = dict_eventpoll["asked_query_download"] as! String
        //        self.downloadpdf(pdfURL: querydownload)
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
    
    func downloadpdf(pdfURL : String){
//        CommenModel.showDefaltAlret(strMessage:"Report emailed to you", controller: self)
//
//        return
        let urlString = pdfURL
        let url = URL(string: urlString)
        let fileName = String((url!.lastPathComponent)) as NSString
        // Create destination URL
        let documentsUrl:URL? =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let destinationFileUrl = documentsUrl?.appendingPathComponent("\(fileName)")
        //Create URL to the source file you want to download
        let fileURL = URL(string: urlString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                    
                    DispatchQueue.main.async { [weak self] in
                        // 3
                        AutoBcmLoadingView.dismiss()
                        CommenModel.showDefaltAlret(strMessage:"Successfully downloaded.", controller: self!)
                    }
                    
                    //
                    
                }
                do {
                    if let getDestinationFileUrl = destinationFileUrl, let getDocumentUrl = documentsUrl {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: getDestinationFileUrl)
                        do {
                            //Show UIActivityViewController to save the downloaded file
                            let contents  = try FileManager.default.contentsOfDirectory(at: getDocumentUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                            for indexx in 0..<contents.count {
                                if contents[indexx].lastPathComponent == getDestinationFileUrl.lastPathComponent {
                                    let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                    self.present(activityViewController, animated: true, completion: nil)
                                }
                            }
                        }
                        catch (let err) {
                            print("error: \(err)")
                        }
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
        
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
    
    
    // Initialization code
}
