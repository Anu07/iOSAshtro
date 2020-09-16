//
//  DashboardVC.swift
//  Astroshub
//
//  Created by Kriscent on 07/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.

var walletBalanceNew = 0.0

import UIKit
import CoreLocation
import MapKit
import SJSwiftSideMenuController
import Firebase
import FirebaseInstanceID
import FirebaseAuth
import FirebaseMessaging
import FirebaseCore
import Fabric
import Crashlytics
import FirebaseDatabase
import MessageUI

class DashboardVC: UIViewController , UITextFieldDelegate , MKMapViewDelegate , CLLocationManagerDelegate,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MFMailComposeViewControllerDelegate {
    
    var users = [Userrrr]().self
    var return_Response = [[String:Any]]()
    var index_value = 0
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl_walletamount: UILabel!
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_dashboard: UITableView!
    @IBOutlet weak var constraintsBottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var btnCalls: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lbl_typecall: UILabel!
    @IBOutlet weak var lbl_typechat: UILabel!
    @IBOutlet weak var lbl_nextonline: UILabel!
    @IBOutlet weak var lbl_nextonline1: UILabel!
    @IBOutlet weak var collectionView_Category: UICollectionView!
    @IBOutlet weak var switch_ONOFF: UISwitch!
    @IBOutlet weak var switch_ONOFF1: UISwitch!
    let manager = CLLocationManager()
    
    let propertyArray1 = [
        "Chat with Astrologer",
        "Talk to Astrologer",
        "Ask Query/Report",
        "Astro Shubh Shop"
        
    ]
    
    let propertyArrayImages1 = [
        "astrochat",
        "astrotalk",
        "astroquery",
        "astroshop"
    ]
    var arrastroprice = [[String:Any]]()
    var astro_price_dollarcall = ""
    var astro_price_inrcall = ""
    var astro_price_dollarchat = ""
    var astro_price_inrchat = ""
    var arrbannerImages = [[String:Any]]()
    var arrhoroscope = [[String:Any]]()
    var pageControl: UIPageControl!
    var counter = 0
    var timer = Timer()
    var offSet: CGFloat = 0
    var urlstring = ""
    let arrUserList = NSMutableArray()
    let arr = NSMutableArray()
    var dashboard : DashboardTitles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDashboardAPI()
        view1.layer.borderWidth = 1
        view1.layer.borderColor = UIColor.white.cgColor
        view1.layer.cornerRadius = 6
        print(Supportmobile)
        tbl_dashboard.register(UINib(nibName: "DashBoardHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DashBoardHeaderTableViewCell")
        
        let timestamp = NSDate().timeIntervalSince1970
        let timeStamp = Int(1000 * Date().timeIntervalSince1970)
        let myTimeInterval = TimeInterval(timeStamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        print(time)
        
        self.navigationController?.isNavigationBarHidden = true
        SJSwiftSideMenuController.enableDimbackground = true
        let data_IsLogin = UserDefaults.standard.value(forKey: "isUserData") as? Data
        if let getData = data_IsLogin {
            let dict_IsLogin = NSKeyedUnarchiver.unarchiveObject(with:getData) as? [String:Any]
            
            print("dict_IsLogin is:-",dict_IsLogin)
            if let getDataLogin = dict_IsLogin {
                User.currentProfile(from: getDataLogin)
            }
            setCustomername = dict_IsLogin?["customer_name"] as? String ?? ""
            setCustomeremail = dict_IsLogin?["email"] as? String ?? ""
            setCustomerphone = dict_IsLogin?["phone_number"] as? String ?? ""
            setCustomerphoneCode = dict_IsLogin?["phone_code"] as? String ?? ""
            setCustomerdob = dict_IsLogin?["customer_dob"] as? String ?? ""
            setCustomertime = dict_IsLogin?["customer_time_birth"] as? String ?? ""
            setCustomerCountryId  = dict_IsLogin?["customer_country_id"] as? String ?? "91"
            ReferellCode = dict_IsLogin?["referral_code"] as? String ?? ""
            UserImageurl = dict_IsLogin?["customer_image_url"] as? String ?? ""
            
            
            
            print(self.view.frame.height)
            
            user_apikey = UserDefaults.standard.value(forKey: "userKey") as? String ?? ""
            
            
            user_id = dict_IsLogin?["user_uni_id"] as? String ?? ""
            //user_apikey = dict_IsLogin["user_api_key"] as! String
            user_Email = dict_IsLogin?["email"] as? String ?? ""
        }
        
        // view_top.layer.cornerRadius = 5.0
        self.navigationController?.isNavigationBarHidden = true
        
        self.tbl_dashboard.isHidden = true
        self.bannerApiCallMethods()
        
        
        self.tbl_dashboard.delegate = self
        self.tbl_dashboard.dataSource = self
        
        
        if let getCurrentUser = Auth.auth().currentUser {
            fcmUserID = getCurrentUser.uid
        }
        self.tbl_dashboard.register(UINib(nibName: "DashBoardMainTVC", bundle: nil), forCellReuseIdentifier: "DashBoardMainTVC")
        self.tbl_dashboard.register(UINib(nibName: "DashBoardSecCell", bundle: nil), forCellReuseIdentifier: "DashBoardSecCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager.delegate = self
        manager.requestLocation()
        manager.requestAlwaysAuthorization()
        if CurrentLocation.count != 0 {
            self.func_CallWelcomeAPI()
            if let _ = UserDefaults.standard.value(forKey: "isUserData") as? Data {
                self.walletApiCallMethods()
            }
        }
    }
    
    func checkIfUserisLoggedIN(){
        if Auth.auth().currentUser?.uid == nil{
            
        }else{
            let uid = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { snapshot in
                
                if !snapshot.exists() { return }
                
                print(snapshot) // Its print all values including Snap (User)
                print(snapshot.value!)
                let username = snapshot.childSnapshot(forPath: "name").value
                print(username!)
                
                // self.fetchUser()
                
            })
        }
    }
    
    func fetchUser(){
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = Userrrr()
                user.ID = snapshot.key
                print(user.ID ?? "nil")
                //  user.setValuesForKeys(dictionary)
                self.users.append(user)
                print(self.users)
            }
        }, withCancel: nil)
        
    }
    
    //MARK:- Custom Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if (error != nil){
                    print("error in reverseGeocode")
                }
                if let placemark = placemarks, placemark.count > 0 {
                    let placemarkObj = placemark[0]
                    print(placemarkObj.country!)
                    if let getCountry = placemarkObj.country {
                        CurrentLocation = getCountry
                        print("coutry name is: \(getCountry)")
                        UserDefaults.standard.set(getCountry, forKey: "country")
                        self.func_CallWelcomeAPI()
                        if let _ = UserDefaults.standard.value(forKey: "isUserData") as? Data {
                            self.walletApiCallMethods()
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    //https://www.astroshubh.in/api/appManagement
    func getDashboardAPI(){
        
       // AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestGETURL("appManagement",
                                     success: { (respose) in
                                               //AutoBcmLoadingView.dismiss()
                                               let tempDict = respose as! NSDictionary
                                               print(tempDict)
                                               let success=tempDict["response"] as!   Bool
                                               if success == true{
                                                   let dict_Data = tempDict["data"] as! [String:Any]
                                                   let dashboardData = DashboardTitles.init(dict: dict_Data)
                                                self.dashboard = dashboardData
                                                let isBottomEnable = self.dashboard?.bottomOptions?.first?.isEnable == "1"
                                                self.viewBottom?.isHidden = !isBottomEnable
                                                self.btnCalls?.isHidden = !isBottomEnable
                                                self.constraintsBottomViewHeight.constant = isBottomEnable ? 100.0 : 0.0
                                                self.tbl_dashboard.reloadData()
                                               }
               }) { (error) in
                   print(error)
                  // AutoBcmLoadingView.dismiss()
               }
    }
    
    func func_CallWelcomeAPI(){
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":kIOS ,"app_version":kAppVersion,"location":CurrentLocation]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("welcome", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            Supportmobile = dict_Data["mobile_number"] as! String
                                            whatsappmobile = dict_Data["whatsapp_number"] as! String
                                            FormQueryPrice = dict_Data["query_price"] as! Int
                                            FormReportPrice = dict_Data["report_price"] as! Int
                                        }
                                        
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    func bannerApiCallMethods() {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id]
        print(setparameters)
        //ActivityIndicator.shared.startLoading()
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.BANNER.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            if let arrSliderImages = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrbannerImages = arrSliderImages
                                            }
                                            print("arrImages is:- ",self.arrbannerImages)
                                            
                                            self.pageControl.numberOfPages = self.arrbannerImages.count
                                            
                                            print(self.pageControl.numberOfPages)
                                            if self.arrbannerImages.count > 1 {
                                                Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.moveToNextPage), userInfo: nil, repeats: true)
                                            }
                                            self.tbl_dashboard.reloadData()
                                            self.tbl_dashboard.isHidden = false
                                        } else {
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    @objc func horoscopeApiCallMethods() {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey.count > 0 ? user_apikey : "7bd679c21b8edcc185d1b6859c2e56ad" ,"user_id":user_id,"zodic_id":""]
        print(setparameters)
        ActivityIndicator.shared.startLoading()
        //AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.HOROSCOPE.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        ActivityIndicator.shared.stopLoader()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            self.arrhoroscope = [[String:Any]]()
                                            self.return_Response = [[String:Any]]()
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=tempDict["data"] as! [[String:Any]]
                                            for i in 0..<arrProducts.count
                                            {
                                                var dict_Products = arrProducts[i]
                                                dict_Products["isSelectedDeselected"] = "0"
                                                dict_Products["id"] = i+1
                                                self.index_value = i
                                                self.arrhoroscope.append(dict_Products)
                                            }
                                            self.return_Response = self.arrhoroscope
                                            let horoscopevC = self.storyboard?.instantiateViewController(withIdentifier: "HoroScopeVC") as! HoroScopeVC
                                            horoscopevC.horoscopeRes = self.return_Response
                                            self.navigationController?.pushViewController(horoscopevC, animated: true)
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
    
    func walletApiCallMethods() {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id,"location":CurrentLocation]
        print(setparameters)
        AppHelperModel.requestPOSTURL(MethodName.RECHARGE.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: {
                                        (respose) in
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success = tempDict["response"] as!   Bool
                                        let message = tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            let amount = dict_Data["wallet"] as! String
                                            
                                            let amount1 = String(amount)
                                            var splitString = amount1.split(separator: " ")
                                            if splitString.count == 2 {
                                                if let getBalance = Double(splitString[1]) {
                                                    walletBalanceNew = getBalance
                                                }
                                            }
                                            
                                            if CurrentLocation == "India"
                                            {
                                                self.lbl_walletamount.text = amount1
                                            }
                                            else
                                            {
                                                self.lbl_walletamount.text = amount1
                                            }
                                        }
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    @objc func moveToNextPage ()
    {
        
        // tbl_dashboard.reloadData()
        let indexPath = IndexPath(item: 0, section: 0)
        tbl_dashboard.reloadRows(at: [indexPath], with: .automatic)
        
    }
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func menu_Action(_ sender: Any)
    {
        SJSwiftSideMenuController.toggleLeftSideMenu()
    }
    @IBAction func wallet_Action(_ sender: Any)
    {
        if self.PerformActionIfLogin()  {
            let WalletNew = self.storyboard?.instantiateViewController(withIdentifier: "WalletNewVC")
            self.navigationController?.pushViewController(WalletNew!, animated: true)
        }
    }
    
    @IBAction func actionChatWith(_ sender: UIButton) {
        //let string1 = whatsappmobile
        let string1 = "+919999122091"
        let url = string1
        
        //let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(url)&text=Invitation")
        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(url)")
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func support_Action(_ sender: Any) {
        // self.openWhatsapp()
        dialNumber(number: "+919999122091")
        //dialNumber(number: Supportmobile)
    }
    @IBAction func notification_Action(_ sender: Any) {
        // NotificationListVC
        if self.PerformActionIfLogin() {
            let NotificationList = self.storyboard?.instantiateViewController(withIdentifier: "NotificationListVC")
            self.navigationController?.pushViewController(NotificationList!, animated: true)
        }
    }
    
    @IBAction func btn_ProfileAction(_ sender: Any)
    {
        let Profile = self.storyboard?.instantiateViewController(withIdentifier: "NewProfileVC")
        self.navigationController?.pushViewController(Profile!, animated: true)
    }
    
    @IBAction func btn_LogoutAction(_ sender: Any)
    {
        let refreshAlert = UIAlertController(title: "Log Out", message: "Are You Sure to Log Out ? ", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler:
            {
                (action: UIAlertAction!) in
                //            self.navigationController?.popToRootViewController(animated: true)
                
                self.logoutFun()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:
            {
                (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    func logoutFun()
    {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        UserDefaults.standard.removeObject(forKey: "isSignup")
        UserDefaults.standard.removeObject(forKey: "isUserData")
        
        let LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.navigationController?.pushViewController(LoginVC!, animated: false)
        
    }
    func openWhatsapp(){
        
        let string1 = Supportmobile
        let url = string1
        
        //let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(url)&text=Invitation")
        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(url)")
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
        }
    }
    
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 0
        } else if indexPath.row >= 1 && indexPath.row <= 4 {
            return 80
        } else if indexPath.row == 5 {
            return 200
        }
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.row == 0
        {
            let sliderImageCell = tableView.dequeueReusableCell(withIdentifier: "SliderImageCell", for: indexPath) as! SliderImageCell
            self.pageControl=sliderImageCell.viewWithTag(3) as? UIPageControl
            let scrollviewcount = CGFloat(arrbannerImages.count)
            sliderImageCell.pageControl.numberOfPages =  arrbannerImages.count
            sliderImageCell.scrollView.contentSize = CGSize(width: sliderImageCell.scrollView.frame.size.width * scrollviewcount, height:200)
            sliderImageCell.scrollView.delegate = self
            
            for index in 0..<arrbannerImages.count
            {
                let ximageview = CGFloat(index)
                let viewscroll = UIView (frame: CGRect (x:sliderImageCell.scrollView.frame.size.width*ximageview, y: 0, width: sliderImageCell.scrollView.frame.size.width, height: sliderImageCell.scrollView.frame.size.height))
                viewscroll.tag = index
                sliderImageCell.scrollView.addSubview(viewscroll)
                let imageview = UIImageView (frame: CGRect (x: 0, y: 0, width: viewscroll.frame.size.width, height: viewscroll.frame.size.height))
                imageview.contentMode = .scaleToFill
                let str_UserImage = arrbannerImages[index]["banner_image_url"]  as? String
                let utlll =  self.urlstring + str_UserImage!
                imageview.sd_setImage(with: URL(string:utlll), placeholderImage: UIImage(named: "Placeholder.png"))
                viewscroll.addSubview(imageview)
            }
            
            let totalPossibleOffset = CGFloat(arrbannerImages.count - 1) * self.view.bounds.size.width
            if offSet == totalPossibleOffset
            {
                offSet = 0 // come back to the first image after the last image
            } else if arrbannerImages.count == 1 {
                offSet = 0
            } else {
                offSet += self.view.bounds.size.width
            }
            DispatchQueue.main.async()
                {
                    UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                        sliderImageCell.scrollView.contentOffset.x = CGFloat(self.offSet)
                        let pageWidth:CGFloat = sliderImageCell.scrollView.frame.width
                        let currentPage:CGFloat = floor((sliderImageCell.scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
                        sliderImageCell.pageControl.currentPage = Int(currentPage)
                    }, completion: nil)
            }
            
            return sliderImageCell
        } else if indexPath.row >= 1 && indexPath.row <= 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardMainTVC", for: indexPath) as! DashBoardMainTVC
            cell.imageViewDashBoard.image = UIImage(named: propertyArrayImages1[indexPath.row - 1])
            //cell.lblHeading.text = propertyArray1[indexPath.row - 1]
            if let allTitles = self.dashboard?.cellTitle{
                let currentCellTitle = allTitles.filter{ $0.name == String(indexPath.row)}.first
                cell.lblHeading.text = currentCellTitle?.desc ?? ""
            }
            
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardSecCell", for: indexPath) as! DashBoardSecCell
            cell.buttonZodiac.addTarget(self, action: #selector(horoscopeApiCallMethods), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row >= 1 && indexPath.row <= 4 {
            if  indexPath.row == 1// chat with astrologer
            {
                userCountry = ""
                userCountrycode = ""
                chatcallingFormmm = "Chat"
                let AstroChatList = self.storyboard?.instantiateViewController(withIdentifier: "AstroChatListVC")
                self.navigationController?.pushViewController(AstroChatList!, animated: true)
            }
            else if  indexPath.row == 2// talk to astrologer
            {
                userCountry = ""
                userCountrycode = ""
                chatcallingFormmm = "Calling"
                let AstroTalkList = self.storyboard?.instantiateViewController(withIdentifier: "AstroTalkListVC")
                self.navigationController?.pushViewController(AstroTalkList!, animated: true)
            }
            else if  indexPath.row == 3
            {
                //QueryReportVC
                let QueryReport = self.storyboard?.instantiateViewController(withIdentifier: "QueryReportVC")
                self.navigationController?.pushViewController(QueryReport!, animated: true)
            }
            else if  indexPath.row == 4// astroshop
            {
                let ProductCategory = self.storyboard?.instantiateViewController(withIdentifier: "ProductCategoryVC")
                self.navigationController?.pushViewController(ProductCategory!, animated: true)
            }
        }  
    }
    
    @IBAction func btn_IsSelectedDeseleced(_ sender: UIButton) {
        selectedRow = sender.tag
        let dict_eventpoll = self.arrhoroscope[sender.tag]
        ZodiacID = dict_eventpoll["cms_zodiac_cms_id"] as? String ?? ""
        ZodiacName = dict_eventpoll["zodiac_category_name"] as? String ?? ""
        let str_UsersID = return_Response[sender.tag]["cms_zodiac_cms_id"] as? String ?? ""
        let Dailyhoroscope = self.storyboard?.instantiateViewController(withIdentifier: "DailyhoroscopeVC") as? DailyhoroscopeVC
        Dailyhoroscope?.selectedZodiac = dict_eventpoll
        self.navigationController?.pushViewController(Dailyhoroscope!, animated: true)
    }
    
}


class TypecallCelll: UITableViewCell
{
    @IBOutlet weak var lbl_typecall: UILabel!
    @IBOutlet weak var lbl_nextonline: UILabel!
    @IBOutlet weak var switch_ONOFF: UISwitch!
    
    
}

class TypecchatCell: UITableViewCell
{
    @IBOutlet weak var lbl_typechat: UILabel!
    @IBOutlet weak var lbl_nextonline1: UILabel!
    @IBOutlet weak var switch_ONOFF1: UISwitch!
}
class SliderImageCell: UITableViewCell {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
}

class tablecell: UITableViewCell {
    @IBOutlet var cv: UICollectionView!
    @IBOutlet var consHgtCv : NSLayoutConstraint!
}

class tablecell1: UITableViewCell {
    @IBOutlet var cv: UICollectionView!
    @IBOutlet var consHgtCv : NSLayoutConstraint!
}

class collectionCell: UICollectionViewCell {
    @IBOutlet var lbltitle : UILabel!
    @IBOutlet var imgall : UIImageView!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var VIEW1: UIView!
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var btn_click: UIButton!
}

class VisitedCell: UITableViewCell {
    @IBOutlet var colletionVisited: UICollectionView!
}

class VisitedCollectionCell: UICollectionViewCell {
    @IBOutlet weak var btn_click: UIButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var img_Category: UIImageView!
    @IBOutlet weak var view_back: UIView!
}

class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body, "sound" : "default"],
                                           "data" : ["user" : "test_id"]
            
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAj0B0n1U:APA91bEpb_r1nPNqUeevVUzaZ6I7c0XM3ldXs6P4XCUeoKDBTaJKWm4t2B3zWajZW3aUAnylqNn3D4B_1gjBrYk3ajrhwrbVvYRFkI8LjoJhxZNjgzqKpJ_RkAxGLPxyqizRFCZFSQrq", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}


class DashboardTitles : NSObject{
    
    var bottomOptions : [DashboardCell]?
    var cellTitle : [DashboardCell]?
    
    
    override init() {}
    required public convenience init(dict: [String : Any]) {
        self.init()
        let bottomOptionsArr = dict["options"] as? NSArray
        bottomOptions = DashboardCell.getDashboardCellObjectArr(array: bottomOptionsArr ?? [])
        let cellTitleArr = dict["texts"] as? NSArray
        cellTitle = DashboardCell.getDashboardCellObjectArr(array: cellTitleArr ?? [])
    }
}

class DashboardCell : NSObject{
    var desc : String?
    var isEnable : String?
    var mType : String?
    var name : String?
    
    override init() {}
    required public convenience init(dict: [String : Any]) {
        self.init()
        desc = dict["description"] as? String
        isEnable = dict["is_enable"] as? String
        mType = dict["m_type"] as? String
        name = dict["name"] as? String
    }
    
    public class func getDashboardCellObjectArr(array:NSArray) -> [DashboardCell]
    {
        var models : [DashboardCell] = []
        for item in array{
            models.append(DashboardCell(dict: item as! [String : Any]))
        }
        return models
    }
}


