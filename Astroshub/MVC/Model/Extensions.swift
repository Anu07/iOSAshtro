//
//  Extensions.swift
//  SearchDoctor
//
//  Created by Kriscent on 11/09/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import Foundation
import UIKit
import FAPanels
import Alamofire


extension UIViewController {
    
    func checkPaymentGatewayAlert(isStripe:Bool) -> Bool{
        
        if isStripe {
            
            if CurrentLocation == "India" {
                let message = "Stripe is accessible outside of India only"
                let refreshAlert = UIAlertController(title: "AstroShubh", message: message, preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                    {
                        (action: UIAlertAction!) in
                        self.dismiss(animated: true, completion: nil)
                }))
                self.present(refreshAlert, animated: true, completion: nil)
                return false
            }else{
                return true
            }
        } else {
            if CurrentLocation != "India" {
                let message = "Razor pay is not available outside India"
                let refreshAlert = UIAlertController(title: "AstroShubh", message: message, preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                    {
                        (action: UIAlertAction!) in
                        self.dismiss(animated: true, completion: nil)
                }))
                self.present(refreshAlert, animated: true, completion: nil)
                return false
            }else{
                return true
            }
            
        }
        
    }
    
    func moveTologinVC() {
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func PerformActionIfLogin(changeMessage:Bool = false) -> Bool {
        if let _ = UserDefaults.standard.value(forKey: "isUserData") as? Data {
            return true
        } else {
            let message = changeMessage ? "Please login to continue or you can have directly contact with \(mobNum)" : "Please login to continue"
            let refreshAlert = UIAlertController(title: "AstroShubh", message: message, preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                {
                    (action: UIAlertAction!) in
                    self.moveTologinVC()
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:
                {
                    (action: UIAlertAction!) in
                    refreshAlert .dismiss(animated: true, completion: nil)
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
        return false
    }
}


//MARK:- For UIView

extension UIView {
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    func moveToLoginVC() {
        
    }
    
    
}


//MARK:- Colors

class Colors {
    let colorTop = UIColor(red: 192.0/255.0, green: 38.0/255.0, blue: 42.0/255.0, alpha: 1.0)
    let colorBottom = UIColor(red: 35.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1.0)
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.5, 1.0]
    }
}


extension UIColor {
    
    func setGradient(locations:[NSNumber], colors:[Any] ) -> CAGradientLayer{
        
        let backgroundLayer = CAGradientLayer()
        
        backgroundLayer.colors = colors
        backgroundLayer.locations = locations
        
        return  backgroundLayer
    }
    
    func setRGBColors(R:CGFloat, G:CGFloat, B:CGFloat, alpha:CGFloat) -> UIColor{
        return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: alpha)
    }
}



extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 10, width: 30, height: 30))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 50, height: 50))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}


extension UIViewController {
    //  Get Current Active Panel
    var panel: FAPanelController? {
        
        get{
            var iter:UIViewController? = self.parent
            
            while (iter != nil) {
                if iter is FAPanelController {
                    return iter as? FAPanelController
                }else if (iter?.parent != nil && iter?.parent != iter) {
                    iter = iter?.parent
                }else {
                    iter = nil
                }
            }
            return nil
        }
    }
}
extension UITableView {
    
    public func initilization(_ cellName: String,_ rowHight : CGFloat = 80) {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = rowHight
        self.autoLayoutRegisterNib(nibName: cellName)
        self.tableFooterView = UIView()
    }
    
    func autoLayoutRegisterNib(nibName:String?){
        if let nibName = nibName {
            self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
    }
}


public extension Dictionary {
    public   func toJson() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            return String(data: jsonData, encoding: String.Encoding.ascii)!
            
        } catch {
            return error.localizedDescription
        }
    }
    
}
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}


extension JSONDecoder {
    func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(response.error!)
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}
