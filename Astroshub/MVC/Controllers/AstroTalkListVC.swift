//
//  AstroTalkListVC.swift
//  Astroshub
//
//  Created by Kriscent on 21/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation
import MapKit
import ObjectMapper
class AstroTalkListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MKMapViewDelegate {
    @IBOutlet var txt_search: UITextField!
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_talklist: UITableView!
    var arrTalk = [[String:Any]]()
    let kMaxItemCount = 1000
    let kPageLength   = 10
    var items: [Int] = []
    var isSearchingEnable = false
    var page = 0
    var pagereload = 0
    var url_flag = 1
    var index_value = 0
    
    var refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !hasLocationPermission() {
            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
                  
                  let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                      //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                  })
                  
//                  let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
//                  alertController.addAction(cancelAction)
                  
                  alertController.addAction(okAction)
                  
                  self.present(alertController, animated: true, completion: nil)
        } else {
        self.astrotalklistApiCallMethods()
        refreshController.addTarget(self, action:#selector(handleRefresh(_:)), for: .valueChanged)
        tbl_talklist.addSubview(refreshController)
        self.tbl_talklist.am.addInfiniteScrolling { [unowned self] in
            self.fetchMoreData(completion: { (fetchedItems) in
                self.items.append(contentsOf: fetchedItems)
                
                if self.arrTalk.count >= 10
                {
                    self.pagereload = 1
                    self.page = self.page + 1
                    self.url_flag = 1
                    
                    self.astrotalklistApiCallMethods()
                }
                self.tbl_talklist.reloadData()
                self.tbl_talklist.am.infiniteScrollingView?.stopRefreshing()
                if fetchedItems.count == 0 {
                    //No more data is available
                    self.tbl_talklist.am.infiniteScrollingView?.hideInfiniteScrollingView()
                }
            })
        }
        self.tbl_talklist.am.pullToRefreshView?.trigger()
        }
        
    }
    
    @objc func handleRefresh(_ sender: Any?)
    {
        print("Pull To Refresh Method Called")
        page = 0
        pagereload = 0
        url_flag = 1
        refreshController.endRefreshing()
        self.astrotalklistApiCallMethods()
    }
    func fetchDataFromStart(completion handler:@escaping (_ fetchedItems: [Int])->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
        {
            let fetchedItems = Array(0..<self.kPageLength)
            handler(fetchedItems)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    func hasLocationPermission() -> Bool {
           var hasPermission = false
           if CLLocationManager.locationServicesEnabled() {
               switch CLLocationManager.authorizationStatus() {
               case .notDetermined, .restricted, .denied:
                   hasPermission = false
               case .authorizedAlways, .authorizedWhenInUse:
                   hasPermission = true
               }
           } else {
               hasPermission = false
           }
           
           return hasPermission
       }
    func getCategoryString(data:[[String:Any]]) -> String {
        var category = ""
        for value in data {
            if let getString = value["master_category_title"] as? String {
                category = category + getString + ","
            }
        }
        return category
    }
    
    func fetchMoreData(completion handler:@escaping (_ fetchedItems: [Int])->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.items.count >= self.kMaxItemCount {
                handler([])
                return
            }
            
            let fetchedItems = Array(self.items.count..<(self.items.count + self.kPageLength))
            handler(fetchedItems)
        }
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func astrotalklistApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,
                             "app_version":MethodName.APPVERSION.rawValue,
                             "user_api_key":user_apikey,
                             "user_id":user_id,
                             "search":txt_search.text ?? "",
                             "sort_by":"Call",
                             "page":page,
                             "location":CurrentLocation] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.GETASTROLOGERS.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
//                                            if let responseObject = respose as? [String:Any] {
//                                                if let categoryObj = responseObject["data"] as? [[String:Any]] {
//                                                    if let userList = Mapper<AstroList>().mapArray(JSONObject:categoryObj){
//                                                        print(userList)
////                                                        self.notificiationDetail = userList
////                                                        if (self.notificiationDetail.count ) > 0 {
////                                                            self.tableView.backgroundView = nil
////                                                        } else {
////                                                            self.setUpNoDataBackgroundView(textMessage: "Nothing to display!")
////                                                        }
////                                                        self.tableView.reloadData()
//                                                    }
//                                                }
//                                            }
                                            
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=tempDict["data"] as! [[String:Any]]
                                            print("arrProducts is:-",arrProducts)
                                            
                                            if self.url_flag == 1
                                            {
                                                if self.pagereload == 0
                                                {
                                                    self.arrTalk.removeAll()
                                                    
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = i+1
                                                        self.index_value = i
                                                        
                                                        self.arrTalk.append(dict_Products)
                                                    }
                                                }
                                                else
                                                {
                                                    
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = self.index_value + 1
                                                        self.index_value = self.index_value + 1
                                                        
                                                        self.arrTalk.append(dict_Products)
                                                    }
                                                }
                                            }
                                            self.tbl_talklist.reloadData()
                                        } else {
                                            
                                            if self.txt_search.text != "" {
                                                self.arrTalk.removeAll()
                                                self.tbl_talklist.reloadData()
                                            }
//                                            self.arrTalk.removeAll()
//                                            self.tbl_talklist.reloadData()
                                        }
                                        
        }) { (error) in
            AutoBcmLoadingView.dismiss()
        }
        
        
        
    }
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    
    @objc func buttonRateAction(sender:UIButton) {
        if self.PerformActionIfLogin() {
            let dict_eventpoll = self.arrTalk[sender.tag]
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
            controller.modalPresentationStyle = .overCurrentContext
            controller.astroId = dict_eventpoll["astrologers_uni_id"] as? String  ?? ""
            controller.completionHandler = {
                let refreshAlert = UIAlertController(title: "AstroShubh", message: "Your Review is Added Successfully", preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                    {
                        (action: UIAlertAction!) in
                        self.dismiss(animated: true, completion: nil)
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func txt_Search(_ sender: Any)
    {
        self.astrotalklistApiCallMethods()
    }
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.arrTalk.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "TalkListCell", for: indexPath) as! TalkListCell
        
        cell_Add.view_back.layer.shadowColor = UIColor.lightGray.cgColor
        cell_Add.view_back.layer.shadowOpacity = 5.0
        cell_Add.view_back.layer.shadowRadius = 5.0
        cell_Add.view_back.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        cell_Add.view_back.layer.masksToBounds = false
        cell_Add.view_back.layer.cornerRadius = 5.0
        //cell_Add.btnCall.layer.cornerRadius = 23.0
        
        cell_Add.btnCall.tag = indexPath.row
        cell_Add.btnCall.addTarget(self, action: #selector(self.btn_calling(_:)), for: .touchUpInside)
        
        cell_Add.btnProfile.tag = indexPath.row
        cell_Add.btnProfile.addTarget(self, action: #selector(self.btn_Profile(_:)), for: .touchUpInside)
        if self.arrTalk.count == 0 {
            
        } else{
        let dict_eventpoll = self.arrTalk[indexPath.row]
        var category = ""
        if let getCategoryArray = dict_eventpoll["category_arr"] as? [[String:Any]] {
            category = self.getCategoryString(data: getCategoryArray)
        }
        let varify = dict_eventpoll["verify"] as? String ?? ""
        let name = dict_eventpoll["astrologers_name"] as? String ?? ""
        let exp = dict_eventpoll["astrologers_experience"] as? String ?? ""
        let price1 = dict_eventpoll["call_price_Inr"] as? String ?? ""
        let price2 = dict_eventpoll["call_price_dollar"] as? String ?? ""
        let title = dict_eventpoll["category_title"] as? String ?? ""
        let imagee = dict_eventpoll["astrologers_image_url"] as? String ?? ""
        let rating = dict_eventpoll["avrageRating"] as? String ?? ""
        let Rating = dict_eventpoll["rating"] as? String ?? ""
        let talkstatus = dict_eventpoll["astro_call_status"] as? String ?? ""
        let chatBusyStatus = dict_eventpoll["call_busy_status"] as? String ?? ""
        let rating1 = Double(rating)
        
        print(rating1 ?? "nil")
        
        //let avvv = name.uppercased
        cell_Add.labelLng.text =  dict_eventpoll["astrologers_language"] as? String ?? ""
        let capStr = name.capitalized
        
        // let m = name.firstCharacterUpperCase()
        
        let rating2 = Int(rating1!)
        
        print(rating2)
        cell_Add.lbl_total.text = "\(rating1 ?? 0.0) (\(Rating))"
        cell_Add.img_User.sd_setImage(with: URL(string: imagee), placeholderImage: #imageLiteral(resourceName: "userdefault"))
        cell_Add.lbl_Username.text = capStr
        cell_Add.lbl_Category.text = category
        cell_Add.lbl_exp.text =  exp + " Years"
        cell_Add.btnCall.tag = indexPath.row
        cell_Add.btnCall.addTarget(self, action: #selector(btn_calling), for: .touchUpInside)

        if talkstatus == "1"
        {
            cell_Add.btnCall.setTitle("Call",for: .normal)
            cell_Add.btnCall.backgroundColor = #colorLiteral(red: 0.06656374782, green: 0.6171005368, blue: 0.03814116493, alpha: 1)
        } else  if talkstatus == "2" {
            cell_Add.btnCall.setTitle("Busy",for: .normal)
            cell_Add.btnCall.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        } else {
            cell_Add.btnCall.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell_Add.btnCall.setTitle("Offline",for: .normal)
        }
        if dict_eventpoll["astrologers_tag"] as? String ?? "" == "" {
            cell_Add.labelForTag.text = ""
            cell_Add.imageTag.isHidden = true
        } else {
            cell_Add.labelForTag.text = dict_eventpoll["astrologers_tag"] as? String ?? ""
            cell_Add.imageTag.isHidden = false
        }
        if CurrentLocation == "India"
        {
            cell_Add.lbl_price.text = rupee + String(price1) + "/minute"
        } else {
            cell_Add.lbl_price.text = "$" + String(price2) + "/minute"
        }
        
        
        //  cell_Add.img_varify.isHidden = true
        if varify == "0"
        {
            // cell_Add.img_varify.isHidden = true
            
            cell_Add.img_varify.image = #imageLiteral(resourceName: "checked")
        }
        if varify == "1"
        {
            // cell_Add.img_varify.isHidden = false
            cell_Add.img_varify.image = #imageLiteral(resourceName: "checked")
        }
        cell_Add.ratingView.rating = rating1 ?? 0.0
        cell_Add.ratingView.editable = false
        }
        return cell_Add
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //AstrologerUniID
        
    }
    @objc func buttonShareAction(sender:UIButton) {
        let text = ""
        let shareAll = [text ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    @objc func buttonNotifyAction(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.titleLabel?.text == "Notify Me" {
        let dict_eventpoll = self.arrTalk[sender.tag]
        NotifyCallMethods(dict_eventpoll["astrologers_uni_id"] as? String ?? "")
        }
    }
    @objc func btn_calling(_ sender: UIButton)
    {
        let dict_eventpoll = self.arrTalk[sender.tag]

        if CurrentLocation == "India" {
        if walletBalanceNew <= 99 {
            CommenModel.showDefaltAlret(strMessage:"Insufficient balance", controller: self)

        } else if  walletBalanceNew <= Double(dict_eventpoll["chat_price_Inr"] as? String ?? "") ?? 0.0{
            CommenModel.showDefaltAlret(strMessage:"Insufficient balance", controller: self)

        }
        else {
        if sender.titleLabel?.text == "Call" {

        let dict_eventpoll = self.arrTalk[sender.tag]
        let chatStatus = dict_eventpoll["astro_call_status"] as? String ?? ""
        let chatBusyStatus = dict_eventpoll["call_busy_status"] as? String ?? ""
        if chatStatus == "2" {
            return
        } else {
            if chatStatus == "0" {
                return
            }
        }
        if self.PerformActionIfLogin() {
            AstrologerUniID = dict_eventpoll["astrologers_uni_id"] as? String ?? ""
            OnTabfcmUserIDD = dict_eventpoll["fcm_user_id"] as? String ?? ""
            let name = dict_eventpoll["astrologers_name"] as? String ?? ""
            if CurrentLocation == "India"
            {
                AstrologerrPrice = dict_eventpoll["chat_price_Inr"] as? String ?? ""
            }
            else
            {
                AstrologerrPrice = dict_eventpoll["chat_price_dollar"] as? String ?? ""
            }
            var callDuration = ""
            if let getPrice = Double(AstrologerrPrice) {
                callDuration = convertMaximumCallDuration(price: getPrice)
            }
            let estimateModel = EstimatePriceModel()
            estimateModel.charge = AstrologerrPrice
            estimateModel.name = name
            estimateModel.timeInHours = callDuration
            estimateModel.number = setCustomerphone
            estimateModel.balance = String(walletBalanceNew)
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "CallEstimateVC") as! CallEstimateVC
            controller.modalPresentationStyle = .overCurrentContext
            controller.estimateModel = estimateModel
            controller.completionHandler = {
                self.moveToCallVC()
            }
            self.present(controller, animated: true, completion: nil)
        } }
        }
        }else {
            if walletBalanceNew <= 1 {
                CommenModel.showDefaltAlret(strMessage:"Insufficient balance", controller: self)

            }else if  walletBalanceNew <= Double(dict_eventpoll["chat_price_dollar"] as? String ?? "") ?? 0.0{
                CommenModel.showDefaltAlret(strMessage:"Insufficient balance", controller: self)

            }
            
            else {
                if sender.titleLabel?.text == "Call" {

                let dict_eventpoll = self.arrTalk[sender.tag]
                let chatStatus = dict_eventpoll["astro_call_status"] as? String ?? ""
                let chatBusyStatus = dict_eventpoll["call_busy_status"] as? String ?? ""
                if chatStatus == "2" {
                    return
                } else {
                    if chatStatus == "0" {
                        return
                    }
                }
                if self.PerformActionIfLogin() {
                    AstrologerUniID = dict_eventpoll["astrologers_uni_id"] as? String ?? ""
                    OnTabfcmUserIDD = dict_eventpoll["fcm_user_id"] as? String ?? ""
                    let name = dict_eventpoll["astrologers_name"] as? String ?? ""
                    if CurrentLocation == "India"
                    {
                        AstrologerrPrice = dict_eventpoll["chat_price_Inr"] as? String ?? ""
                    }
                    else
                    {
                        AstrologerrPrice = dict_eventpoll["chat_price_dollar"] as? String ?? ""
                    }
                    var callDuration = ""
                    if let getPrice = Double(AstrologerrPrice) {
                        callDuration = convertMaximumCallDuration(price: getPrice)
                    }
                    let estimateModel = EstimatePriceModel()
                    estimateModel.charge = AstrologerrPrice
                    estimateModel.name = name
                    estimateModel.timeInHours = callDuration
                    estimateModel.number = setCustomerphone
                    estimateModel.balance = String(walletBalanceNew)
                    
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "CallEstimateVC") as! CallEstimateVC
                    controller.modalPresentationStyle = .overCurrentContext
                    controller.estimateModel = estimateModel
                    controller.completionHandler = {
                        self.moveToCallVC()
                    }
                    self.present(controller, animated: true, completion: nil)
                } }
                }
        }
    }
    
    func moveToCallVC() {
        let ChatForm = self.storyboard?.instantiateViewController(withIdentifier: "ChatFormVC")
        self.navigationController?.pushViewController(ChatForm!, animated: true)
    }
    
    func convertMaximumCallDuration(price:Double) -> String {
        let balance = walletBalanceNew
        if balance < 0 {
            return "00:00:00"
        } else if price == 0 {
            return "--:--:--"
        }
        let maximumTimeInMin = balance/price
        print(maximumTimeInMin)
        print(maximumTimeInMin * 60)
        let maxTimeInSec = Int(maximumTimeInMin * 60)
        return self.convertMinToHours(min: Int(maximumTimeInMin))
    }
    
    func convertMinToHours(min:Int) -> String {
        let hours = String(format: "%02d", min/60)
        let minutes = String(format: "%02d", min%60)
        return "\(hours):\(minutes):00"
    }
    
    @objc func btn_Profile(_ sender: UIButton)
    {
        let dict_eventpoll = self.arrTalk[sender.tag]
        
        chatcallingFormmm = "Calling"
        //AstrologerUniID = dict_eventpoll["astrologers_uni_id"] as! String
        //Astrologer_apikey = dict_eventpoll["astrologers_uni_id"] as! String
//        AstrologerFullData = dict_eventpoll
        let NewProfile = self.storyboard?.instantiateViewController(withIdentifier: "NewProfileVC") as? NewProfileVC
        NewProfile?.AstrologerFullData1 = dict_eventpoll

        NewProfile?.completionHandler = { text in
            self.arrTalk[sender.tag]["call_notify_status"] = text["chat_notify_status"]
            return text
            
        }
        self.navigationController?.pushViewController(NewProfile!, animated: true)
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
}

extension AstroTalkListVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if text == "", isSearchingEnable {
            self.isSearchingEnable = true
            self.astrotalklistApiCallMethods()
        }
                if text.count >= 3 {
                    self.isSearchingEnable = true
                    self.page = 0
                    self.arrTalk.removeAll()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.astrotalklistApiCallMethods()
                    }
        
                } else if text.count == 2 {
                    if isSearchingEnable {
                        self.isSearchingEnable = false
                        self.page = 0
                        self.arrTalk.removeAll()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.astrotalklistApiCallMethods()
                        }
                    }
                }
        return true
    }
}


class TalkListCell: UITableViewCell {
    @IBOutlet weak var imageTag: UIImageView!
    @IBOutlet weak var labelForTag: UILabel!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var lbl_Username: UILabel!
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var lbl_total: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lbl_exp: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var img_varify: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    
    @IBOutlet weak var labelLng: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


class EstimatePriceModel {
    var name = ""
    var charge = ""
    var balance = ""
    var number = ""
    var timeInHours = ""
}

extension AstroTalkListVC {
    func NotifyCallMethods(_ astroId:String) {
        
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,
                             "app_version":MethodName.APPVERSION.rawValue,
                             "user_api_key":user_apikey,
                             "user_id":user_id,"astrologer_id":astroId,"request_type":"call"] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("astroNotifyMe", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                        
                                        }
                                        
        }) { (error) in
            AutoBcmLoadingView.dismiss()
        }
        
        
        
    }
    
}
