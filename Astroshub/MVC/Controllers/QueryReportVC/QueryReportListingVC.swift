//
//  QueryReportListingVC.swift
//  Astroshub
//
//  Created by Kriscent on 24/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class QueryReportListingVC: UIViewController ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var tbl_querylist: UITableView!
    @IBOutlet weak var view_Report: UIView!
    @IBOutlet var tbl_reportlist: UITableView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl3: UILabel!
    var pdfString = ""
    
    var arrQuery = [[String:Any]]()
    var arrReport = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true

        view_Report.isHidden = true
        
        
        self.func_QuerytFormListing()
        
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
                                            
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            if let arrqry = dict_Data["user_id"] as? [[String:Any]]
                                            {
                                                self.arrQuery = arrqry
                                            }
                                            print("arrBlogs is:- ",self.arrQuery)
                                            self.view_Report.isHidden = true
                                            self.lbl1.isHidden = false
                                            self.lbl2.isHidden = true
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
    
    
    func func_RemedyFormListing() {
        
        
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
                                            
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            if let arrqry = dict_Data["user_id"] as? [[String:Any]]
                                            {
                                                self.arrQuery = arrqry
                                            }
                                            print("arrBlogs is:- ",self.arrQuery)
                                            self.view_Report.isHidden = true
                                            self.lbl1.isHidden = false
                                            self.lbl2.isHidden = true
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
                                            
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            if let arrqry = dict_Data["user_id"] as? [[String:Any]]
                                            {
                                                self.arrReport = arrqry
                                            }
                                            print("arrBlogs is:- ",self.arrReport)
                                            self.lbl1.isHidden = true
                                            self.lbl2.isHidden = false
                                            self.view_Report.isHidden = false
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
    
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_QueryAction(_ sender: Any)
    {
        self.func_QuerytFormListing()
    }
    @IBAction func btn_ReportAction(_ sender: Any)
    {
        self.func_ReportFormListing()
    }
    
    @IBAction func btnVoiceQueryAction(_ sender: UIButton) {
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
        else
        {
            return 211
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if tableView == tbl_querylist
        {
            return self.arrQuery.count
        }
        else
        {
            return self.arrReport.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if tableView == tbl_querylist
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "QueryListingCellN", for: indexPath) as! QueryListingCellN
            
            
            cell_Add.btnDownload.tag = indexPath.row
            cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction(_:)), for: .touchUpInside)
            
            let dict_eventpoll = self.arrQuery[indexPath.row]
            let name = dict_eventpoll["asked_query_name"] as! String
            let contact = dict_eventpoll["asked_query_contact_no"] as! String
            let email = dict_eventpoll["asked_query_email"] as! String
            let dob = dict_eventpoll["asked_query_dob"] as! String
            let time = dict_eventpoll["asked_query_time_of_birth"] as! String
            let message = dict_eventpoll["asked_query_message"] as! String
            let status = dict_eventpoll["status"] as! String
            cell_Add.btnDownload.isHidden = true
            
            if status == "Pending"
            {
                cell_Add.lbl7.textColor = UIColor.red
                cell_Add.btnDownload.isHidden = true
            }
            else
            {
                cell_Add.lbl7.textColor = UIColor.green
                cell_Add.btnDownload.isHidden = false
                //cell_Add.btnDownload.isHidden = true
            }
            
            cell_Add.lbl1.text = name
            cell_Add.lbl2.text = contact
            cell_Add.lbl3.text = email
            cell_Add.lbl4.text = dob
            cell_Add.lbl5.text = time
            cell_Add.lbl6.text = message
            cell_Add.lbl7.text = status
            
            return cell_Add
        }
        else
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ReportListingCellN", for: indexPath) as! ReportListingCellN
            
            cell_Add.btnDownload.tag = indexPath.row
            cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction1(_:)), for: .touchUpInside)
            //  cell_Add.btnDownload.isHidden = false
            let dict_eventpoll = self.arrReport[indexPath.row]
            
            
            
            let name = dict_eventpoll["asked_report_customer_name"] as! String
            let contact = dict_eventpoll["asked_report_customer_phone_no"] as! String
            let email = dict_eventpoll["asked_report_customer_email"] as! String
            let reportname = dict_eventpoll["asked_report_customer_report_name"] as! String
            let message = dict_eventpoll["asked_report_customer_text_message"] as! String
            let status = dict_eventpoll["status"] as! String
            if status == "Pending"
            {
                cell_Add.lbl6.textColor = UIColor.red
                cell_Add.btnDownload.isHidden = true
            }
            else
            {
                cell_Add.lbl6.textColor = UIColor.green
                cell_Add.btnDownload.isHidden = false
                // cell_Add.btnDownload.isHidden = true
            }
            cell_Add.lbl1.text = name
            cell_Add.lbl2.text = contact
            cell_Add.lbl3.text = email
            cell_Add.lbl4.text = reportname
            cell_Add.lbl5.text = message
            cell_Add.lbl6.text = status
            return cell_Add
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //            tbl_productcategory.deselectRow(at: indexPath as IndexPath, animated: true)
        //            let EnquiryShop = self.storyboard?.instantiateViewController(withIdentifier: "EnquiryShopVC")
        //            self.navigationController?.pushViewController(EnquiryShop!, animated: true)
        
    }
    @objc func btn_downloadAction(_ sender: UIButton)
    {
        CommenModel.showDefaltAlret(strMessage:"Report emailed to you", controller: self)
        
        return
        //        AutoBcmLoadingView.show("Loading......")
        //        let dict_eventpoll = self.arrQuery[sender.tag]
        //
        //        let querydownload = dict_eventpoll["asked_query_download"] as! String
        //      //  pdfString = querydownload
        //        DispatchQueue.main.async {
        //            self.downloadpdf(pdfURL: querydownload)
        //        }
        //
        //       // self.downloa
        //
        ////        let url = URL(string: querydownload)
        ////        FileDownloader.loadFileAsync(url: url!) { (path, error) in
        ////            print("PDF File downloaded to : \(path!)")
        ////        }
        
        
    }
    
    @objc func btn_downloadAction1(_ sender: UIButton)
    {
        CommenModel.showDefaltAlret(strMessage:"Report emailed to you", controller: self)
        
        return
        //        AutoBcmLoadingView.show("Loading......")
        //        let dict_eventpoll = self.arrReport[sender.tag]
        //
        //        let querydownload = dict_eventpoll["asked_report_customer_download"] as! String
        //
        //        let url = URL(string: querydownload)
        ////        FileDownloader.loadFileAsync(url: url!) { (path, error) in
        ////            print("PDF File downloaded to : \(path!)")
        ////        }
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
        CommenModel.showDefaltAlret(strMessage:"Report emailed to you", controller: self)
        
        return
        let urlString = pdfURL
        let url = URL(string: urlString)
        let fileName = String((url!.lastPathComponent)) as NSString
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
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
                        
                        AutoBcmLoadingView.dismiss()
                        // 3
                        CommenModel.showDefaltAlret(strMessage:"Successfully downloaded.", controller: self!)
                    }
                    
                    //
                    
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                        //Show UIActivityViewController to save the downloaded file
                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                        for indexx in 0..<contents.count {
                            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                self.present(activityViewController, animated: true, completion: nil)
                            }
                        }
                    }
                    catch (let err) {
                        print("error: \(err)")
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
        
        
        //       let url = URL(string: pdfURL)
        //       FileDownloader.loadFileAsync(url: url!) { (path, error) in
        //           print("PDF File downloaded to : \(path!)")
        //          AutoBcmLoadingView.dismiss()
        //       }
        
        
    }
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
}
class QueryListingCellN: UITableViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
}
class ReportListingCellN: UITableViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    // Initialization code
}
