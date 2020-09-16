//
//  LoginModel.swift
//  BloomKart
//
//  Created by Kriscent on 16/12/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class LoginModel: NSObject
{
    
    var user_id,user_api_key,full_name,astro_call_status,Email,mobile,mobile_verified,user_image,wallet,rewards,referalcode:String
    
    var login_Status, status, isDualAuth, reporting, state_id:Bool
    
    class var sharedInstance: LoginModel {
        struct Static {
            static let instance: LoginModel = LoginModel()
        }
        return Static.instance
    }
    private override init(){
        self.user_id = ""
        self.full_name = ""
        self.Email = ""
        self.mobile = ""
        self.mobile_verified = ""
        self.user_image = ""
        self.wallet = ""
        self.rewards = ""
        self.referalcode = ""
        self.astro_call_status = ""
        self.user_api_key = ""
        
        
        
        self.status = false
        self.state_id = false
        self.isDualAuth = false
        self.reporting = false
        self.login_Status = false
        
    }
    
    func updateUserLoginDetails(lobjDict:NSDictionary) {
        
        print(lobjDict.count)
        
        if lobjDict.count > 0
        {
            let dict_Data = lobjDict["data"] as! NSDictionary
            print("dict_Data is:-",dict_Data)
            
            //          let user = dict_Data["user"] as! NSDictionary
            //          print("user is:-",user)
            
            
            self.login_Status = lobjDict.value(forKey: "response") as? Bool ?? false
            self.user_id = dict_Data.value(forKey: "user_uni_id") as? String ?? ""
            self.full_name = dict_Data.value(forKey: "username") as? String ?? ""
            self.Email = dict_Data.value(forKey: "email") as? String ?? ""
            self.mobile = dict_Data.value(forKey: "phone_number") as? String ?? ""
            self.mobile_verified = dict_Data.value(forKey: "mobile_verified") as? String ?? ""
            self.astro_call_status = dict_Data.value(forKey: "astro_call_status") as? String ?? ""
            self.user_api_key = dict_Data.value(forKey: "user_api_key") as? String ?? ""
            //self.user_image = dict_Data.value(forKey: "user_image") as? String ?? ""
            //self.wallet = dict_Data.value(forKey: "wallet") as? String ?? ""
            //self.rewards = dict_Data.value(forKey: "rewards") as? String ?? ""
            self.referalcode = dict_Data.value(forKey: "referral_code") as? String ?? ""
            
            
            print("full_name is:-",self.full_name)
            print("login_Status is:-",self.login_Status)
            
            
            
            
            
            //          //  self.login_Status = lobjDict.value(forKey: "Login_Status") as? Bool ?? false
            //            self.login_Status = lobjDict.value(forKey: "success") as? Bool ?? false
            //            self.login_Time = lobjDict.value(forKey: "Login_Time") as? String ?? ""
            //
            //            self.auth_Key = lobjDict.value(forKey: "Login_Time") as? String ?? ""
            //            self.message = lobjDict.value(forKey: "message") as? String ?? ""
            //
            //            self.auth_Key = user.value(forKey: "auth_key") as? String ?? ""
            //            self.first_Name = user.value(forKey: "first_name") as? String ?? ""
            //            self.last_Name = user.value(forKey: "last_name") as? String ?? ""
            //            self.Email = user.value(forKey: "email") as? String ?? ""
            //
            //            print(self.auth_Key)
            //
            //
            //            self.permissions_Update_Time = lobjDict.value(forKey: "Permissions_Update_Time") as? String ?? ""
            //            self.redirect = lobjDict.value(forKey: "Redirect") as? String ?? ""
            //            self.status = lobjDict.value(forKey: "success") as? Bool ?? false
            //
            //           self.active_index = lobjDict.value(forKey: "active_index") as? String ?? ""
            //
            //            self.alternate_mobile_number = lobjDict.value(forKey: "alternate_mobile_number") as? String ?? ""
            //            self.blood_group = lobjDict.value(forKey: "blood_group") as? String ?? ""
            //            self.city_id = lobjDict.value(forKey: "city_id") as? String ?? ""
            //            self.cost_center = lobjDict.value(forKey: "cost_center") as? String ?? ""
            //            self.created_on = lobjDict.value(forKey: "created_on") as? String ?? ""
            //            self.customer = lobjDict.value(forKey: "customer") as? String ?? ""
            //            self.customerId = lobjDict.value(forKey: "customerId") as? String ?? ""
            //
            //            if let value = lobjDict.value(forKey: "country_id") as? NSNumber
            //            {
            //                self.country_id = String(describing: value)
            //            }
            //            if let value = lobjDict.value(forKey: "designation") as? NSNumber
            //            {
            //                self.designation = String(describing: value)
            //            }
            //            self.dob = lobjDict.value(forKey: "dob") as? String ?? ""
            //
            //            self.employee_id = lobjDict.value(forKey: "employee_id") as? String ?? ""
            //            self.first_name = lobjDict.value(forKey: "first_name") as? String ?? ""
            //            self.full_name = lobjDict.value(forKey: "full_name") as? String ?? ""
            //
            //            if let value = lobjDict.value(forKey: "id") as? NSNumber {
            //                 self.l_id = String(describing: value)
            //            }
            //
            //            self.isDualAuth = lobjDict.value(forKey: "success") as? Bool ?? false
            //            self.isExtStaff = lobjDict.value(forKey: "isExtStaff") as? String ?? ""
            //            self.isFirstLogin = lobjDict.value(forKey: "isFirstLogin") as? String ?? ""
            //            self.isLdapUser = lobjDict.value(forKey: "isLdapUser") as? String ?? ""
            //            self.is_bcm_user = lobjDict.value(forKey: "is_bcm_user") as? String ?? ""
            //            self.key = lobjDict.value(forKey: "key") as? String ?? ""
            //
            //            self.last_name = lobjDict.value(forKey: "last_name") as? String ?? ""
            //
            //            if let value = lobjDict.value(forKey: "location_id") as? NSNumber
            //            {
            //                self.location_id = String(describing: value)
            //            }
            //            if let value = lobjDict.value(forKey: "orgmap_id") as? NSNumber
            //            {
            //                self.orgmap_id = String(describing: value)
            //            }
            //            self.nationality = lobjDict.value(forKey: "nationality") as? String ?? ""
            //            self.password = lobjDict.value(forKey: "password") as? String ?? ""
            //            self.personal_email = lobjDict.value(forKey: "personal_email") as? String ?? ""
            //            self.personal_mobile = lobjDict.value(forKey: "personal_mobile") as? String ?? ""
            //            self.pwd_exp_date = lobjDict.value(forKey: "pwd_exp_date") as? String ?? ""
            //            self.reporting = lobjDict.value(forKey: "reporting") as? Bool ?? false
            //            self.residential_address_1 = lobjDict.value(forKey: "residential_address_1") as? String ?? ""
            //            self.residential_address_2 = lobjDict.value(forKey: "residential_address_2") as? String ?? ""
            //            self.site = lobjDict.value(forKey: "site") as? String ?? ""
            //            self.state_id = lobjDict.value(forKey: "state_id") as? Bool ?? false
            //            self.lstr_Status = lobjDict.value(forKey: "status") as? String ?? ""
            //            self.updated_on = lobjDict.value(forKey: "updated_on") as? String ?? ""
            //
            //
            //
            //            self.user_id = lobjDict.value(forKey: "user_id") as? String ?? ""
            //            print(self.user_id)
            //            self.user_name = lobjDict.value(forKey: "user_name") as? String ?? ""
            //            self.work_email = lobjDict.value(forKey: "work_email") as? String ?? ""
            //            self.work_extension = lobjDict.value(forKey: "work_extension") as? String ?? ""
            //
            //            if let value = lobjDict.value(forKey: "version") as? NSNumber
            //            {
            //                self.version = String(describing: value)
            //            }
            //            if let value = lobjDict.value(forKey: "work_mobile") as? String
            //            {
            //                self.work_mobile = String(describing: value)
            //            }
            //            if let value = lobjDict.value(forKey: "work_phone") as? String
            //            {
            //                self.work_phone = String(describing: value)
            //            }
            
        }
        
    }
}
