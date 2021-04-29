//
//  QueryReportListingVC.swift
//  Astroshub
//
//  Created by Kriscent on 24/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import ObjectMapper
class QueryReportListingVC: UIViewController ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var tbl_querylist: UITableView!
    @IBOutlet weak var view_Report: UIView!
    @IBOutlet var tbl_reportlist: UITableView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl3: UILabel!
    var pdfString = ""
    var docController:UIDocumentInteractionController!

    var arrQuery = [[String:Any]]()
    var arrReport = [[String:Any]]()
    var arrQuery1: DataQuery?
var strForQuery = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true

        view_Report.isHidden = true
        strForQuery = "query"
        
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
                                            
                                            if let responseObject = respose as? [String:Any] {
                                                if let loginData = Mapper<QueryVoIceText>().map(JSONObject: responseObject) {
                                                    self.arrQuery1 = loginData.data
                                                }
                                            }
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
        strForQuery = "query"
        self.lbl1.isHidden = false
        self.lbl2.isHidden = true
        self.lbl2.isHidden = true
        self.func_QuerytFormListing()
    }
    @IBAction func btn_ReportAction(_ sender: Any)
    {
        strForQuery = "report"
        self.lbl1.isHidden = true
        self.lbl2.isHidden = true
        self.lbl2.isHidden = false
        self.func_ReportFormListing()
    }
    
    @IBAction func btnVoiceQueryAction(_ sender: UIButton) {
        self.lbl1.isHidden = true
        self.lbl2.isHidden = false
        self.lbl2.isHidden = true
        strForQuery = "voice"
        self.func_QuerytFormListing()

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
            if strForQuery == "query" {
                return self.arrQuery1?.user_id?.text?.count ?? 0
            }  else {
                return self.arrQuery1?.user_id?.audio?.count ?? 0
            }
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
            if strForQuery == "query" {
                cell_Add.btnDownload.tag = indexPath.row
                cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction(_:)), for: .touchUpInside)
                cell_Add.btnDownload.isHidden = true
                let dict_eventpoll = self.arrQuery1?.user_id?.text?[indexPath.row]
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
            } else  {
                cell_Add.btnDownload.tag = indexPath.row
                cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction2(_:)), for: .touchUpInside)
                cell_Add.btnDownload.isHidden = true
                let dict_eventpoll = self.arrQuery1?.user_id?.audio?[indexPath.row]
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
            
            
            return cell_Add
//
//            cell_Add.btnDownload.tag = indexPath.row
//            cell_Add.btnDownload.addTarget(self, action: #selector(self.btn_downloadAction(_:)), for: .touchUpInside)
//
//            let dict_eventpoll = self.arrQuery[indexPath.row]
//            let name = dict_eventpoll["asked_query_name"] as! String
//            let contact = dict_eventpoll["asked_query_contact_no"] as! String
//            let email = dict_eventpoll["asked_query_email"] as! String
//            let dob = dict_eventpoll["asked_query_dob"] as! String
//            let time = dict_eventpoll["asked_query_time_of_birth"] as! String
//            let message = dict_eventpoll["asked_query_message"] as! String
//            let status = dict_eventpoll["status"] as! String
//            cell_Add.btnDownload.isHidden = true
//
//            if status == "Pending"
//            {
//                cell_Add.lbl7.textColor = UIColor.red
//                cell_Add.btnDownload.isHidden = true
//            }
//            else
//            {
//                cell_Add.lbl7.textColor = UIColor.green
//                cell_Add.btnDownload.isHidden = false
//                //cell_Add.btnDownload.isHidden = true
//            }
//
//            cell_Add.lbl1.text = name
//            cell_Add.lbl2.text = contact
//            cell_Add.lbl3.text = email
//            cell_Add.lbl4.text = dob
//            cell_Add.lbl5.text = time
//            cell_Add.lbl6.text = message
//            cell_Add.lbl7.text = status
//
//            return cell_Add
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
        let dict_eventpoll = self.arrQuery1?.user_id?.text?[sender.tag]
        let querydownload = dict_eventpoll?.asked_query_download ?? ""
        self.downloadpdf(pdfURL: querydownload)
    }
    
    @objc func btn_downloadAction2(_ sender: UIButton)
    {
        let dict_eventpoll = self.arrQuery1?.user_id?.audio?[sender.tag]
        let querydownload = dict_eventpoll?.asked_query_download ?? ""
        self.downloadpdf(pdfURL: querydownload)
    }
    
    func downloadpdf(pdfURL : String){
        let urlString = pdfURL
        let url = URL(string: urlString)
        
        if !urlString.isEmpty{
            checkBookFileExists(withLink: urlString){ [weak self] downloadPath in
                guard let self = self else{
                    return
                }
                //                    play(url: downloadedURL)
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
            }else{
                print("file doesnt exist")
            }
        }else{
            print("file doesnt exist")
        }
    }
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
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
        self.docController = UIDocumentInteractionController(url: pdfUrl)
        self.docController.delegate = self
        self.docController.presentOptionsMenu(from: view.frame, in: self.view, animated: true)
    }
    
    @objc func btn_downloadAction1(_ sender: UIButton)
    {
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
extension QueryReportListingVC:UIDocumentInteractionControllerDelegate{
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}
