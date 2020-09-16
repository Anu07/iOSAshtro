//
//  Validate.swift
//  AUTOBCM
//
//  Created by vishnu jangid on 08/02/18.
//  Copyright © 2018 brsoftech. All rights reserved.
//

import Foundation
import UIKit
import CRNotifications


extension String {
    
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    //Validate Shopping Amount
    var isAmount: Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    //Validate Vintage
    var isVintage: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
}

class Validate: NSObject {
    
    static let  shared =  Validate()
    var validation = Validation()
    var appColor = mainColor2
    
    func showMessage(message:String){
        CRNotifications.showNotification(textColor: .white, backgroundColor: UIColor().setRGBColors(R: 253.0, G: 148.0, B: 34.0, alpha: 1.0), image: UIImage(named: "ui"), title: kAppName, message: message, dismissDelay: 3)
    }
    
    //    class func isValidMobileNumber(testString:String) -> Bool
    //    {
    //        let teststring=testString.trimmingCharacters(in: NSCharacterSet.whitespaces)
    //        if teststring.length < 6 || teststring.length > 10{
    //            return false
    //        }
    //        let mobileRegex = "^([0-9]*)$"
    //
    //        let mobileTemp = NSPredicate(format:"SELF MATCHES %@", mobileRegex)
    //        return mobileTemp.evaluate(with: teststring)
    //    }
    
    //Validate login form
    func validateLogin(vc:LoginVC) -> Bool {
        if vc.self.Email == "" {
            self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
            return false
        }
//        else if vc.self.Password == ""
//        {
//            self.showMessage(message: Messages.PASSWORD_EMPTY.rawValue)
//            return false
//        }
            //        else if vc.self.City == ""
            //        {
            //            self.showMessage(message: Messages.CITY_EMPTY.rawValue)
            //            return false
            //        }
        else {
            return true
        }
    }
    
    //Validate rechargee form
    func validateRecharge(vc:RechargeVC) -> Bool {
        if vc.self.txt_Amount.text == "" {
            self.showMessage(message: Messages.PHONE_AMOUNT.rawValue)
            return false
        }
            
        else {
            return true
        }
    }
    
    
    //Validate login form
    func validatechatform(vc:ChatFormVC) -> Bool {
        if vc.self.ProfileuserName == "" {
            self.showMessage(message: Messages.NAME_EMPTY.rawValue)
            return false
        }
        else if vc.self.date_Selectdate == ""
        {
            self.showMessage(message: Messages.PHONE_DOB.rawValue)
            return false
        }
        else if vc.self.malefemale == ""
        {
            self.showMessage(message: Messages.PHONE_GENDER.rawValue)
            return false
        }
        else if vc.self.Pob == ""
        {
            self.showMessage(message: Messages.PHONE_POB.rawValue)
            return false
        }
            
        else if vc.self.ProblemArea == ""
        {
            self.showMessage(message: Messages.PHONE_ProblemArea.rawValue)
            return false
        }
            
        else if vc.self.Timmeee == ""
        {
            self.showMessage(message: Messages.PHONE_TIME.rawValue)
            return false
        }
            //            else if vc.self.Price == ""
            //            {
            //                self.showMessage(message: Messages.PHONE_PRICE.rawValue)
            //                return false
            //            }
//        else if vc.self.Locationnn == ""
//        {
//            self.showMessage(message: Messages.PHONE_LOCATION.rawValue)
//            return false
//        }
            
        else {
            return true
        }
    }
    
    
    var Subject = ""
    var Personname = ""
    var Email = ""
    var MopbileNumber = ""
    var Message = ""
    
        //Validate login form
            func validatenquiryyyform(vc:EnquiryShopVC) -> Bool {
                if vc.self.Subject == "" {
                    self.showMessage(message: Messages.SUBJECT_EMPTY.rawValue)
                    return false
                }
                else if vc.self.Personname == ""
                {
                    self.showMessage(message: Messages.NAME_EMPTY.rawValue)
                    return false
                }
                else if vc.self.Email == ""
                {
                    self.showMessage(message: Messages.EMAIL_EMPTY.rawValue)
                    return false
                }
                else if vc.self.MopbileNumber == ""
                {
                    self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
                    return false
                }
                    
                else if vc.self.Message == ""
                {
                    self.showMessage(message: Messages.ENQUIRY_EMPTY.rawValue)
                    return false
                }
                    
                else {
                    return true
                }
            }
    
        //Validate Query form
        func validatequeryform(vc:QueryReportVC) -> Bool {
            if vc.self.ProfileuserName == "" {
                self.showMessage(message: Messages.NAME_EMPTY.rawValue)
                return false
            }
            else if vc.self.Email == ""
            {
                self.showMessage(message: Messages.EMAIL_EMPTY.rawValue)
                return false
            }
            else if vc.self.Mobilenumber == ""
            {
                self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
                return false
            }
            else if vc.self.date_Selectdate == ""
            {
                self.showMessage(message: Messages.PHONE_DOB.rawValue)
                return false
            }
                
            else if vc.self.Timmeee == ""
            {
                self.showMessage(message: Messages.PHONE_TIME.rawValue)
                return false
            }
                
            else if vc.self.Placebirth == ""
            {
                self.showMessage(message: Messages.PHONE_BIRTH.rawValue)
                return false
            }
            
            else if vc.self.Enquiry == "Enter Your Query & Requirement"
           {
               self.showMessage(message: Messages.ENQUIRY_EMPTY.rawValue)
               return false
           }
                else if vc.self.Enquiry == ""
                {
                    self.showMessage(message: Messages.ENQUIRY_EMPTY.rawValue)
                    return false
                }
                
                
                //            else if vc.self.Price == ""
                //            {
                //                self.showMessage(message: Messages.PHONE_PRICE.rawValue)
                //                return false
                //            }
    //        else if vc.self.Locationnn == ""
    //        {
    //            self.showMessage(message: Messages.PHONE_LOCATION.rawValue)
    //            return false
    //        }
                
            else {
                return true
            }
        }
         func validateReporform(vc:QueryReportVC) -> Bool {
            if vc.self.ProfileuserName1 == "" {
                self.showMessage(message: Messages.NAME_EMPTY.rawValue)
                return false
            }
            else if vc.self.Email1 == ""
            {
                self.showMessage(message: Messages.EMAIL_EMPTY.rawValue)
                return false
            }
            else if vc.self.Mobilenumber1 == ""
            {
                self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
                return false
            }
            else if vc.self.Reportname == ""
            {
                self.showMessage(message: Messages.PHONE_REPORTNAME.rawValue)
                return false
            }
            else if vc.self.Message == "Enter Message"
            {
                self.showMessage(message: Messages.MESSAGE_EMPTY.rawValue)
                return false
            }
            else if vc.self.Message == ""
            {
                self.showMessage(message: Messages.MESSAGE_EMPTY.rawValue)
                return false
            }
                
            else {
                return true
            }
    }
    //Validate Chnage password form
    func validateChangePassword(vc:ChangePassVC) -> Bool {
        if vc.self.old == "" {
            self.showMessage(message: Messages.OLD_PASSWORD_EMPTY.rawValue)
            return false
        }else if vc.self.new == "" {
            self.showMessage(message: Messages.NEW_PASSWORD_EMPTY.rawValue)
            return false
        }else if vc.self.confirm == "" {
            self.showMessage(message: Messages.CONFIRM_PASSWORD_EMPTY.rawValue)
            return false
        }else if !validation.PasswordAndConfirmPasswordMatch(txtfieldone: vc.new, secondValue: vc.confirm) {
            self.showMessage(message: Messages.PASSWORD_DIFFERENT.rawValue)
            return false
        }else {
            return true
        }
    }
    
    //Validate popup form
    func validatepop(vc:PopUpChatcall) -> Bool {
        if vc.self.postdob == "" {
            self.showMessage(message: Messages.DATE_EMPTY.rawValue)
            return false
        }else {
            return true
        }
    }
    
    //Validate popupCHT form
    func validatepopCHAT(vc:PopUPChatVC) -> Bool {
        if vc.self.postdob == "" {
            self.showMessage(message: Messages.DATE_EMPTY.rawValue)
            return false
        }else {
            return true
        }
    }
    
    
    //    "next_follow_date":"\(self.postdob)",
    //    "description":"\(txt_description.text ?? "nil"))",
    //Validate prescription Upload
    
    //
    //    //Validate timeslot form
    //    func validateTimeslot(vc:TimeSlotVC) -> Bool {
    //        if vc.self.DoctorDatevalidation == "" {
    //            self.showMessage(message: Messages.PHONE_DATE.rawValue)
    //            return false
    //        }else if vc.self.DoctorTimevalidation == "" {
    //            self.showMessage(message: Messages.PHONE_TIME.rawValue)
    //            return false
    //        }else {
    //            return true
    //        }
    //    }
    //
    //Validate Forgot password form
    func validateForgotPassword(vc:ForgotVC) -> Bool {
        if vc.self.Email == ""
        {
            self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
            return false
        }
            
        else {
            return true
        }
    }
    
    //Validate Registation otp form
    func validateRegistationotp(vc:RegistrationotpVC) -> Bool {
        if vc.self.Email == ""
        {
            self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
            return false
        }
            
        else {
            return true
        }
    }
    
    //Validate Forgot password form
    func validateforgetpassword(vc:ForgetVC) -> Bool {
        if vc.self.txt_otp.text == ""
        {
            self.showMessage(message: Messages.EMAIL_EMPTY.rawValue)
            return false
        }
            
        else
        {
            return true
        }
    }
    //Validate Chnage password form
    
    //
    //Validate Register form
    func validateRegistration(vc:SignupVC) -> Bool {
        if vc.self.SignupCountrycode == ""
        {
            self.showMessage(message: Messages.PHONE_COUNTRY.rawValue)
            return false
        }
        else if vc.self.MobileNumber == ""
        {
            self.showMessage(message: Messages.PHONE_EMPTY.rawValue)
            return false
        }
        else if vc.self.referalcode == ""
        {
            self.showMessage(message: Messages.PHONE_OTP.rawValue)
            return false
        }
        if vc.self.Name == ""
        {
            self.showMessage(message: Messages.NAME_EMPTY.rawValue)
            return false
        }
        
        else if vc.self.Email == ""
        {
            self.showMessage(message: Messages.EMAIL_EMPTY.rawValue)
            return false
        }
       // guard ((Email.isValidEmail()))else
        else if !vc.self.Email.isValidEmail()
        {
            
            self.showMessage(message: Messages.VALIDEMAIL_EMPTY.rawValue)
            return false
            
        }
        else if vc.privacyterms == ""
        {
            self.showMessage(message: Messages.TERMS_CONDITION.rawValue)
            return false
        }
            
        else {
            return true
        }
    }
    
    class func isEntercharacter(testString:String) -> Bool {
        let emailRegEx = "([a-zA-Z]*)"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testString)
    }
}
