//
//  Common.swift
//  SearchDoctor
//
//  Created by Kriscent on 16/09/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import AVKit
import AVFoundation
import CoreLocation

class Common: NSObject {
    
    
    static func setHeader() -> [String : String] {
        var dic = [
            "Accept" : "application/json",
            "Content-Type" : "application/json",
        ];
        //        if let authToken = AppDefaults.shared.getUserInfo()?.token {
        //            dic["Authorization"] = "Bearer \(authToken)";
        //            print("Authorization Bearer \(authToken)")
        //        }
        //dic["Version-Code"] = "1.0"
        //  dic["Device-Type"] = "iOS"
        
        return dic;
    }
    
    //    static func getDefaultParams(params:[String:Any])-> [String:Any]{
    //        var _params = params;
    //        _params["app_type"] = "ios"
    //        _params["app_version"] = "1.0"
    //        _params["user_token"] = Common.getDeviceToken()
    //        if let info = AppDefaults.shared.getUserInfo()  {
    //            _params["user_id"] = info.userId ?? ""
    //            _params["user_api_key"] = info.apiKey ?? ""
    //        }
    //        
    //        return _params;
    //    }
    
    static func getDeviceToken() -> String {
        
        return kUserDefault.value(forKey: UserDefaultKey.DEVICE_TOKEN.rawValue) as? String ?? "ios123"
    }
    
    static func setDeviceToken(token:String){
        kUserDefault.set(token , forKey: UserDefaultKey.DEVICE_TOKEN.rawValue)
    }
    
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        if(defaultRouteReachability == nil){
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    //Get current presenting top controller
    static func getTopViewController() -> UIViewController{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
            
            // topController should now be your topmost view controller
        }
        return UIViewController()
    }
    
    
    static func showAlert(alertMessage: String?, alertButtons: [String]?, callback: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: kAppName, message: alertMessage, preferredStyle:.alert)
        
        for item in alertButtons! {
            let alertButton = UIAlertAction(title: item, style: .default, handler: { (action) -> Void in
                callback( item);
            })
            alertController.addAction(alertButton)
        }
        _ = false
        
        Common.getTopViewController().present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert( alertMessage: String?, alertButtons: [String]?,  alertStyle: UIAlertController.Style?, callback: @escaping ( String?) -> Void) {
        let alertController = UIAlertController(title: kAppName, message: alertMessage, preferredStyle: alertStyle ?? .alert)
        
        for item in alertButtons! {
            let alertButton = UIAlertAction(title: item, style: .default, handler: { (action) -> Void in
                callback( item);
            })
            alertController.addAction(alertButton)
        }
        
        if alertStyle == .actionSheet {
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelButton)
        }
        Common.getTopViewController().present(alertController, animated: true, completion: nil)
    }
    
    static func showTextAlert( alertMessage: String?, alertButton: String?,  alertStyle: UIAlertController.Style?, callback: @escaping ( String?) -> Void) {
        let alertController = UIAlertController(title: kAppName, message: alertMessage, preferredStyle: alertStyle ?? .alert)
        alertController.addTextField { (textField) in
            textField.text = ""
        }
        
        let alertButton = UIAlertAction(title: alertButton, style: .default, handler: { (action) -> Void in
            let textField = alertController.textFields![0]
            callback( textField.text!);
        })
        alertController.addAction(alertButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        Common.getTopViewController().present(alertController, animated: true, completion: nil)
    }
    
    //decode codable
    static func jsonData(obj:Any) -> Data{
        let jsonData = try? JSONSerialization.data(withJSONObject: obj, options: [])
        let reqJSONStr = String(data: jsonData!, encoding: .utf8)
        let data = reqJSONStr?.data(using: .utf8)
        
        return data!
    }
    
    //Set gradient color
    static func setGradient(frame:CGRect, colors:[Any], startPoint: CGPoint, endPoint:CGPoint, targetView:UIView){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        targetView.layer.addSublayer(gradientLayer)
    }
    
}
