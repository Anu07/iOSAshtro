//
//  SideMenuController.swift
//  SJSwiftNavigationController
//
//  Created by Mac on 12/19/16.
//  Copyright © 2016 Sumit Jagdev. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController
import SDWebImage
import StoreKit
import Firebase
import FirebaseInstanceID
import FirebaseAuth
import FirebaseMessaging
import FirebaseCore
import Fabric
import Crashlytics
import FirebaseDatabase
import MessageUI

class SideMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var menuTableView : UITableView!
    var ProfileuserName = ""
    let appID = "657576904"
    let propertyArray = [
        "Home",
        "Transaction History",
        "My Query/Report",
        "Blog",
        "History",
        "Free Services",
        "Astroshop Order history",
        "Astrology Knowledge Channel",
        "About Us",
//        "Refer to Friend",
        "Terms & Condition",
        "Privacy Policy",
        "FAQ",
        "Contact",
        //"Tutorial",
        "Logout"
    ]
    
    let propertyArrayImages = [
        "home-1",
        "wallet",
        "query",
        "blog",
        "history",
        "free service",
        "history",
        "tutorial",
        "about us",
//        "refer a friend",
        "term-and-condition",
        "PrivacyPolicy",
        "faq",
        "contact us",
        //"tutorial",
        "logout-1"
        
    ]
    
    
    let propertyArray1 = [
        "About Us",
        "Contact Us",
        "FAQ",
        "Terms & Conditions",
        "Privacy Policy",
        "Chat With Us",
        "Share App",
        "Rate Us"
        
    ]
    let propertyArray1Images = [
        "aboutus",
        "contactus",
        "faq",
        "faq",
        "faq",
        "faq",
        "faq",
        "faq"
        
    ]
    
    
    
    var menuItems : NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.bounces = false
        
        let data_IsLogin = UserDefaults.standard.value(forKey: "isUserData") as? Data
        if let getData = data_IsLogin {
            let dict_IsLogin = NSKeyedUnarchiver.unarchiveObject(with:getData) as? [String:Any]
            user_id = dict_IsLogin?["user_uni_id"] as? String ?? ""
            user_apikey = UserDefaults.standard.value(forKey: "userKey") as? String ?? ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = UserDefaults.standard.value(forKey: "isUserData") as? Data{
            self.func_GetProfiledata()
        }
        menuTableView.allowsSelection = true
        menuTableView.isUserInteractionEnabled = true
        // self.view.backgroundColor = UIColor.black
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func func_GetProfiledata() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey]
        
        print(setparameters)
        // AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.GETUSERPROFILEDATA.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            personaldetailss = tempDict["data"] as! [String:Any]
                                            print("personaldetailss is:- ",personaldetailss)
                                            
                                            
                                            self.ProfileuserName = personaldetailss["customer_name"] as! String
                                            self.menuTableView.reloadData()
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
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section==0
        {
            return 1
        }
        else
        {
            return propertyArray.count
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 178
        }
        else
        {
            return 48
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let SlideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SlideMenuCell", for: indexPath) as! SlideMenuCell
            SlideMenuCell.btn_profile.tag = indexPath.row
            SlideMenuCell.btn_profile.addTarget(self, action: #selector(self.btn_profileAction(_:)), for: .touchUpInside)
            if personaldetailss.count != 0
            {
                SlideMenuCell.lbl_Username.text = self.ProfileuserName.uppercased()
            } else {
                SlideMenuCell.lbl_Username.text = "Guest".uppercased()
            }
            return SlideMenuCell
        }
        else
        {
            let SlideMenuCell2 = tableView.dequeueReusableCell(withIdentifier: "SlideMenuCell2", for: indexPath) as! SlideMenuCell2
            if propertyArray.count - 1 == indexPath.row {
                if let _ = UserDefaults.standard.value(forKey: "isUserData") as? Data {
                    SlideMenuCell2.lbl_Profile.text = propertyArray[indexPath.row]
                    let image = propertyArrayImages[indexPath.row]
                    SlideMenuCell2.img_picture.image = UIImage(named:image)!
                } else {
                    SlideMenuCell2.lbl_Profile.text = "Login"
                    SlideMenuCell2.img_picture.image = UIImage(named:"login-24")
                }
            } else {
                SlideMenuCell2.lbl_Profile.text = propertyArray[indexPath.row]
                let image = propertyArrayImages[indexPath.row]
                SlideMenuCell2.img_picture.image = UIImage(named:image)!
            }
    // propertyArrayImages
            
            return SlideMenuCell2
        }
        
        
    }
    @objc func btn_profileAction(_ sender: UIButton)
    {
        
        if let data_IsLogin = UserDefaults.standard.value(forKey: "isUserData") as? Data {
            let ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
            self.navigationController?.pushViewController(ProfileVC!, animated: true)
        } else {
            print("move to loginVC")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                SJSwiftSideMenuController.toggleLeftSideMenu()
            } else if indexPath.row == 1 {
                if self.PerformActionIfLogin() {
                    let WALLET = self.storyboard?.instantiateViewController(withIdentifier: "WalletVC")
                    self.navigationController?.pushViewController(WALLET!, animated: true)
                }
            } else if indexPath.row == 2 {
                if self.PerformActionIfLogin() {
                    let QueryReportListing = self.storyboard?.instantiateViewController(withIdentifier: "QueryReportListingVC")
                    self.navigationController?.pushViewController(QueryReportListing!, animated: true)
                }
            } else if indexPath.row == 3 {
                let blog = self.storyboard?.instantiateViewController(withIdentifier: "BlogVC")
                self.navigationController?.pushViewController(blog!, animated: true)
            } else if indexPath.row == 4 {
                if self.PerformActionIfLogin() {
                    let Historytotal = self.storyboard?.instantiateViewController(withIdentifier: "HistorytotalVC")
                    self.navigationController?.pushViewController(Historytotal!, animated: true)
                }
            } else if indexPath.row == 5 {
                let freeservices = self.storyboard?.instantiateViewController(withIdentifier: "FreeServicesVC")
                self.navigationController?.pushViewController(freeservices!, animated: true)
            } else if indexPath.row == 6 {
                if self.PerformActionIfLogin() {
                    let OrderHistory = self.storyboard?.instantiateViewController(withIdentifier: "OrderHistoryVC")
                    self.navigationController?.pushViewController(OrderHistory!, animated: true)
                }
            } else if indexPath.row == 7 {
                let Astrologychannel = self.storyboard?.instantiateViewController(withIdentifier: "AstrologychannelVC")
                self.navigationController?.pushViewController(Astrologychannel!, animated: true)
            } else if indexPath.row == 8 {
                let AboutUs = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC")
                self.navigationController?.pushViewController(AboutUs!, animated: true)
            }
//            else if indexPath.row == 9 {
//                if self.PerformActionIfLogin() {
//                    let refer = self.storyboard?.instantiateViewController(withIdentifier: "RefertofriendVC")
//                    self.navigationController?.pushViewController(refer!, animated: true)
//                }
                
         //   }
        else if indexPath.row == 9 {
                let Terms = self.storyboard?.instantiateViewController(withIdentifier: "TermsandconditionVC")
                self.navigationController?.pushViewController(Terms!, animated: true)
            } else if indexPath.row == 10 {
                let Privacy = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyVC")
                self.navigationController?.pushViewController(Privacy!, animated: true)
            } else if indexPath.row == 11 {
                let FAQ = self.storyboard?.instantiateViewController(withIdentifier: "FrequentlyAskQuestionVC")
                self.navigationController?.pushViewController(FAQ!, animated: true)
            } else if indexPath.row == 12 {
                let Contact = self.storyboard?.instantiateViewController(withIdentifier: "ContactVC")
                self.navigationController?.pushViewController(Contact!, animated: true)
//            } else if indexPath.row == 14 {
//                let youtubeId = "jANE8lpoj2c"
//                var url = URL(string:"youtube://\(youtubeId)")!
//                if !UIApplication.shared.canOpenURL(url)  {
//                    url = URL(string:"http://www.youtube.com/watch?v=\(youtubeId)")!
//                }
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                if let _ = UserDefaults.standard.value(forKey: "isUserData") as? Data {
                    let refreshAlert = UIAlertController(title: "Log Out", message: "Are You Sure to Log Out ? ", preferredStyle: UIAlertController.Style.alert)
                    refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler:
                        {
                            (action: UIAlertAction!) in
                            self.logoutFun()
                    }))
                    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:
                        {
                            (action: UIAlertAction!) in
                            refreshAlert .dismiss(animated: true, completion: nil)
                    }))
                    present(refreshAlert, animated: true, completion: nil)
                } else {
                    self.moveTologinVC()
                }
            }
        }
        
    }
    func share(message: String, link: String) {
        if let link = NSURL(string: link) {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    func open(url: URL)
    {
        if #available(iOS 10, *)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                print("Open \(url): \(success)")
            })
        }
        else if UIApplication.shared.openURL(url)
        {
            print("Open \(url)")
        }
    }
    func openWhatsapp(){
        
        let string1 = whatsappmobile
        let url = string1
        
        //let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(url)&text=Invitation")
        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(url)")
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
        }
    }
    func logoutFun()
    {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        UserDefaults.standard.removeObject(forKey: "isSignup")
        UserDefaults.standard.removeObject(forKey: "isUserData")
        
        let firebaseAuth = Auth.auth()
        do
        {
            try firebaseAuth.signOut()
        }
        catch let signOutError as NSError
        {
            print ("Error signing out: %@", signOutError)
        }
        appDelegate.moveToDashBoardVC()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnSuggestionAction(_ sender: Any) {
        let recipientEmail = "customersupport@astroshubh.in"
        let subject = "Suggestion"
        let body = ""
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            present(mail, animated: true)
        }
    }
    
    @IBAction func btn_KriscentAction(_ sender: Any)
    {
        var url = URL(string:"https://www.kriscent.com")!
        if !UIApplication.shared.canOpenURL(url)  {
            url = URL(string:"https://www.kriscent.com")!
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    //    @IBAction func btn_androidAction(_ sender: Any)
    //    {
    //    }
    //    @IBAction func btn_appleAction(_ sender: Any)
    //    {
    //    }
    @IBAction func btn_facebbokAction(_ sender: Any)
    {
        guard let webpageURL = NSURL(string: "https://www.facebook.com/astroshubh.in") else {
            return
        }
        
        UIApplication.shared.openURL(webpageURL as URL)
    }
    
    @IBAction func btn_watsappAction(_ sender: Any)
    {
        let urlWhats = "whatsapp://send?phone=+919999122091"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.openURL(whatsappURL)
                } else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    
    @IBAction func btn_youtubeAction(_ sender: Any)
    {
        
        //https://www.youtube.com/channel/UCBiPxANFb4hVQE0lwtMeTAw
//        let youtubeId = "jANE8lpoj2c"
//
//        var url = URL(string:"youtube://\(youtubeId)")!
        guard let url = URL(string:"https://www.youtube.com/channel/UCBiPxANFb4hVQE0lwtMeTAw") else { return }
        if UIApplication.shared.canOpenURL(url)  {
            //url = URL(string:"http://www.youtube.com/watch?v=\(youtubeId)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    @IBAction func btn_instaAction(_ sender: Any)
    {
        let instagramHooks = "https://www.instagram.com/astroshubh_in/"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/astroshubh_in/")! as URL)
        }
    }
    @IBAction func btn_twterAction(_ sender: Any)
    {
        let twUrl = URL(string: "https://twitter.com/astroshubh")!
        // let twUrlWeb = URL(string: "https://www.twitter.com/wixvii")!
        if UIApplication.shared.canOpenURL(twUrl){
            UIApplication.shared.open(twUrl, options: [:],completionHandler: nil)
        }
    }
    @IBAction func btn_wahtsappAction(_ sender: Any)
    {
        self.openWhatsapp()
    }
    
}
extension CGFloat {
    public static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    public static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                //application.openURL(URL(string: url)!)
                application.open(URL(string: url)!, options: [:], completionHandler: nil)
                return
            }
        }
    }
}
