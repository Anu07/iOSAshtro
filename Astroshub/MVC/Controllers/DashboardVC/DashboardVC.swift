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
import WOWRibbonView
import FBSDKCoreKit
class DashboardVC: UIViewController , UITextFieldDelegate , MKMapViewDelegate , CLLocationManagerDelegate,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MFMailComposeViewControllerDelegate {
    var fromSignup = ""
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
    var selectedZodiac = [String:Any]()
    
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
        "Astro Shop"
    ]
    
    let propertyArrayImages1 = [
        "chat",
        "talk",
        "report",
        "cart "
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
        
        
        tbl_dashboard.register(UINib(nibName: "ButtonsForQueryRemedyCell", bundle: nil), forCellReuseIdentifier: "ButtonsForQueryRemedyCell")
        
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
        let boolForChat =  UserDefaults.standard.value(forKey: "ChatBool") as? Bool
//        if boolForChat == true {
//            if chatStartorEnd == "Astrologer Accepted Chat Request" {
//                bubble.badgeCount = 1
//            }
//            self.setupBubble()
//        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationAccept(notification:)), name: Notification.Name("NotificationIdentifierForBubble"), object:  nil)

    }
    
    @objc func methodOfReceivedNotificationAccept(notification: Notification) {
//        let boolForChat =  UserDefaults.standard.value(forKey: "ChatBool") as? Bool
//        if boolForChat == true {
//            if chatStartorEnd == "Astrologer Accepted Chat Request" {
//                bubble.badgeCount = 1
//            }
////            self.setupBubble()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if !hasLocationPermission() {
//            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
//                  
//                  let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
//                      //Redirect to Settings app
//                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
//                  })
//                  
////                  let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
////                  alertController.addAction(cancelAction)
//                  
//                  alertController.addAction(okAction)
//                  
//                  self.present(alertController, animated: true, completion: nil)
//              }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager.delegate = self
        manager.requestLocation()
        manager.requestAlwaysAuthorization()
        self.manager.requestWhenInUseAuthorization()
        self.manager.startMonitoringSignificantLocationChanges()
                if CLLocationManager.locationServicesEnabled() {
                    manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                 manager.startUpdatingLocation()
               }
        
//        if !hasLocationPermission() {
//            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
//
//                  let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
//                      //Redirect to Settings app
//                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
//                  })
//
////                  let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
////                  alertController.addAction(cancelAction)
//
//                  alertController.addAction(okAction)
//
//                  self.present(alertController, animated: true, completion: nil)
//              }
        
//        let boolForChat =  UserDefaults.standard.value(forKey: "ChatBool") as? Bool
//        if boolForChat == true {
//            if chatStartorEnd == "Astrologer Accepted Chat Request" {
//                bubble.badgeCount += 1
//            }
////            self.setupBubble()
//        }
        
        if CurrentLocation.count != 0 {
            self.func_CallWelcomeAPI()
            if let _ = UserDefaults.standard.value(forKey: "isUserData") as? Data {
                self.walletApiCallMethods()
            }
        }
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
    
    // MARK: Bubble

//    func setupBubble () {
//        let win = APPDELEGATE.window!
//
//        bubble = BubbleControl (size: CGSize(width: 80, height: 80))
//        bubble.image = UIImage (named: "chat")
//
//        bubble.didNavigationBarButtonPressed = {
//            print("pressed in nav bar")
//            bubble!.popFromNavBar()
//        }
//
//        bubble.setOpenAnimation = { content, background in
//            bubble.contentView!.bottom = win.bottom
//            if (bubble.center.x > win.center.x) {
//                bubble.contentView!.left = win.right
//                bubble.contentView!.spring(animations: { () -> Void in
//                    bubble.contentView!.right = win.right
//                }, completion: nil)
//                let ChatHistory = self.storyboard?.instantiateViewController(withIdentifier: "AstroChatVC") as! AstroChatVC
//                let valueResumeChat = UserDefaults.standard.value(forKey: "ChatResume")
//                OnTabfcmUserID = "\(valueResumeChat ?? "")"
//                self.navigationController?.show(ChatHistory, sender: nil)
//                bubble.removeFromSuperview()
//            } else {
//                bubble.contentView!.right = win.left
//                bubble.contentView!.spring(animations: { () -> Void in
//                    bubble.contentView!.left = win.left
//                }, completion: nil)
//                let ChatHistory = self.storyboard?.instantiateViewController(withIdentifier: "AstroChatVC") as! AstroChatVC
//                let valueResumeChat = UserDefaults.standard.value(forKey: "ChatResume")
//                OnTabfcmUserID = "\(valueResumeChat ?? "")"
//                self.navigationController?.show(ChatHistory, sender: nil)
//                bubble.removeFromSuperview()
//            }
//
//        }
//
//
////        //let min: CGFloat = 50
////        let max: CGFloat = win.h - 250
////        //let randH = min + CGFloat(random()%Int(max-min))
////
////        let v = UIView (frame: CGRect (x: 0, y: 0, width: win.w, height: max))
////        v.backgroundColor = UIColor.gray
////
////        let label = UILabel (frame: CGRect (x: 10, y: 10, width: v.w, height: 20))
////        label.text = "test text"
////        v.addSubview(label)
//
//        bubble.contentView = self.view
//
//        win.addSubview(bubble)
//    }
    
    // MARK: Animation
    
//    var animateIcon: Bool = false {
//        didSet {
//            if animateIcon {
//                bubble.didToggle = { on in
//                    if (bubble.imageView?.layer.sublayers?[0] as? CAShapeLayer) != nil {
//                        self.animateBubbleIcon(on)
//                    }
//                    else {
//                        bubble.imageView?.image = nil
//
//                        let shapeLayer = CAShapeLayer ()
//                        shapeLayer.lineWidth = 0.25
//                        shapeLayer.strokeColor = UIColor.black.cgColor
////                        shapeLayer.fillMode = CAMediaTimingFillMode.f
//
//                        bubble.imageView?.layer.addSublayer(shapeLayer)
//                        self.animateBubbleIcon(on)
//                    }
//                }
//            } else {
//                bubble.didToggle = nil
//                bubble.imageView?.layer.sublayers = nil
//                bubble.imageView?.image = bubble.image!
//            }
//        }
//    }
//    func animateBubbleIcon (_ on: Bool) {
//        let shapeLayer = bubble.imageView!.layer.sublayers![0] as! CAShapeLayer
//        let from = on ? self.basketBezier().cgPath: self.arrowBezier().cgPath
//        let to = on ? self.arrowBezier().cgPath: self.basketBezier().cgPath
//
//        let anim = CABasicAnimation (keyPath: "path")
//        anim.fromValue = from
//        anim.toValue = to
//        anim.duration = 0.5
////        anim.fillMode = CAMediaTimingFillMode.forwards
//        anim.isRemovedOnCompletion = false
//
//        shapeLayer.add (anim, forKey:"bezier")
//    }
    
    
//    func arrowBezier () -> UIBezierPath {
//        //// PaintCode Trial Version
//        //// www.paintcodeapp.com
//
//        let color0 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
//
//        let bezier2Path = UIBezierPath()
//        bezier2Path.move(to: CGPoint(x: 21.22, y: 2.89))
//        bezier2Path.addCurve(to: CGPoint(x: 19.87, y: 6.72), controlPoint1: CGPoint(x: 21.22, y: 6.12), controlPoint2: CGPoint(x: 20.99, y: 6.72))
//        bezier2Path.addCurve(to: CGPoint(x: 14.54, y: 7.92), controlPoint1: CGPoint(x: 19.12, y: 6.72), controlPoint2: CGPoint(x: 16.72, y: 7.24))
//        bezier2Path.addCurve(to: CGPoint(x: 0.44, y: 25.84), controlPoint1: CGPoint(x: 7.27, y: 10.09), controlPoint2: CGPoint(x: 1.64, y: 17.14))
//        bezier2Path.addCurve(to: CGPoint(x: 2.39, y: 26.97), controlPoint1: CGPoint(x: -0.08, y: 29.74), controlPoint2: CGPoint(x: 1.12, y: 30.49))
//        bezier2Path.addCurve(to: CGPoint(x: 17.62, y: 16.09), controlPoint1: CGPoint(x: 4.34, y: 21.19), controlPoint2: CGPoint(x: 10.12, y: 17.14))
//        bezier2Path.addLine(to: CGPoint(x: 21.14, y: 15.64))
//        bezier2Path.addLine(to: CGPoint(x: 21.37, y: 19.47))
//        bezier2Path.addLine(to: CGPoint(x: 21.59, y: 23.29))
//        bezier2Path.addLine(to: CGPoint(x: 29.09, y: 17.52))
//        bezier2Path.addCurve(to: CGPoint(x: 36.59, y: 11.22), controlPoint1: CGPoint(x: 33.22, y: 14.37), controlPoint2: CGPoint(x: 36.59, y: 11.52))
//        bezier2Path.addCurve(to: CGPoint(x: 22.12, y: -0.33), controlPoint1: CGPoint(x: 36.59, y: 10.69), controlPoint2: CGPoint(x: 24.89, y: 1.39))
//        bezier2Path.addCurve(to: CGPoint(x: 21.22, y: 2.89), controlPoint1: CGPoint(x: 21.44, y: -0.71), controlPoint2: CGPoint(x: 21.22, y: 0.19))
//        bezier2Path.close()
//        bezier2Path.move(to: CGPoint(x: 31.87, y: 8.82))
//        bezier2Path.addCurve(to: CGPoint(x: 34.64, y: 11.22), controlPoint1: CGPoint(x: 33.44, y: 9.94), controlPoint2: CGPoint(x: 34.72, y: 10.99))
//        bezier2Path.addCurve(to: CGPoint(x: 28.87, y: 15.87), controlPoint1: CGPoint(x: 34.64, y: 11.44), controlPoint2: CGPoint(x: 32.09, y: 13.54))
//        bezier2Path.addLine(to: CGPoint(x: 23.09, y: 20.14))
//        bezier2Path.addLine(to: CGPoint(x: 22.87, y: 17.07))
//        bezier2Path.addLine(to: CGPoint(x: 22.64, y: 13.99))
//        bezier2Path.addLine(to: CGPoint(x: 18.97, y: 14.44))
//        bezier2Path.addCurve(to: CGPoint(x: 6.22, y: 19.24), controlPoint1: CGPoint(x: 13.04, y: 15.12), controlPoint2: CGPoint(x: 9.44, y: 16.54))
//        bezier2Path.addCurve(to: CGPoint(x: 5.09, y: 16.84), controlPoint1: CGPoint(x: 2.77, y: 22.24), controlPoint2: CGPoint(x: 2.39, y: 21.49))
//        bezier2Path.addCurve(to: CGPoint(x: 20.69, y: 8.22), controlPoint1: CGPoint(x: 8.09, y: 11.82), controlPoint2: CGPoint(x: 14.54, y: 8.22))
//        bezier2Path.addCurve(to: CGPoint(x: 22.72, y: 5.14), controlPoint1: CGPoint(x: 22.57, y: 8.22), controlPoint2: CGPoint(x: 22.72, y: 7.99))
//        bezier2Path.addLine(to: CGPoint(x: 22.72, y: 2.07))
//        bezier2Path.addLine(to: CGPoint(x: 25.94, y: 4.47))
//        bezier2Path.addCurve(to: CGPoint(x: 31.87, y: 8.82), controlPoint1: CGPoint(x: 27.67, y: 5.74), controlPoint2: CGPoint(x: 30.37, y: 7.77))
//        bezier2Path.close()
//        bezier2Path.miterLimit = 4;
//
//        color0.setFill()
//        bezier2Path.fill()
//        return bezier2Path
//    }
//    func basketBezier () -> UIBezierPath {
//        //// PaintCode Trial Version
//        //// www.paintcodeapp.com
//        
//        let color0 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
//        
//        let bezier2Path = UIBezierPath()
//        bezier2Path.move(to: CGPoint(x: 0.86, y: 0.36))
//        bezier2Path.addCurve(to: CGPoint(x: 3.41, y: 6.21), controlPoint1: CGPoint(x: -0.27, y: 1.41), controlPoint2: CGPoint(x: 0.48, y: 2.98))
//        bezier2Path.addLine(to: CGPoint(x: 6.41, y: 9.51))
//        bezier2Path.addLine(to: CGPoint(x: 3.18, y: 9.73))
//        bezier2Path.addCurve(to: CGPoint(x: -0.27, y: 12.96), controlPoint1: CGPoint(x: 0.03, y: 9.96), controlPoint2: CGPoint(x: -0.04, y: 10.03))
//        bezier2Path.addCurve(to: CGPoint(x: 0.48, y: 16.71), controlPoint1: CGPoint(x: -0.42, y: 14.83), controlPoint2: CGPoint(x: -0.12, y: 16.18))
//        bezier2Path.addCurve(to: CGPoint(x: 3.26, y: 23.46), controlPoint1: CGPoint(x: 1.08, y: 17.08), controlPoint2: CGPoint(x: 2.28, y: 20.16))
//        bezier2Path.addCurve(to: CGPoint(x: 18.33, y: 32.08), controlPoint1: CGPoint(x: 6.03, y: 32.91), controlPoint2: CGPoint(x: 4.61, y: 32.08))
//        bezier2Path.addCurve(to: CGPoint(x: 33.41, y: 23.46), controlPoint1: CGPoint(x: 32.06, y: 32.08), controlPoint2: CGPoint(x: 30.63, y: 32.91))
//        bezier2Path.addCurve(to: CGPoint(x: 36.18, y: 16.71), controlPoint1: CGPoint(x: 34.38, y: 20.16), controlPoint2: CGPoint(x: 35.58, y: 17.08))
//        bezier2Path.addCurve(to: CGPoint(x: 36.93, y: 12.96), controlPoint1: CGPoint(x: 36.78, y: 16.18), controlPoint2: CGPoint(x: 37.08, y: 14.83))
//        bezier2Path.addCurve(to: CGPoint(x: 33.48, y: 9.73), controlPoint1: CGPoint(x: 36.71, y: 10.03), controlPoint2: CGPoint(x: 36.63, y: 9.96))
//        bezier2Path.addLine(to: CGPoint(x: 30.26, y: 9.51))
//        bezier2Path.addLine(to: CGPoint(x: 33.33, y: 6.13))
//        bezier2Path.addCurve(to: CGPoint(x: 36.18, y: 1.48), controlPoint1: CGPoint(x: 35.06, y: 4.26), controlPoint2: CGPoint(x: 36.33, y: 2.16))
//        bezier2Path.addCurve(to: CGPoint(x: 28.23, y: 4.63), controlPoint1: CGPoint(x: 35.66, y: -1.22), controlPoint2: CGPoint(x: 33.26, y: -0.24))
//        bezier2Path.addLine(to: CGPoint(x: 23.06, y: 9.58))
//        bezier2Path.addLine(to: CGPoint(x: 18.33, y: 9.58))
//        bezier2Path.addLine(to: CGPoint(x: 13.61, y: 9.58))
//        bezier2Path.addLine(to: CGPoint(x: 8.51, y: 4.71))
//        bezier2Path.addCurve(to: CGPoint(x: 0.86, y: 0.36), controlPoint1: CGPoint(x: 3.78, y: 0.13), controlPoint2: CGPoint(x: 2.06, y: -0.84))
//        bezier2Path.close()
//        bezier2Path.move(to: CGPoint(x: 10.08, y: 12.66))
//        bezier2Path.addCurve(to: CGPoint(x: 14.58, y: 12.21), controlPoint1: CGPoint(x: 12.33, y: 14.38), controlPoint2: CGPoint(x: 14.58, y: 14.16))
//        bezier2Path.addCurve(to: CGPoint(x: 18.33, y: 11.08), controlPoint1: CGPoint(x: 14.58, y: 11.38), controlPoint2: CGPoint(x: 15.48, y: 11.08))
//        bezier2Path.addCurve(to: CGPoint(x: 22.08, y: 12.21), controlPoint1: CGPoint(x: 21.18, y: 11.08), controlPoint2: CGPoint(x: 22.08, y: 11.38))
//        bezier2Path.addCurve(to: CGPoint(x: 26.58, y: 12.66), controlPoint1: CGPoint(x: 22.08, y: 14.16), controlPoint2: CGPoint(x: 24.33, y: 14.38))
//        bezier2Path.addCurve(to: CGPoint(x: 32.21, y: 11.08), controlPoint1: CGPoint(x: 28.08, y: 11.61), controlPoint2: CGPoint(x: 29.88, y: 11.08))
//        bezier2Path.addCurve(to: CGPoint(x: 35.58, y: 13.33), controlPoint1: CGPoint(x: 35.43, y: 11.08), controlPoint2: CGPoint(x: 35.58, y: 11.16))
//        bezier2Path.addLine(to: CGPoint(x: 35.58, y: 15.58))
//        bezier2Path.addLine(to: CGPoint(x: 18.33, y: 15.58))
//        bezier2Path.addLine(to: CGPoint(x: 1.08, y: 15.58))
//        bezier2Path.addLine(to: CGPoint(x: 1.08, y: 13.33))
//        bezier2Path.addCurve(to: CGPoint(x: 4.46, y: 11.08), controlPoint1: CGPoint(x: 1.08, y: 11.16), controlPoint2: CGPoint(x: 1.23, y: 11.08))
//        bezier2Path.addCurve(to: CGPoint(x: 10.08, y: 12.66), controlPoint1: CGPoint(x: 6.78, y: 11.08), controlPoint2: CGPoint(x: 8.58, y: 11.61))
//        bezier2Path.close()
//        bezier2Path.move(to: CGPoint(x: 11.21, y: 22.86))
//        bezier2Path.addCurve(to: CGPoint(x: 12.71, y: 28.71), controlPoint1: CGPoint(x: 11.21, y: 28.18), controlPoint2: CGPoint(x: 11.36, y: 28.71))
//        bezier2Path.addCurve(to: CGPoint(x: 14.43, y: 22.86), controlPoint1: CGPoint(x: 14.06, y: 28.71), controlPoint2: CGPoint(x: 14.21, y: 28.11))
//        bezier2Path.addCurve(to: CGPoint(x: 15.56, y: 17.08), controlPoint1: CGPoint(x: 14.58, y: 18.96), controlPoint2: CGPoint(x: 14.96, y: 17.08))
//        bezier2Path.addCurve(to: CGPoint(x: 16.23, y: 21.21), controlPoint1: CGPoint(x: 16.16, y: 17.08), controlPoint2: CGPoint(x: 16.38, y: 18.36))
//        bezier2Path.addCurve(to: CGPoint(x: 18.56, y: 28.93), controlPoint1: CGPoint(x: 15.86, y: 27.13), controlPoint2: CGPoint(x: 16.46, y: 29.23))
//        bezier2Path.addCurve(to: CGPoint(x: 20.21, y: 22.86), controlPoint1: CGPoint(x: 20.13, y: 28.71), controlPoint2: CGPoint(x: 20.21, y: 28.33))
//        bezier2Path.addCurve(to: CGPoint(x: 21.11, y: 17.08), controlPoint1: CGPoint(x: 20.21, y: 18.88), controlPoint2: CGPoint(x: 20.51, y: 17.08))
//        bezier2Path.addCurve(to: CGPoint(x: 22.23, y: 22.86), controlPoint1: CGPoint(x: 21.71, y: 17.08), controlPoint2: CGPoint(x: 22.08, y: 18.96))
//        bezier2Path.addCurve(to: CGPoint(x: 23.96, y: 28.71), controlPoint1: CGPoint(x: 22.46, y: 28.11), controlPoint2: CGPoint(x: 22.61, y: 28.71))
//        bezier2Path.addCurve(to: CGPoint(x: 25.46, y: 22.86), controlPoint1: CGPoint(x: 25.31, y: 28.71), controlPoint2: CGPoint(x: 25.46, y: 28.18))
//        bezier2Path.addLine(to: CGPoint(x: 25.46, y: 17.08))
//        bezier2Path.addLine(to: CGPoint(x: 29.43, y: 17.08))
//        bezier2Path.addCurve(to: CGPoint(x: 31.53, y: 24.58), controlPoint1: CGPoint(x: 33.93, y: 17.08), controlPoint2: CGPoint(x: 33.86, y: 16.78))
//        bezier2Path.addLine(to: CGPoint(x: 29.88, y: 30.21))
//        bezier2Path.addLine(to: CGPoint(x: 18.33, y: 30.21))
//        bezier2Path.addLine(to: CGPoint(x: 6.78, y: 30.21))
//        bezier2Path.addLine(to: CGPoint(x: 5.13, y: 24.58))
//        bezier2Path.addCurve(to: CGPoint(x: 7.31, y: 17.08), controlPoint1: CGPoint(x: 2.81, y: 16.78), controlPoint2: CGPoint(x: 2.73, y: 17.08))
//        bezier2Path.addLine(to: CGPoint(x: 11.21, y: 17.08))
//        bezier2Path.addLine(to: CGPoint(x: 11.21, y: 22.86))
//        bezier2Path.close()
//        bezier2Path.miterLimit = 4;
//        
//        color0.setFill()
//        bezier2Path.fill()
//        return bezier2Path
//    }
    
    //MARK:- Custom Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
//            print("Found user's location: \(location)")
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if (error != nil) {
                    print("error in reverseGeocode")
                }
                if let placemark = placemarks, placemark.count > 0 {
                    let placemarkObj = placemark[0]
                    print(placemarkObj.country!)
                    if let getCountry = placemarkObj.country {
                        CurrentLocation = "United States"
                        print("coutry name is: \(getCountry)")
                        UserDefaults.standard.set("United States", forKey: "country")
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
        let setparameters = ["app_type":kIOS ,"app_version":kAppVersion,"location":CurrentLocation,"user_api_key":user_apikey,"user_id":user_id]
        print(setparameters)
//        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("welcome", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
//                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            Supportmobile = dict_Data["mobile_number"] as! String
                                            whatsappmobile = dict_Data["whatsapp_number"] as! String
                                            FormQueryPrice = dict_Data["query_price"] as! Int
                                            FormVoiceQueryPrice = dict_Data["price_voice_query"] as! Int
                                            FormReportPrice = dict_Data["report_price"] as! Int
                                            FormRemedyPrice = Int(dict_Data["inr_remedy_price"] as! String)!
                                            FormRemedydollarPrice = Int(dict_Data["doller_remedy_price"] as! String)!
                                            
                                            if UserDefaults.standard.value(forKey: "offerShowPopUp") as? Bool == true {
                                                
                                            }else {
                                            let offer = dict_Data["recharge"] as? Array<Any>
                                                ?? []
                                            if offer.count == 0 {
                                                
                                            } else {
                                            let valueoffer = offer[0] as! [String:Any]
                                            let walletAmount = valueoffer["wallet_amount"] as! String
                                            if walletAmount == "1" ||  walletAmount == "50" {
                                                UserDefaults.standard.setValue(true, forKey: "offerShowPopUp")
                                                if self.PerformActionIfLogin() {
                                                let vc =  self.storyboard?.instantiateViewController(withIdentifier: "WalletOfferViewController") as! WalletOfferViewController
                                                vc.strForAmount = walletAmount
                                                vc.completionHandler = { text in
                                                    if self.PerformActionIfLogin()  {
                                                        let WalletNew = self.storyboard?.instantiateViewController(withIdentifier: "WalletNewVC") as? WalletNewVC
                                                        
                                                        self.navigationController?.pushViewController(WalletNew!, animated: true)
                                                    }
                                                    return ""
                                                }
                                                self.navigationController?.present(vc, animated: true, completion: nil)
                                                }
                                            }
                                            else{
                                                
                                            }
                                            }}
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
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "BabypdfviewVC") as! BabypdfviewVC
        controller.value = 4
        self.navigationController?.pushViewController(controller, animated: true)
        
//        let horoscopevC = self.storyboard?.instantiateViewController(withIdentifier: "HoroScopeVC") as! HoroScopeVC
////        horoscopevC.horoscopeRes = self.return_Response
//        self.navigationController?.pushViewController(horoscopevC, animated: true)
        
//
//        let deviceID = UIDevice.current.identifierForVendor!.uuidString
//        print(deviceID)
//        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey.count > 0 ? user_apikey : "7bd679c21b8edcc185d1b6859c2e56ad" ,"user_id":user_id.count > 0 ? user_id: "CUSGUS","zodic_id":""]
//        print(setparameters)
//        //        ActivityIndicator.shared.startLoading()
//        //AutoBcmLoadingView.show("Loading......")
//        AppHelperModel.requestPOSTURL(MethodName.HOROSCOPE.rawValue, params: setparameters as [String : AnyObject],headers: nil,
//                                      success: { (respose) in
//                                        ActivityIndicator.shared.stopLoader()
//                                        let tempDict = respose as! NSDictionary
//                                        print(tempDict)
//                                        let success=tempDict["response"] as!   Bool
//                                        let message=tempDict["msg"] as!   String
//                                        if success == true
//                                        {
//                                            self.arrhoroscope = [[String:Any]]()
//
//                                            self.return_Response = [[String:Any]]()
//                                            var arrProducts = [[String:Any]]()
//                                            arrProducts=tempDict["data"] as! [[String:Any]]
//                                            for i in 0..<arrProducts.count
//                                            {
//                                                var dict_Products = arrProducts[i]
//                                                dict_Products["isSelectedDeselected"] = "0"
//                                                dict_Products["id"] = i+1
//                                                self.index_value = i
//                                                self.arrhoroscope.append(dict_Products)
//                                            }
//
//                                            self.return_Response = self.arrhoroscope
//                                            let horoscopevC = self.storyboard?.instantiateViewController(withIdentifier: "HoroScopeVC") as! HoroScopeVC
//                                            horoscopevC.horoscopeRes = self.return_Response
//                                            self.navigationController?.pushViewController(horoscopevC, animated: true)
//                                        }
//                                        else
//                                        {
//                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
//                                        }
//                                      }) { (error) in
//            print(error)
//            AutoBcmLoadingView.dismiss()
//        }
//
//
        
    }
    func walletApiCallMethods() {
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id,"location":CurrentLocation]
        print(setparameters)
        AppHelperModel.requestPOSTURL("getTotalBalance", params: setparameters as [String : AnyObject],headers: nil,
                                      success: {
                                        (respose) in
                                        let tempDict = respose as! NSDictionary
//                                        print(tempDict)
                                        
                                        let success = tempDict["response"] as!   Bool
                                        let message = tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            let amount = dict_Data["user_wallet_amt"] as! String
                                            
                                            let amount1 = String(amount)
                                            var splitString = amount1.split(separator: " ")
                                            if splitString.count == 2 {
                                                if let getBalance = Double(splitString[1]) {
                                                    walletBalanceNew = getBalance
                                                    let defaults = UserDefaults.standard
                                                    defaults.set(walletBalanceNew, forKey: "balance")
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
            AppEvents.logEvent(AppEvents.Name(rawValue: "wallet"))

            let WalletNew = self.storyboard?.instantiateViewController(withIdentifier: "WalletNewVC")
            self.navigationController?.pushViewController(WalletNew!, animated: true)
        }
    }
    
    @IBAction func actionChatWith(_ sender: UIButton) {
        //let string1 = whatsappmobile
        let string1 = "+919999603996"
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
            return 80
        } else if indexPath.row >= 1 && indexPath.row <= 4 {
            return 80
        } else if indexPath.row == 4 {
            return 200
        }
        else if indexPath.row == 5 {
            return 80
        }
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
        
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
            
            let totalPossibleOffset = CGFloat(arrbannerImages.count - 1) * (self.view.bounds.size.width - 20)
            if offSet == totalPossibleOffset
            {
                offSet = 0 // come back to the first image after the last image
            } else if arrbannerImages.count == 1 {
                offSet = 0
            } else {
                offSet += (self.view.bounds.size.width - 20)
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
        }
        
        else if indexPath.row >= 1 && indexPath.row <= 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardMainTVC", for: indexPath) as! DashBoardMainTVC
            cell.imageViewDashBoard.image = UIImage(named: propertyArrayImages1[indexPath.row - 1])
            cell.lblHeading.text = propertyArray1[indexPath.row - 1]
            if indexPath.row == 1 {
                cell.imageviewNew.isHidden = true
                cell.newView.isHidden = false
                cell.newView.isLeft = true
                cell.newView.isRift = false
            } else {
                cell.imageviewNew.isHidden = true
                cell.newView.isHidden = true
               


            }
            
            return cell
        }
        
        else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonsForQueryRemedyCell", for: indexPath) as! ButtonsForQueryRemedyCell
            cell.buttonQuery.addTarget(self, action: #selector(voiceQueryButton), for: .touchUpInside)
            cell.buttonRemedy.addTarget(self, action: #selector(askRemedy), for: .touchUpInside)
            
            return cell
        }
        else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardSecCell", for: indexPath) as! DashBoardSecCell
            cell.buttonZodiac.addTarget(self, action: #selector(horoscopeApiCallMethods), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row >= 0 && indexPath.row <= 4 {
            if  indexPath.row == 1// chat with astrologer
            {
                userCountry = ""
                userCountrycode = ""
                chatcallingFormmm = "Chat"
                let AstroChatList = self.storyboard?.instantiateViewController(withIdentifier: "AstroChatListVC")
                self.navigationController?.pushViewController(AstroChatList!, animated: true)
                AppEvents.logEvent(AppEvents.Name(rawValue: "chat"))

            }
            else if  indexPath.row == 2// talk to astrologer
            {
                userCountry = ""
                userCountrycode = ""
                chatcallingFormmm = "Calling"
                let AstroTalkList = self.storyboard?.instantiateViewController(withIdentifier: "AstroTalkListVC")
                self.navigationController?.pushViewController(AstroTalkList!, animated: true)
                AppEvents.logEvent(AppEvents.Name(rawValue: "call"))

            }
            else if  indexPath.row == 3
            {
                //QueryReportVC
                let QueryReport = self.storyboard?.instantiateViewController(withIdentifier: "QueryReportVC")
                self.navigationController?.pushViewController(QueryReport!, animated: true)
                AppEvents.logEvent(AppEvents.Name(rawValue: "query"))

            }
            else if  indexPath.row == 4// astroshop
            {
                let ProductCategory = self.storyboard?.instantiateViewController(withIdentifier: "ProductCategoryVC")
                self.navigationController?.pushViewController(ProductCategory!, animated: true)
                AppEvents.logEvent(AppEvents.Name(rawValue: "category"))

            }
            else if  indexPath.row == 0// astroshop
            {
                userCountry = ""
                userCountrycode = ""
                chatcallingFormmm = "Chat"
                let AstroChatList = self.storyboard?.instantiateViewController(withIdentifier: "AstroChatListVC")
                self.navigationController?.pushViewController(AstroChatList!, animated: true)
                AppEvents.logEvent(AppEvents.Name(rawValue: "chat"))

                
            }
        }  
    }
    
    @IBAction func voiceQueryButton(_ sender: UIButton) {
        //VoiceQuery
        let QueryReport = self.storyboard?.instantiateViewController(withIdentifier: "QueryReportVC") as! QueryReportVC
        QueryReport.particilarTabStr = .voice
        self.navigationController?.pushViewController(QueryReport, animated: true)
    }
    
    @IBAction func askRemedy(_ sender: UIButton) {
        let remedy = self.storyboard?.instantiateViewController(withIdentifier: "QueryReportVC") as! QueryReportVC
        remedy.particilarTabStr = .remedy
        self.navigationController?.pushViewController(remedy, animated: true)
        AppEvents.logEvent(AppEvents.Name(rawValue: "remedy"))

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
    @IBOutlet weak var labeOffer: UILabel!
    
    @IBOutlet weak var labelforOffer1: UILabel!
    @IBOutlet weak var viewOffer: WOWRibbonView!
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


