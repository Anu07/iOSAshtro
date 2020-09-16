//
//  AppDefaults.swift
//  Created by ds on 10/21/16.
//  Copyright © 2016 Dots. All rights reserved.
//

import UIKit

class AppDefaults: NSObject {
    
    static let shared: AppDefaults = { AppDefaults() }()
    
    private let defaults:UserDefaults = UserDefaults.standard;
    
    // var userModel:LoginDto?
    
    //MARK: - Manage Other info
    
    func save(object:Any, key:String){
        defaults.setValue(object, forKeyPath: key);
        defaults.synchronize();
    }
    
    func get(key:String) -> Any? {
        return defaults.object(forKey: key)
    }
    
    func delete(key:String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize();
    }
    
    
    //MARK: - Manage logged in user info
    
    // MARK:- PREFERANCE
    //    func getUserInfo() -> LoginDto? {
    //        if let savedPerson = get(key: UserDefaultKey.USER_INFO.rawValue) as? Data {
    //            let decoder = JSONDecoder()
    //            if let loginInfo = try? decoder.decode(LoginDto.self, from: savedPerson) {
    //                return loginInfo
    //            }
    //        }
    //        return nil
    //    }
    //
    //    func saveUserData(loginDetail:LoginDto){
    //        let encoder = JSONEncoder()
    //        if let encoded = try? encoder.encode(loginDetail) {
    //            save(object: encoded, key: UserDefaultKey.USER_INFO.rawValue)
    //        }
    //    }
    
    //    func saveBookingData(bookingDetail:BookingModel){
    //        let encoder = JSONEncoder()
    //        if let encoded = try? encoder.encode(bookingDetail) {
    //            save(object: encoded, key: UserDefaultKey.BOOK_SERVICE.rawValue)
    //        }
    //    }
    
    //    func deleteLoginUser(){
    //        self.delete(key: UserDefaultKey.USER_INFO.rawValue)
    //        self.delete(key: UserDefaultKey.IS_LOGGED_IN.rawValue)
    //        self.userModel = nil;
    //    }
    
    func setThemeColor(colorHex: String){
        defaults.setValue(colorHex, forKeyPath: UserDefaultKey.THEME_COLOR.rawValue);
        defaults.synchronize();
    }
    
    func getThemeColor() -> String {
        var haxColor = "01ced2"//FFA500 01ced2
        if (defaults.value(forKey: UserDefaultKey.THEME_COLOR.rawValue) != nil)
        {
            haxColor = defaults.object(forKey: UserDefaultKey.THEME_COLOR.rawValue) as! String
        }
        return haxColor
    }
}
