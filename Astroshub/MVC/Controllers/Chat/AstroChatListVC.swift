//
//  AstroChatListVC.swift
//  Astroshub
//
//  Created by Kriscent on 21/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

var astroImageUrlGlobal = ""

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import CoreLocation
import MapKit
import ObjectMapper
class AstroChatListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MKMapViewDelegate{
    
    @IBOutlet var txt_search: UITextField!
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_chatlist: UITableView!
    var arrTalk = [[String:Any]]()
    var ref:DatabaseReference?
    let kMaxItemCount = 1000
    let kPageLength   = 10
    var items: [Int] = []
    var isSearchingEnable = false
    
    var page = 0
    var pagereload = 0
    var url_flag = 1
    var index_value = 0
    var refreshController = UIRefreshControl()
    var messages = [Message]()
    let user = User([:])
    var searchText = ""
    //Firebase chat variables
    private let db = Firestore.firestore()
    private var channelReference: CollectionReference {
        return db.collection("\(user_id)")
    }
    
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
        }else {
        self.astrotalklistApiCallMethods()
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action:#selector(handleRefresh(_:)), for: .valueChanged)
        tbl_chatlist.addSubview(refreshController)
        self.tbl_chatlist.am.addInfiniteScrolling { [unowned self] in
            self.fetchMoreData(completion: { (fetchedItems) in
                self.items.append(contentsOf: fetchedItems)
                if self.arrTalk.count >= 10
                {
                    self.pagereload = 1
                    self.page = self.page + 1
                    self.url_flag = 1
                    
                    self.astrotalklistApiCallMethods()
                }
                self.tbl_chatlist.reloadData()
                self.tbl_chatlist.am.infiniteScrollingView?.stopRefreshing()
                if fetchedItems.count == 0 {
                    //No more data is available
                    self.tbl_chatlist.am.infiniteScrollingView?.hideInfiniteScrollingView()
                }
            })
        }
        self.tbl_chatlist.am.pullToRefreshView?.trigger()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
       
       
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
                             "search":self.txt_search.text ?? "",
                             "sort_by":"Chat",
                             "page":page,
                             "location":CurrentLocation] as [String : Any]
        print(setparameters)
//        AutoBcmLoadingView.show("Loading......")
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
//
//                                                    }
//                                                }
//                                            }
                                            
                                            // let dict_Data = tempDict["data"] as! [String:Any]
                                            //  print("dict_Data is:- ",dict_Data)
                                            //                                            if let arrblog = tempDict["data"] as? [[String:Any]]
                                            //                                            {
                                            //                                                self.arrTalk = arrblog
                                            //                                            }
                                            //                                            print("arrBlogs is:- ",self.arrTalk)
                                            
                                            
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=tempDict["data"] as! [[String:Any]]
                                            print("arrProducts is:-",arrProducts)
                                            if arrProducts.count == 0 {
                                                self.arrTalk.removeAll()
                                                self.tbl_chatlist.reloadData()
                                            } else{
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
                                            
                                            
                                            
                                            
                                            self.tbl_chatlist.reloadData()
                                            }
                                            
                                        }
                                            
                                        else
                                        {
                                            if self.txt_search.text != "" {
                                                self.arrTalk.removeAll()
                                                self.tbl_chatlist.reloadData()
                                            }
                                           
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                        }
                                        
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
        
        
        
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
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func txt_Search(_ sender: Any) {
        self.isSearchingEnable = true
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
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListCell
        
        cell_Add.view_back.layer.shadowColor = UIColor.lightGray.cgColor
        cell_Add.view_back.layer.shadowOpacity = 5.0
        cell_Add.view_back.layer.shadowRadius = 5.0
        cell_Add.view_back.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        cell_Add.view_back.layer.masksToBounds = false
        cell_Add.view_back.layer.cornerRadius = 5.0
        
        cell_Add.img_User.layer.cornerRadius = cell_Add.img_User.frame.size.height/2
        cell_Add.img_User.clipsToBounds = true
        
        //cell_Add.btnChat.layer.cornerRadius = 26
        
        cell_Add.btnChat.tag = indexPath.row
        cell_Add.btnChat.addTarget(self, action: #selector(self.btn_chat(_:)), for: .touchUpInside)
        
        cell_Add.btnProfile.tag = indexPath.row
        cell_Add.btnProfile.addTarget(self, action: #selector(self.btn_Profile(_:)), for: .touchUpInside)
//        cell_Add.btnRateUs.tag = indexPath.row
//        cell_Add.btnRateUs.addTarget(self, action: #selector(buttonRateAction), for: .touchUpInside)
//
        if self.arrTalk.count == 0 {
            
        } else {
        let dict_eventpoll = self.arrTalk[indexPath.row]
        var category = ""
        let name = dict_eventpoll["astrologers_name"] as? String ?? ""
        let varify = dict_eventpoll["verify"] as? String ?? ""
        let exp = dict_eventpoll["astrologers_experience"] as? String ?? ""
        let price1 = dict_eventpoll["chat_price_Inr"] as? String ?? ""
        let price2 = dict_eventpoll["chat_price_dollar"] as? String ?? ""
        if let getCategoryArray = dict_eventpoll["category_arr"] as? [[String:Any]] {
            category = self.getCategoryString(data: getCategoryArray)
        }
        //        let title = dict_eventpoll["category_title"] as? String ?? ""
        let imagee = dict_eventpoll["astrologers_image_url"] as? String ?? ""
        astroImageUrlGlobal = dict_eventpoll["astrologers_image_url"] as? String ?? ""
        let chatStatus = dict_eventpoll["astro_chat_status"] as? String ?? ""
        cell_Add.img_User.sd_setImage(with: URL(string: imagee), placeholderImage:#imageLiteral(resourceName: "userdefault"))
        let rating = dict_eventpoll["avrageRating"] as? String ?? ""
        let Rating = dict_eventpoll["rating"] as? String ?? ""
        
        let rating1 = Double(rating)
        let capStr = name.capitalized
        cell_Add.lbl_total.text = "\(rating)  (\(Rating))"

        cell_Add.labelForLang.text = dict_eventpoll["astrologers_language"] as? String ?? ""
        cell_Add.lbl_Username.text = capStr
        cell_Add.lbl_Category.text = category
        cell_Add.lbl_exp.text =  exp + " Years"
        cell_Add.btnChat.tag = indexPath.row
        cell_Add.btnChat.addTarget(self, action: #selector(self.btn_chat(_:)), for: .touchUpInside)
            if chatStatus == "1"
            {
                cell_Add.btnChat.setTitle("Chat",for: .normal)
                cell_Add.btnChat.backgroundColor = #colorLiteral(red: 0.06656374782, green: 0.6171005368, blue: 0.03814116493, alpha: 1)
            } else  if chatStatus == "2"
            {
                cell_Add.btnChat.setTitle("Busy",for: .normal)
                cell_Add.btnChat.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            }
            else
            {
                cell_Add.btnChat.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                cell_Add.btnChat.setTitle("Offline",for: .normal)
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
        }
        else
        {
            cell_Add.lbl_price.text = "$" + String(price2) + "/minute"
        }
        
        //cell_Add.lbl_price.text = rupee + String(price1) + "/minute"
        //cell_Add.img_varify.isHidden = true
        if varify == "0"
        {
            cell_Add.img_varify.image = #imageLiteral(resourceName: "checked")
        }
        if varify == "1"
        {
            cell_Add.img_varify.image = #imageLiteral(resourceName: "checked")
        }
        cell_Add.ratingView.editable = false

        cell_Add.ratingView.rating = rating1 ?? 0.0
        }
        return cell_Add
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    @objc func buttonShareAction(sender:UIButton) {
        let text = ""
        let shareAll = [text ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    @objc func btn_chat(_ sender: UIButton)
    {
        chatStartorEnd = ""

        if CurrentLocation == "India" {
            if walletBalanceNew <= 99 {
            } else {
            if sender.titleLabel?.text == "Chat" {
            let dict_eventpoll = self.arrTalk[sender.tag]
            let chatStatus = dict_eventpoll["astro_chat_status"] as? String ?? ""
            if chatStatus == "2" {
                return
            } else {
                if chatStatus == "0" {
                    return
                }
            }
            if self.PerformActionIfLogin() {
                AstrologerUniID = dict_eventpoll["astrologers_uni_id"] as? String ?? ""
                AstrologerEmailId = dict_eventpoll["email"] as? String ?? ""
                OnTabfcmUserID = dict_eventpoll["fcm_user_id"] as? String ?? ""
                AstrologerNameee = dict_eventpoll["astrologers_name"] as? String ?? ""
                OnTabfcmUserIDD = dict_eventpoll["fcm_user_id"] as? String ?? ""
                OnTabfcmUserTOKEN = dict_eventpoll["user_fcm_token"] as? String ?? ""
                OnTabfcmUserTOKEN = dict_eventpoll["user_ios_token"] as? String ?? ""
                if CurrentLocation == "India" {
                    AstrologerrPrice = dict_eventpoll["chat_price_Inr"] as? String ?? ""
                } else {
                    AstrologerrPrice = dict_eventpoll["chat_price_dollar"] as! String
                }
                if OnTabfcmUserIDD == "" {
                    return
                }
                user.name = AstrologerNameee
                user.userId = dict_eventpoll["astrologers_uni_id"] as? String ?? ""
                user.firebaseToken = dict_eventpoll["user_fcm_token"] as? String ?? ""
                user.phone = dict_eventpoll["phone_number"] as? String ?? ""
                var callDuration = ""
                if let getPrice = Double(AstrologerrPrice) {
                    let value = convertMaximumCallDuration(price: getPrice)
                    callDuration = value.0
                    user.totalSecondsForCall = value.1
                }
                let estimateModel = EstimatePriceModel()
                estimateModel.charge = AstrologerrPrice
                estimateModel.name = AstrologerNameee
                estimateModel.timeInHours = callDuration
                estimateModel.number = setCustomerphone
                estimateModel.balance = String(walletBalanceNew)
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "CallEstimateVC") as! CallEstimateVC
                controller.modalPresentationStyle = .overCurrentContext
                controller.screenCome = "chat"
                controller.estimateModel = estimateModel
                controller.completionHandler = {
                    self.moveToNextScreen(userObj:self.user, duration: "\(self.user.totalSecondsForCall)")
                }
                self.present(controller, animated: true, completion: nil)
            }
            }
            }
        } else {
            if walletBalanceNew <= 1 {
            } else {
            if sender.titleLabel?.text == "Chat" {
            let dict_eventpoll = self.arrTalk[sender.tag]
            let chatStatus = dict_eventpoll["astro_chat_status"] as? String ?? ""
            let chatBusyStatus = dict_eventpoll["chat_busy_status"] as? String ?? ""
            if chatStatus == "2" {
                return
            } else {
                if chatStatus == "0" {
                    return
                }
            }
            if self.PerformActionIfLogin() {
                AstrologerUniID = dict_eventpoll["astrologers_uni_id"] as? String ?? ""
                AstrologerEmailId = dict_eventpoll["email"] as? String ?? ""
                OnTabfcmUserID = dict_eventpoll["fcm_user_id"] as? String ?? ""
                AstrologerNameee = dict_eventpoll["astrologers_name"] as? String ?? ""
                OnTabfcmUserIDD = dict_eventpoll["fcm_user_id"] as? String ?? ""
                OnTabfcmUserTOKEN = dict_eventpoll["user_fcm_token"] as? String ?? ""
                OnTabfcmUserTOKEN = dict_eventpoll["user_ios_token"] as? String ?? ""
                if CurrentLocation == "India" {
                    AstrologerrPrice = dict_eventpoll["chat_price_Inr"] as? String ?? ""
                } else {
                    AstrologerrPrice = dict_eventpoll["chat_price_dollar"] as! String
                }
                if OnTabfcmUserIDD == "" {
                    return
                }
                user.name = AstrologerNameee
                user.userId = dict_eventpoll["astrologers_uni_id"] as? String ?? ""
                user.firebaseToken = dict_eventpoll["user_fcm_token"] as? String ?? ""
                user.phone = dict_eventpoll["phone_number"] as? String ?? ""
                var callDuration = ""
                if let getPrice = Double(AstrologerrPrice) {
                    let value = convertMaximumCallDuration(price: getPrice)
                    callDuration = value.0
                    user.totalSecondsForCall = value.1
                }
                let estimateModel = EstimatePriceModel()
                estimateModel.charge = AstrologerrPrice
                estimateModel.name = AstrologerNameee
                estimateModel.timeInHours = callDuration
                estimateModel.number = setCustomerphone
                estimateModel.balance = String(walletBalanceNew)
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "CallEstimateVC") as! CallEstimateVC
                controller.modalPresentationStyle = .overCurrentContext
                controller.screenCome = "chat"
                controller.estimateModel = estimateModel
                controller.completionHandler = {
                    self.moveToNextScreen(userObj:self.user, duration: callDuration)
                }
                self.present(controller, animated: true, completion: nil)
            }
            }
            }
            
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
    
    func moveToNextScreen(userObj:User,duration:String) {
        
        let chatForm = self.storyboard?.instantiateViewController(withIdentifier: "ChatFormVC") as! ChatFormVC
        chatForm.user = userObj
        chatForm.duration = duration
        self.navigationController?.pushViewController(chatForm, animated: true)
    }
    
  
    @IBAction func actionSearchAstro(_ sender: UIButton) {
        self.astrotalklistApiCallMethods()
    }
    
    @objc func btn_Profile(_ sender: UIButton)
    {
        chatcallingFormmm = "Chat"
        let dict_eventpoll = self.arrTalk[sender.tag]
        let NewProfile = self.storyboard?.instantiateViewController(withIdentifier: "NewProfileVC") as?  NewProfileVC
        NewProfile?.AstrologerFullData1 = dict_eventpoll
        NewProfile?.completionHandler = { text in
            self.arrTalk[sender.tag]["chat_notify_status"] = text["chat_notify_status"]
            return text
            
        }
        self.navigationController?.pushViewController(NewProfile!, animated: true)
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
}

extension AstroChatListVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
//        print(text)
//        if isSearchingEnable, text == "" {
//            self.isSearchingEnable = false
//            self.astrotalklistApiCallMethods()
//        }
//        if text.count >= 3 {
//            self.searchText = text
//            self.isSearchingEnable = true
//            self.page = 0
//            self.arrTalk.removeAll()
//            self.astrotalklistApiCallMethods()
//        } else if text.count == 2 {
//            if isSearchingEnable {
//                self.searchText = ""
//                self.isSearchingEnable = false
//                self.page = 0
//                self.arrTalk.removeAll()
//                self.astrotalklistApiCallMethods()
//            }
//        }
//
        
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
                else {
                    self.isSearchingEnable = false
                    self.page = 0
                    self.arrTalk.removeAll()
                    self.astrotalklistApiCallMethods()
                }
        return true

        return true
    }
}

class ChatListCell: UITableViewCell {
    
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var labelForLang: UILabel!
    @IBOutlet weak var imageTag: UIImageView!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var lbl_Username: UILabel!
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var lbl_total: UILabel!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var lbl_exp: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var img_varify: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var labelForTag: UILabel!
}

