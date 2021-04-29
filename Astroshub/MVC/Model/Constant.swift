//
//  Constant.swift
//  SearchDoctor
//
//  Created by Kriscent on 11/09/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let BASE_URL =
//"https://www.astroshubh.in/staging/api/"
    "https://www.astroshubh.in/api/"
    static let BASE_URLForImage =
"https://www.astroshubh.in/"
    static let Connection = "No Internet Connection"
    static var devicetoken = NSData()
    static var DeviceTokenString = NSString()
    static var IS_IPAD = UIUserInterfaceIdiom.pad
    static var IS_IPHONE = UIUserInterfaceIdiom.phone
    static var SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static var SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let deviceId = UIDevice.current.identifierForVendor!.uuidString
    static  var BORDER_COLOR = UIColor.init(red: 220.0, green: 220.0, blue: 220.0, alpha: 1.0).cgColor
    static  var BORDER_WIDTH=1.5
    static  var cornerRadius=5.0
    static let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
    @objc enum RECORDING_STATE: Int {
        case RECORDING_STOP = 0 , RECORDING_PLAY = 1
    }
    let mainColor1 =  UIColor().setRGBColors(R: 87.0, G: 217.0, B: 185.0, alpha: 1.0)
    let mainColor2 =  UIColor().setRGBColors(R: 70.0, G: 180.0, B: 205.0, alpha: 1.0)
    let mainColor3 =  UIColor().setRGBColors(R: 29.0, G: 122.0, B: 158.0, alpha: 1.0)
    let kAppColor  =  UIColor().setRGBColors(R: 39.0, G: 138.0, B: 163.0, alpha: 1.0)
}



//MARK:- Service URLs

//local
let kServiceUrl = "http://192.168.0.108/searchdoctor/api/";

//enums
public enum MethodName:String {
    case APPTYPE                      = "ios"
    case APPVERSION                   = "1.0"
    case WELCOME                      = "welcome"
    case LOGINOTPSEND                 = "loginOtpSend"
    case CUSTOMERLOGIN                = "customerLogin_new"
    case BANNER                       = "banner"
    case HOROSCOPE                    = "horoscope"
    case RECHARGE                     = "recharge"
    case ViewProductEnquiryShop                    = "viewProductEnquiryShop"
    case addReviews = "addReviews"
    
    
    case LOGIN                        = "userLogin"
    case SENDREGISTRATIONOTP          = "sendRegistrationOtp"
    case UPDATECALLSTATUS             = "updateCallStatus"
    case UPDATECHATSTATUS             = "updateChatStatus"
    case GETPROFILEDATA               = "getAstrologerProfileData"
    case USEREGISTRATION              = "userRegistration_new"
    case BLOG                         = "blog"
    case GETASTROLOGERS               = "getAstrologers"
    case GETUSERPROFILEDATA           = "getUserProfileData"
    case GETZODIACSIGN                = "getZodiacSign"
    
    case REGISTER       = "astrologerRegistration"
    case FORGOT_PASS    = "sendforgotPasswordOtp"
    case CHECK_OTP      = "checkOtp"
    case RESEND_OTP     = "resendOtp"
    case RESET_PASS     = "forgotPassword"
    case CHANGE_PASS    = "changePassword"
    
    
    case GET_STATE      = "states"
    case GET_CITY       = "cityByStateId"
    case GET_CAT        = "categories"
    case GET_PROFILE    = "users/getprofile"
    case getParnsavli  = "getPrashnavali"
    case getMytras = "getMantra"
    case coupon = "getCoupons"
    case fbSession = "getFbSessionList"

}

//MARK:- App commons
let kAppName             = "Astroshubh"
let kApplicationDelegate = UIApplication.shared.delegate as! AppDelegate
var kScreenSize          = UIScreen.main.bounds.size
let kCGSizeZero          = CGSize(width: 0, height: 0);
var kWindow              = UIWindow(frame: UIScreen.main.bounds)
let kUserDefault         = UserDefaults.standard


let mainColor1 =  UIColor().setRGBColors(R: 246.0, G: 197.0, B: 0.0, alpha: 1.0)
let mainColor2 =  UIColor().setRGBColors(R: 246.0, G: 197.0, B: 0.0, alpha: 1.0)
let mainColor3 =  UIColor().setRGBColors(R: 246.0, G: 197.0, B: 0.0, alpha: 1.0)
let kAppColor  =  UIColor().setRGBColors(R: 39.0, G: 138.0, B: 163.0, alpha: 1.0)

let mainColor5 =  UIColor().setRGBColors(R: 202.0, G: 0, B: 254.0, alpha: 1.0)
let mainColor6 =  UIColor().setRGBColors(R: 140.0, G: 0.0, B: 236.0, alpha: 1.0)

let FooterColorBackgroud =  UIColor().setRGBColors(R: 64.0, G: 164.0, B: 62.0, alpha: 1.0)


//MARK:- Controller's arrays
// --------- Go through screen constant values ------------
var IMAGES = [#imageLiteral(resourceName: "icon_doctor"), #imageLiteral(resourceName: "icon_medicine"),#imageLiteral(resourceName: "icon_appointment")]
let TITLES_NAME = ["DOCTORS", "MEDICINE", "APPOINTMENT"]
let DESCRIPTION = ["Find expert doctors for particular problem on one tap",
                   "Alopathic, Ayurvedic and all type of medicines can bought from here",
                   "Book appointment and get best treatment on one tap"]



//-------Cell Identifiers----

let kDocListCell = "DoctorTableViewCell"
let kDocInfoDetailCell  = "DoctorInfoTableViewCell"
let kReviewCell = "ReviewTableViewCell"



//MARK:- enums Common

enum UserDefaultKey : String {
    case IS_LOGGED_IN       = "isLoggedIn"
    case FIRST_TIME_LOAD    = "first_time_load"
    case DEVICE_TOKEN       = "deviceToken"
    case USER_INFO          = "login_userinfo"
    case IS_VERIFIED        = "isVerified"
    case THEME_COLOR        = "theme_color_hex"
    case BOOK_SERVICE       = "BOOK_SERVICE"
}


let kIOS = "ios"
let kAppVersion = "1.0"
let appDelegate = UIApplication.shared.delegate as! AppDelegate

let mobNum = "+91 9999-122-091 "
