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
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
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
    
    @objc func buttonRateAction(sender:UIButton) {
        if self.PerformActionIfLogin() {
            let dict_eventpoll = self.arrTalk[sender.tag]
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
            controller.modalPresentationStyle = .overCurrentContext
            controller.astroId = dict_eventpoll["astrologers_uni_id"] as? String  ?? ""
            controller.completionHandler = {
                print("hell")
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
                             "sort_by":"",
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
                                            
                                        else
                                        {
                                            
                                            
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
        cell_Add.btnRateUs.tag = indexPath.row
        cell_Add.btnRateUs.addTarget(self, action: #selector(buttonRateAction), for: .touchUpInside)
        
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
        let chatBusyStatus = dict_eventpoll["chat_busy_status"] as? String ?? ""
        cell_Add.img_User.sd_setImage(with: URL(string: imagee), placeholderImage: UIImage(named: "astrochat"))
        let rating = dict_eventpoll["avrageRating"] as? String ?? ""
        let Rating = dict_eventpoll["rating"] as? String ?? ""
        
        let rating1 = Float(rating)
        
        print(rating1 ?? "nil")
        
        let rating2 = Int(rating1!)
        
        print(rating2)
        
        let capStr = name.capitalized
        cell_Add.lbl_total.text = Rating + " Total"
        
        cell_Add.lbl_Username.text = capStr
        cell_Add.lbl_Category.text = category
        cell_Add.lbl_exp.text = "Exp: " + exp + " Years"
        cell_Add.btnChat.clipsToBounds = true
        cell_Add.btnChat.layer.borderWidth = 2
        cell_Add.btnRateUs.clipsToBounds = true
        cell_Add.btnRateUs.layer.borderWidth = 2
        cell_Add.btnRateUs.setTitleColor(.green, for: .normal)
        cell_Add.btnRateUs.layer.borderColor = UIColor.green.cgColor
        if chatBusyStatus == "1" {
            cell_Add.btnChat.setTitleColor(.red, for: .normal)
            cell_Add.btnChat.layer.borderColor = UIColor.red.cgColor
            cell_Add.btnChat.setTitle("Busy",for: .normal)
        } else {
            if chatStatus == "1"
            {
                cell_Add.btnChat.setTitleColor(.green, for: .normal)
                cell_Add.btnChat.layer.borderColor = UIColor.green.cgColor
                cell_Add.btnChat.setTitle("Chat",for: .normal)
            }
            else
            {
                cell_Add.btnChat.setTitleColor(.darkGray, for: .normal)
                cell_Add.btnChat.layer.borderColor = UIColor.darkGray.cgColor
                cell_Add.btnChat.setTitle("Offline",for: .normal)
            }
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
            //cell_Add.img_varify.isHidden = true
            cell_Add.img_varify.image = UIImage(named: "non-certificate")
        }
        if varify == "1"
        {
            // cell_Add.img_varify.isHidden = false
            cell_Add.img_varify.image = UIImage(named: "certificate")
        }
        if rating2 == 0
        {
            cell_Add.img_1.image = UIImage(named: "stargray")
            cell_Add.img_2.image = UIImage(named: "stargray")
            cell_Add.img_3.image = UIImage(named: "stargray")
            cell_Add.img_4.image = UIImage(named: "stargray")
            cell_Add.img_5.image = UIImage(named: "stargray")
        }
        if rating2 == 1
        {
            cell_Add.img_1.image = UIImage(named: "star")
            cell_Add.img_2.image = UIImage(named: "stargray")
            cell_Add.img_3.image = UIImage(named: "stargray")
            cell_Add.img_4.image = UIImage(named: "stargray")
            cell_Add.img_5.image = UIImage(named: "stargray")
        }
        if rating2 == 2
        {
            cell_Add.img_1.image = UIImage(named: "star")
            cell_Add.img_2.image = UIImage(named: "star")
            cell_Add.img_3.image = UIImage(named: "stargray")
            cell_Add.img_4.image = UIImage(named: "stargray")
            cell_Add.img_5.image = UIImage(named: "stargray")
        }
        if rating2 == 3
        {
            cell_Add.img_1.image = UIImage(named: "star")
            cell_Add.img_2.image = UIImage(named: "star")
            cell_Add.img_3.image = UIImage(named: "star")
            cell_Add.img_4.image = UIImage(named: "stargray")
            cell_Add.img_5.image = UIImage(named: "stargray")
        }
        if rating2 == 4
        {
            cell_Add.img_1.image = UIImage(named: "star")
            cell_Add.img_2.image = UIImage(named: "star")
            cell_Add.img_3.image = UIImage(named: "star")
            cell_Add.img_4.image = UIImage(named: "star")
            cell_Add.img_5.image = UIImage(named: "stargray")
        }
        if rating2 == 5
        {
            cell_Add.img_1.image = UIImage(named: "star")
            cell_Add.img_2.image = UIImage(named: "star")
            cell_Add.img_3.image = UIImage(named: "star")
            cell_Add.img_4.image = UIImage(named: "star")
            cell_Add.img_5.image = UIImage(named: "star")
        }
        
        
        return cell_Add
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    @objc func btn_chat(_ sender: UIButton)
    {
        let dict_eventpoll = self.arrTalk[sender.tag]
        let chatStatus = dict_eventpoll["astro_chat_status"] as? String ?? ""
        let chatBusyStatus = dict_eventpoll["chat_busy_status"] as? String ?? ""
        if chatBusyStatus == "1" {
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
            controller.estimateModel = estimateModel
            controller.completionHandler = {
                self.moveToNextScreen(userObj:self.user)
            }
            self.present(controller, animated: true, completion: nil)
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
    
    func moveToNextScreen(userObj:User) {
        
        let chatForm = self.storyboard?.instantiateViewController(withIdentifier: "ChatFormVC") as! ChatFormVC
        chatForm.user = userObj
        self.navigationController?.pushViewController(chatForm, animated: true)
    }
    
    func createChannel() {
        let ChannelObj = Channel(chatId: "\(user_id)+\(AstrologerUniID)", astroName: "\(AstrologerNameee)", userName: "\(setCustomername)")
        channelReference.addDocument(data: ChannelObj.representation) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
            self.db.collection("\(user_id)").getDocuments { (snapshot, error) in
                if let getDocumentChanges = snapshot?.documentChanges {
                    print(getDocumentChanges.count)
                    for values in getDocumentChanges {
                        guard let channelNew = Channel(document: values.document) else {
                            return
                        }
                        if ChannelObj.Chat_id == channelNew.Chat_id {
                            if let getCurrentUser = Auth.auth().currentUser {
                                self.navigationController?.isNavigationBarHidden = false
                                //                                let vc = ChatVC(user: getCurrentUser, channel: channelNew)
                                //                                self.navigationController?.pushViewController(vc, animated: true)
                                return
                            }
                            
                        }
                    }
                }
                
            }
            
            
        }
    }
    
    func observeMessage() {
        guard let uid = Auth.auth().currentUser?.uid ,let toIdd = OnTabfcmUserIDD  else {
            return
        }
        let userMessageRef = Database.database().reference().child("messages").child(uid).child(toIdd)
        let userMessageRef1 = Database.database().reference().child("messages").child(toIdd).child(uid)
        userMessageRef.observe(.childAdded, with: { (snapshot) in
            let UserId = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(uid).child(toIdd).child(UserId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dict = snapshot.value as? [String: AnyObject] else {
                    return
                }
                let message = Message(fromDictionary: dict)
                //let Mess = dict["message"] as! String
                //message.setValuesForKeys(dict)
                // arrchatList.append(dict)
                self.messages.append(message)
                Finalmessages.append(message)
                // self.messages.sort { (Double($0.timestamp!)) < (Double($1.timestamp!)) }
            }, withCancel: nil)
        }, withCancel: nil)
        userMessageRef1.observe(.childAdded, with: { (snapshot) in
            let UserId = snapshot.key
            let messagesRef = Database.database().reference().child("messages").child(toIdd).child(uid).child(UserId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dict = snapshot.value as? [String: AnyObject] else {
                    return
                }
                let message = Message(fromDictionary: dict)
                //let Mess = dict["message"] as! String
                //message.setValuesForKeys(dict)
                // arrchatList.append(dict)
                self.messages.append(message)
                Finalmessages.append(message)
                // self.messages.sort { (Double($0.timestamp!)) < (Double($1.timestamp!)) }
                
                DispatchQueue.main.async {
                    
                    
                    
                    
                    
                }
            }, withCancel: nil)
        }, withCancel: nil)
        
        
        
        
        // self.sortedobserveUserMessages()
    }
    
    @IBAction func actionSearchAstro(_ sender: UIButton) {
        self.astrotalklistApiCallMethods()
    }
    
    @objc func btn_Profile(_ sender: UIButton)
    {
        chatcallingFormmm = "Chat"
        let dict_eventpoll = self.arrTalk[sender.tag]
        AstrologerFullData = dict_eventpoll
        let NewProfile = self.storyboard?.instantiateViewController(withIdentifier: "NewProfileVC")
        self.navigationController?.pushViewController(NewProfile!, animated: true)
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
}

extension AstroChatListVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        print(text)
        if isSearchingEnable, text == "" {
            self.isSearchingEnable = false
            self.astrotalklistApiCallMethods()
        }
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
        return true
    }
}

class ChatListCell: UITableViewCell {
    
    @IBOutlet weak var btnRateUs: UIButton!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var lbl_Username: UILabel!
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var lbl_total: UILabel!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var lbl_exp: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var img_varify: UIImageView!
    @IBOutlet weak var img_1: UIImageView!
    @IBOutlet weak var img_2: UIImageView!
    @IBOutlet weak var img_3: UIImageView!
    @IBOutlet weak var img_4: UIImageView!
    @IBOutlet weak var img_5: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
}
