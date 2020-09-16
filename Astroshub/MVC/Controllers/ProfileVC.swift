//
//  ProfileVC.swift
//  Astroshub
//
//  Created by Kriscent on 08/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import iOSDropDown
class ProfileVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate ,
ImageCropViewControllerDelegate, WWCalendarTimeSelectorProtocol {
    var arrZodiac = [[String:Any]]()
    var NameArray = NSArray()
    private var viewModels: [DPArrowMenuViewModel] = []
    @IBOutlet weak var btn_Updateprofile: ZFRippleButton!
    @IBOutlet var tbl_profile: UITableView!
    @IBOutlet weak var view_top: UIView!
    fileprivate var singleDate: Date = Date()
    var malefemale = "63"
    fileprivate var multipleDates: [Date] = []
    var date_Selectdate = ""
    var postdob = ""
    var image = UIImage()
    var imagecompress = UIImage()
    var selectedImage:UIImage!
    var Profileimagechange = ""
    var imagePicker = UIImagePickerController()
    
    var dobandtimeclick = ""
    
    
    var ProfileuserName = ""
    var ProfileuserLastName = ""
    
    var Profilestate = ""
    var Profilecity = ""
    var Profilecountry = ""
    
    var Astrofees = ""
    var AstroExp = ""
    var AstroBankname = ""
    var ProfileuserDescription = ""
    var ProfileuserEmail = ""
    var ProfileuserMobilenumber = ""
    var CustomerTimebirth = ""
    var Zodiacsign = ""
    var ZodiacsignID = ""
    var ZodiacsignImage = ""
    var Age = ""
    
    var ProfileLicencedetails = ""
    var ProfileBiography = ""
    var ProfileuserClinicname = ""
    
    
    var astroskills = ""
    var astropancard = ""
    var astroposition = ""
    var ProfileAddress = ""
    var ProfilePincode = ""
    var ProfileAlternativeNumber = ""
    
    
    var LanguageArray = NSArray()
    var AstrocatArray = NSArray()
    var astrologer_highestdegree = ""
    var astrologer_acc_no = ""
    var astrologer_acc_type = ""
    var astrologer_ifsc_code = ""
    var astrologer_acc_name = ""
    var astrologer_short_biography = ""
    var astrologer_online_portal = ""
    

    var stateArray = NSArray()
    var stateNameArray = [String]()
    var stateIdArray = [Int]()
    
    
    var cityArray = NSArray()
    var cityNameArray = [String]()
    var cityIdArray = [Int]()
    
    
    var countryArray = NSArray()
    var countryNameArray = [String]()
    var countryIdArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        //view_top.layer.cornerRadius = 5.0
        
        self.func_GetProfiledata()
        self.func_GetZodiacSign()
        self.func_GetStates()
        self.func_GetCOUNTRY()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
        let btnayer = CAGradientLayer()
        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: btn_Updateprofile.frame.size.width, height: btn_Updateprofile.frame.size.height)
        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        btn_Updateprofile.layer.insertSublayer(btnayer, at: 1)
        
        self.tbl_profile.reloadData()
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        //delegate method
        if (textField.tag==1)
        {
            ProfileuserName=textField.text!
            
        }
            
        else if (textField.tag==2)
        {
            
            Age=textField.text!
        }
        else if (textField.tag==3)
        {
            
            ProfileAddress=textField.text!
        }
        else if (textField.tag==4)
        {
            
            ProfilePincode=textField.text!
        }
        else if (textField.tag==5)
        {
            
            Profilestate=textField.text!
        }
        else if (textField.tag==6)
        {
            
            Profilecity=textField.text!
        }
        else if (textField.tag==7)
        {
            
            Profilecountry=textField.text!
        }
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        
        if (textField.tag==1)
        {
            ProfileuserName=textField.text!
            
        }
            
        else if (textField.tag==2)
        {
            
            Age=textField.text!
        }
        else if (textField.tag==3)
        {
            
            ProfileAddress=textField.text!
        }
        else if (textField.tag==4)
        {
            
            ProfilePincode=textField.text!
        }
        else if (textField.tag==5)
        {
            
            Profilestate=textField.text!
        }
        else if (textField.tag==6)
        {
            
            Profilecity=textField.text!
        }
        else if (textField.tag==7)
        {
            
            Profilecountry=textField.text!
        }
        // return YES;
        //textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        //   self.date_Selectdate = date.stringFromFormat("yyyy-MM-dd")
        
        if dobandtimeclick == "dob"
        {
            let dob = date.stringFromFormat("yyyy-MM-dd")
            self.date_Selectdate = self.formattedDateFromString(dateString: dob, withFormat: "dd MMM yyyy")!
            self.postdob = date.stringFromFormat("yyyy/MM/dd")
            self.tbl_profile.reloadData()
        }
        else
        {
            let time = date.stringFromFormat("hh:mm a")
            self.CustomerTimebirth = time
            self.tbl_profile.reloadData()
        }
        print(self.date_Selectdate)
        
        // dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        if let date = dates.first {
            singleDate = date
            //  dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
        }
        else {
            // dateLabel.text = "No Date Selected"
        }
        multipleDates = dates
    }
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //imgProfile.image = pickedImage
            //imgProfile.contentMode = .scaleAspectFill
            
            
            
            
            image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
            
            print(image.size)
            
            // self.imgData = Common.compressImage(image: imgView.image!) as! Data
            
            if image != nil {
                var controller = ImageCropViewController(image: pickedImage)
                controller?.delegate = self
                controller?.blurredBackground = true
                
                if let controller = controller {
                    navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
    }
    func imageCropViewControllerSuccess(_ controller: UIViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        
        Profileimagechange = "Profileimagechange"
        selectedImage = croppedImage;
        image = selectedImage
        tbl_profile.reloadData()
        //
        self.func_EditProfile()
        //  imgProfile.image = croppedImage;
        // self.imgData = Common.compressImage(image: imgProfile.image!) as? Data ?? Data()
        self.navigationController?.popViewController(animated: true)
    }
    func imageCropViewControllerDidCancel(_ controller: UIViewController!) {
        // imgProfile.image = selectedImage
        self.navigationController?.popViewController(animated: true)
    }
    func compressImage(image: UIImage) -> UIImage
    {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 1590.0
        let maxWidth: Float = 955.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        
        let rect = CGRect (x: 0.0, y: 0.0, width: Double(actualWidth), height: Double(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_GetProfiledata() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
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
                                            self.ProfileuserEmail = personaldetailss["email"] as! String
                                            //  self.Astrofees = personaldetailss["astrologers_fees"] as! String
                                            
                                            self.malefemale = personaldetailss["customer_gender"] as! String
                                            let dob = personaldetailss["customer_dob"] as! String
                                            if dob != ""
                                            {
                                                self.date_Selectdate = self.formattedDateFromString(dateString: dob, withFormat: "dd MMM yyyy")!
                                            }
                                            
                                            
                                            
                                            self.postdob = personaldetailss["customer_dob"] as! String
                                            userState = personaldetailss["user_state"] as! String
                                            userCity = personaldetailss["user_city"] as! String
                                            userStateId = personaldetailss["customer_state"] as! String
                                            userCountry = personaldetailss["customer_country_name"] as! String
                                            userCountrycode = personaldetailss["customer_country_id"] as! String
                                            
                                             self.Profilestate = personaldetailss["user_state"] as! String
                                             self.Profilecity = personaldetailss["user_city"] as! String
                                             self.Profilecountry = personaldetailss["user_city"] as! String
                                            
                                            if userStateId != ""
                                            {
                                                self.func_GetCity()
                                            }
                                            userCityId = personaldetailss["customer_city"] as! String
                                            self.ProfileuserMobilenumber = personaldetailss["phone_number"] as! String
                                            self.CustomerTimebirth = personaldetailss["customer_time_birth"] as! String
                                            self.Zodiacsign = personaldetailss["customer_zodiac_sign"] as! String
                                            
                                            self.ZodiacsignID = personaldetailss["customer_zodiac_signId"] as! String
                                            self.Age = personaldetailss["customer_age"] as! String
                                            self.ProfileAddress = personaldetailss["customer_address"] as! String
                                            
                                            
                                            
                                            UserImageurl = personaldetailss["customer_image_url"] as! String
                                            
                                            self.tbl_profile.reloadData()
                                            
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
    
    
    func func_GetZodiacSign() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue]
        
        print(setparameters)
        // AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.GETZODIACSIGN.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            self.arrZodiac =  (tempDict["data"] as? [[String:Any]])!
                                            self.NameArray =  (tempDict["data"] as? NSArray)!
                                            
                                            
                                            for j in 0..<self.NameArray.count
                                            {
                                                
                                                let dict2 = self.NameArray[j] as! NSDictionary
                                                let name = dict2["name"] as! String
                                                let iddd = dict2["id"] as! String
                                                // let idddD = Int(iddd)
                                                let imageee = dict2["image"] as! String
                                                
                                                let arrowMenuViewModel0 = DPArrowMenuViewModel(title: name ,imageName: imageee,id: iddd)
                                                
                                                self.viewModels.append(arrowMenuViewModel0)
                                                
                                                
                                                
                                            }
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
    
    
    func func_EditProfile()
    {
        
        
        let parameters = [
            
            "app_type":"\("ios")",
            "app_version":"\("1.0")",
            "user_id":"\(user_id)",
            "user_api_key":"\(user_apikey)",
        ]
        
        print(parameters)
        
        let string1 = Constants.BASE_URL
        let string2 = "updateUserImage"
        
        
        _ = "\(string1) \(string2)"
        let url = string1+string2
        print("APPEND STRING1:\(url)")
        
        
        imagecompress = compressImage(image:self.image)
        //imagecompress = imageForPublish
        let imgData =  imagecompress.jpegData(compressionQuality: 0.1)!
        print(imgData)
        
        
        let headers = [
            "Content-Type": "application/json"
            
        ]
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            
            
            for (key, value) in parameters
            {
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            MultipartFormData.append(imgData, withName: "customer_image",fileName: "file.jpg", mimeType: "image/jpg")
            
        }, to: url, method: .post, headers: headers, encodingCompletion: { (result) in
            switch result {
                
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler:
                    {
                        (dataResponse) in
                        print(dataResponse)
                        print(dataResponse.result.error ?? "")
                        
                        do
                        {
                            let jsonDict = try JSONSerialization .jsonObject(with: dataResponse.data!, options: .allowFragments) as! [String:Any]
                            print("jsonDict is:-",jsonDict)
                            
                            let success=jsonDict["response"] as!   Int
                            let message=jsonDict["msg"] as!   String
                            
                            if success==1
                            {
                                let dict_Data = jsonDict["data"] as! [String:Any]
                                print("dict_Data is:- ",dict_Data)
                                
                                UserImageurl = dict_Data["user_image_url"] as! String
                                print("email:-",UserImageurl)
                                
                                DispatchQueue.main.async()
                                    {
                                        self.func_GetProfiledata()
                                        self.tbl_profile.reloadData()
                                        self.Profileimagechange = ""
                                        
                                }
                                
                            }
                            else
                            {
                                
                                DispatchQueue.main.async()
                                    {
                                        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                                        self.present(alert, animated: true, completion: nil)
                                        
                                        // change to desired number of seconds (in this case 5 seconds)
                                        let when = DispatchTime.now() + 2
                                        DispatchQueue.main.asyncAfter(deadline: when){
                                            // your code with delay
                                            alert.dismiss(animated: true, completion: nil)
                                        }
                                        self.view.isUserInteractionEnabled = true
                                        // activityIndicatorView.removeFromSuperview()
                                }
                                
                            }
                            
                            
                            
                            
                        }
                            
                        catch
                        {
                            DispatchQueue.main.async()
                                {
                                    self.view.isUserInteractionEnabled = true
                                    //activityIndicatorView.removeFromSuperview()
                            }
                        }
                        
                        
                })
            case .failure(let encodingError):
                
                
                DispatchQueue.main.async()
                    {
                        self.view.isUserInteractionEnabled = true
                        //activityIndicatorView.removeFromSuperview()
                }
                print(encodingError)
                //completion(nil, nil, nil, false)
            }
        })
        
    }
    
    func func_saveuserProfiledata() {
        
        
        let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id ,"customer_name": self.ProfileuserName,"customer_dob":self.postdob,"customer_gender":self.malefemale,"customer_time_birth":self.CustomerTimebirth,"customer_age":self.Age,"customer_zodiac_sign":self.ZodiacsignID,"customer_address":self.ProfileAddress,"customer_state":Profilestate,"customer_city":Profilecity,"customer_country_id":userCountrycode] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("saveUserProfileData", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
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
    
    func func_GetStates() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        // let setparameters = ["app_type":"ios","app_version":"1.0","user_id":UserUniqueID ,"user_api_key":UserApiKey]
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey]
        print(setparameters)
        //AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("states", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            let dict_data = tempDict["data"] as! [String:Any]
                                            print("dict_data is:- ",dict_data)
                                            self.stateArray = NSArray()
                                            
                                            
                                            
                                            if let arrtimeslot = dict_data["states"] as? NSArray
                                            {
                                                self.stateArray = arrtimeslot
                                            }
                                            print("arrTimeList is:- ",self.stateArray)
                                            
                                            for i in 0..<self.stateArray.count
                                            {
                                                let dict_Products = self.stateArray[i] as! NSDictionary
                                                let name = dict_Products["state_name"] as! String
                                                let id = dict_Products["state_id"] as! String
                                                let iddddd = Int(id)
                                                
                                                
                                                
                                                
                                                self.stateNameArray.append(name)
                                                self.stateIdArray.append(iddddd!)
                                                
                                                
                                            }
                                            
                                            self.tbl_profile.reloadData()
                                            
                                            
                                            
                                            
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
    
    func func_GetCity() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        //let setparameters = ["app_type":"ios","app_version":"1.0","user_id":UserUniqueID ,"user_api_key":UserApiKey,"state_id":userStateId]
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey,"state_id":userStateId]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("cityByStateId", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            let dict_data = tempDict["data"] as! [String:Any]
                                            print("dict_data is:- ",dict_data)
                                            self.cityArray = NSArray()
                                            
                                            
                                            
                                            
                                            if let arrtimeslot = dict_data["cities"] as? NSArray
                                            {
                                                self.cityArray = arrtimeslot
                                            }
                                            print("arrTimeList is:- ",self.cityArray)
                                            
                                            for i in 0..<self.cityArray.count
                                            {
                                                let dict_Products = self.cityArray[i] as! NSDictionary
                                                let name = dict_Products["city_name"] as! String
                                                let id = dict_Products["city_id"] as! String
                                                let iddddd = Int(id)
                                                
                                                
                                                self.cityNameArray.append(name)
                                                self.cityIdArray.append(iddddd!)
                                            }
                                            
                                            self.tbl_profile.reloadData()
                                            
                                            
                                            
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
    
    func func_GetCOUNTRY() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        //let setparameters = ["app_type":"ios","app_version":"1.0","user_id":UserUniqueID ,"user_api_key":UserApiKey,"state_id":userStateId]
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue]
        print(setparameters)
        // AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("country_code", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            if let arrtimeslot = tempDict["data"] as? NSArray
                                            {
                                                self.countryArray = arrtimeslot
                                            }
                                            print("arrTimeList is:- ",self.countryArray)
                                            
                                            for i in 0..<self.countryArray.count
                                            {
                                                let dict_Products = self.countryArray[i] as! NSDictionary
                                                let name = dict_Products["name"] as! String
                                                let id = dict_Products["id"] as! String
                                                let iddddd = Int(id)
                                                
                                                
                                                self.countryNameArray.append(name)
                                                self.countryIdArray.append(iddddd!)
                                            }
                                            self.tbl_profile.reloadData()
                                            
                                            
                                            
                                            
                                            
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
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btn_EditAction(_ sender: UIButton)
    {
        Common.showAlert(alertMessage: "Choose picture", alertButtons: ["Camera", "Gallery"], alertStyle: UIAlertController.Style.actionSheet, callback: { (btnTitle) in
            if btnTitle == "Gallery"{
                //                self.imagePicker.allowsEditing = false
                //                self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                //                self.present(self.imagePicker, animated: true, completion: nil)
                
                
                self.imagePicker =  UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }else
            {
                if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
                {
//                    self.imagePicker.allowsEditing = false
//                    self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
//                    self.imagePicker.cameraCaptureMode = .photo
//                    self.present(self.imagePicker, animated: true, completion: nil)
                    
                    
                    self.imagePicker =  UIImagePickerController()
                    self.imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    
                    self.present(self.imagePicker, animated: true, completion: nil)
                    
                    
                }
                else
                {
                    Common.showAlert(alertMessage: "Camera Not Found", alertButtons: ["Ok"], callback: { (btn) in })
                }
            }
        })
    }
    @IBAction func btn_updateAction(_ sender: Any)
    {
        //       let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey,"user_id":user_id ,"customer_name": self.ProfileuserName,"customer_dob":self.postdob,"customer_gender":self.malefemale,"customer_time_birth":self.CustomerTimebirth,"customer_age":self.Age,"customer_zodiac_sign":self.ZodiacsignID,"customer_address":self.ProfileAddress,"customer_state":userStateId,"customer_city":userCityId,"customer_country_id":"99"]
        //
        //        print(setparameters)
        
        self.func_saveuserProfiledata()
    }
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 5
    }
   func tableView(_ tableView: UITableView, btnorRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section==0
            
        {
            return 1
            
        }
        else if section == 1
            
        {
            return 1
            
        }
        else if section == 2
            
        {
            return 1
            
        }
        else if section == 3
            
        {
            return 1
            
        }
        else
            
        {
            return 1
            
        }
        //         else
        //
        //        {
        //           return 1
        //
        //        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            
            cell_Add.img_profile.layer.cornerRadius = cell_Add.img_profile.frame.size.height/2
            cell_Add.img_profile.layer.borderWidth = 1
            cell_Add.img_profile.layer.borderColor = (UIColor .darkGray).cgColor
            cell_Add.img_profile.clipsToBounds = true
            
            cell_Add.view_camera.layer.cornerRadius = cell_Add.view_camera.frame.size.height/2
            cell_Add.view_camera.clipsToBounds = true
            
            
            
            
            cell_Add.btn_camera.tag = indexPath.row
            cell_Add.btn_camera.addTarget(self, action: #selector(self.btn_EditAction(_:)), for: .touchUpInside)
            
            if personaldetailss.count != 0
            {
                
                if Profileimagechange == ""
                {
                    cell_Add.img_profile.sd_setImage(with: URL(string: UserImageurl), placeholderImage: UIImage(named: "Placeholder.png"))
                }
                else
                {
                    cell_Add.img_profile.image = selectedImage
                }
                
            }
            
            
            
            
            return cell_Add
            
        }
        else if indexPath.section == 1
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell1", for: indexPath) as! ProfileCell1
            
            cell_Add.btn_MALE.tag = indexPath.row
            cell_Add.btn_MALE.addTarget(self, action: #selector(self.btn_maleAction(_:)), for: .touchUpInside)
            
            cell_Add.btn_FEMALE.tag = indexPath.row
            cell_Add.btn_FEMALE.addTarget(self, action: #selector(self.btn_femaleAction(_:)), for: .touchUpInside)
            
            cell_Add.btn_DOB.tag = indexPath.row
            cell_Add.btn_DOB.addTarget(self, action: #selector(self.btn_DobAction(_:)), for: .touchUpInside)
            
            if personaldetailss.count == 0
            {
                
                
                
            }
            else
            {
                
                if malefemale == "63"
                {
                    cell_Add.btn_MALE.layer.cornerRadius = 8
                    cell_Add.btn_MALE.layer.backgroundColor = UIColor(red: 252/255.0, green: 99/255.0, blue: 31/255.0, alpha: 1.0).cgColor
                    cell_Add.btn_MALE.setTitleColor(.white, for: .normal)
                    // cell_Add.btn_FEMALE.setTitleColor(UIColor(red: 31/255.0, green: 130/255.0, blue: 162/255.0, alpha: 1.0), for: .normal)
                    cell_Add.btn_FEMALE.setTitleColor(.black, for: .normal)
                    cell_Add.btn_FEMALE.backgroundColor = UIColor.white
                    
                }
                else if malefemale == "64"
                {
                    cell_Add.btn_FEMALE.layer.cornerRadius = 8
                    cell_Add.btn_FEMALE.layer.backgroundColor = UIColor(red: 252/255.0, green: 99/255.0, blue: 31/255.0, alpha: 1.0).cgColor
                    cell_Add.btn_FEMALE.setTitleColor(.white, for: .normal)
                    
                    cell_Add.btn_MALE.layer.cornerRadius = 0
                    cell_Add.btn_MALE.backgroundColor = UIColor.white
                    cell_Add.btn_MALE.setTitleColor(.black, for: .normal)
                    // cell_Add.btn_MALE.setTitleColor(UIColor(red: 31/255.0, green: 130/255.0, blue: 162/255.0, alpha: 1.0), for: .normal)
                    
                }
                else
                {
                    cell_Add.btn_MALE.layer.cornerRadius = 0
                    cell_Add.btn_MALE.backgroundColor = UIColor.white
                    cell_Add.btn_MALE.setTitleColor(.black, for: .normal)
                    
                    cell_Add.btn_FEMALE.setTitleColor(.black, for: .normal)
                    cell_Add.btn_FEMALE.backgroundColor = UIColor.white
                }
                if ProfileuserName != ""
                {
                    cell_Add.txt_Usename.text = ProfileuserName
                }
                if  self.date_Selectdate != ""
                {
                    
                    cell_Add.btn_DOB.setTitleColor(.black, for: .normal)
                    cell_Add.btn_DOB.setTitle(self.date_Selectdate,for: .normal)
                }
                
                
                
            }
            
            
            return cell_Add
        }
        else if indexPath.section == 2
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell3", for: indexPath) as! ProfileCell3
            
            // cell_Add.btn_specialization.tag = indexPath.row
            // cell_Add.btn_specialization.addTarget(self, action: #selector(self.btn_typeAction(_:)), for: .touchUpInside)
            
            
            if personaldetailss.count == 0
            {
                
                
            }
            else
            {
                
                if ProfileuserEmail != ""
                {
                    cell_Add.txt_email.text = ProfileuserEmail
                }
                if ProfileuserMobilenumber != ""
                {
                    cell_Add.txt_mobilenumber.text = ProfileuserMobilenumber
                }
                
                
            }
            
            return cell_Add
        }
        else if indexPath.section == 3
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell4", for: indexPath) as! ProfileCell4
            
            cell_Add.btn_birthtime.tag = indexPath.row
            cell_Add.btn_birthtime.addTarget(self, action: #selector(self.btn_birthAction(_:)), for: .touchUpInside)
            
            cell_Add.btnsign.tag = indexPath.row
            cell_Add.btnsign.addTarget(self, action: #selector(self.btn_signAction(_:)), for: .touchUpInside)
            if personaldetailss.count == 0
            {
                
                
            }
            else
            {
                if  self.CustomerTimebirth != ""
                {
                    cell_Add.btn_birthtime.setTitleColor(.black, for: .normal)
                    cell_Add.btn_birthtime.setTitle(self.CustomerTimebirth,for: .normal)
                }
                if  self.Age != ""
                {
                    cell_Add.txtage.text = self.Age
                }
                if  self.Zodiacsign != ""
                {
                    cell_Add.btnsign.setTitleColor(.black, for: .normal)
                    cell_Add.btnsign.setTitle(self.Zodiacsign,for: .normal)
                }
                
                
            }
            
            return cell_Add
        }
        else
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell2", for: indexPath) as! ProfileCell2
            
            cell_Add.stateDropDown.resignFirstResponder()
            cell_Add.cityDropDown.resignFirstResponder()
            cell_Add.mainDropDown.resignFirstResponder()
            
           // cell_Add.mainDropDown.isEnabled = false
           // cell_Add.stateDropDown.isEnabled = false
           // cell_Add.cityDropDown.isEnabled = false
            
            cell_Add.stateDropDown.optionArray = self.stateNameArray
            cell_Add.stateDropDown.optionIds = self.stateIdArray
            cell_Add.stateDropDown.checkMarkEnabled = false
            
            cell_Add.cityDropDown.optionArray = self.cityNameArray
            cell_Add.cityDropDown.optionIds = self.cityIdArray
            cell_Add.cityDropDown.checkMarkEnabled = false
            
            
            cell_Add.mainDropDown.optionArray = self.countryNameArray
            cell_Add.mainDropDown.optionIds = self.countryIdArray
            cell_Add.mainDropDown.checkMarkEnabled = false
            
            cell_Add.mainDropDown.arrowSize = 20
            cell_Add.cityDropDown.arrowSize = 20
            cell_Add.stateDropDown.arrowSize = 20

            if personaldetailss.count == 0
            {
                
                
                
            }
            else
            {
                
                self.Profilestate = personaldetailss["user_state"] as! String
                self.Profilecity = personaldetailss["user_city"] as! String
                self.Profilecountry = personaldetailss["user_city"] as! String
                
                
                if self.Profilestate != ""
                {
                    cell_Add.txt_state.text = self.Profilestate
                }
                if self.Profilecity != ""
                {
                    cell_Add.txt_city.text = self.Profilecity
                }
//                if self.Profilecountry != ""
//                {
//                    cell_Add.txt_country.text = self.Profilecountry
//                }
                
//                cell_Add.stateDropDown.didSelect{(selectedText , index , id) in
//
//
//                    let txtddddd = selectedText
//                    let txtIdddddddd = id
//                    print(txtddddd)
//                    print(txtIdddddddd)
//
//                    cell_Add.cityDropDown.text = ""
//                    self.cityNameArray = [String]()
//                    self.cityIdArray = [Int]()
//                    userState = selectedText
//                    userStateId = String(txtIdddddddd)
//                    //  self.cityArray = NSArray()
//                    self.func_GetCity()
//
//                }
//                cell_Add.cityDropDown.didSelect{(selectedText , index , id) in
//
//
//                    let txtddddd = selectedText
//                    let txtIdddddddd = id
//                    print(txtddddd)
//                    print(txtIdddddddd)
//                    userCity = selectedText
//                    userCityId = String(txtIdddddddd)
//
//                }
//
                cell_Add.mainDropDown.didSelect{(selectedText , index , id) in


                    let txtddddd = selectedText
                    let txtIdddddddd = id
                    print(txtddddd)
                    print(txtIdddddddd)
                    userCountry = selectedText
                    userCountrycode = String(txtIdddddddd)

                }
                
                
                if  self.ProfileAddress != ""
                {
                    
                    cell_Add.txt_address.text = self.ProfileAddress
                }
                
//                if userState != ""
//                {
//
//                    cell_Add.stateDropDown.text = userState
//                }
//                if userCity != ""
//                {
//
//                    cell_Add.cityDropDown.text = userCity
//                }
                if userCountry != ""
                {

                    cell_Add.mainDropDown.text = userCountry
                }
                
                
                
            }
            
            return cell_Add
        }
        
        
    }
    @objc func btn_maleAction(_ sender: UIButton)
    {
        
        malefemale = "63"
        tbl_profile.reloadData()
        
    }
    @objc  func btn_femaleAction(_ sender: UIButton)
    {
        //isChecked = true
        malefemale = "64"
        tbl_profile.reloadData()
    }
    @objc func btn_DobAction(_ sender: UIButton)
    {
        dobandtimeclick = "dob"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        
        present(selector, animated: true, completion: nil)
        
    }
    @objc func btn_StateAction(_ sender: UIButton)
    {
        let FogetVC = self.storyboard?.instantiateViewController(withIdentifier: "StateCityVC")
        self.navigationController?.pushViewController(FogetVC!, animated: false)
    }
    
    @objc func btn_CityAction(_ sender: UIButton)
    {
        
        if userStateId == ""
        {
            CommenModel.showDefaltAlret(strMessage:"Please Select State", controller: self)
        }
        else
        {
            let FogetVC = self.storyboard?.instantiateViewController(withIdentifier: "CityVC")
            self.navigationController?.pushViewController(FogetVC!, animated: false)
        }
        
        
        
    }
    @objc func btn_CountryAction(_ sender: UIButton)
    {
        let Country = self.storyboard?.instantiateViewController(withIdentifier: "CountryVC")
        self.navigationController?.pushViewController(Country!, animated: true)
    }
    @objc func btn_birthAction(_ sender: UIButton)
    {
        dobandtimeclick = "time"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        
        present(selector, animated: true, completion: nil)
    }
    @objc func btn_signAction(_ sender: UIButton)
    {
        guard let view = sender as? UIView else { return }
        DPArrowMenu.show(view, viewModels: viewModels, done:
            { index in
                
                // print(index)
                let model  =  self.viewModels[index]
                self.Zodiacsign = model.title!
                self.ZodiacsignID = model.id!
                //self.ZodiacsignImage = model.imageName!
                self.tbl_profile.reloadData()
                
        })
        {
            print("cancel")
        }
        
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
}
class ProfileCell2: UITableViewCell {
    
    @IBOutlet weak var txt_address: UITextField!
    @IBOutlet weak var btn_state: UIButton!
    @IBOutlet weak var btn_city: UIButton!
    @IBOutlet weak var btn_country: UIButton!
    @IBOutlet weak var txt_pincode: UITextField!
    @IBOutlet weak var btn_type: UIButton!
    @IBOutlet weak var stateDropDown: DropDown!
    @IBOutlet weak var cityDropDown: DropDown!
    @IBOutlet weak var mainDropDown: DropDown!
    
    @IBOutlet weak var txt_state: UITextField!
    @IBOutlet weak var txt_city: UITextField!
    @IBOutlet weak var txt_country: UITextField!
}

class ProfileCell3: UITableViewCell {
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_mobilenumber: UITextField!
    @IBOutlet weak var txt_enquiry: UITextField!
    @IBOutlet weak var btn_DOB: UIButton!
    @IBOutlet weak var btn_birthtime: UIButton!
    
    
}
class ProfileCell4: UITableViewCell {
    
    @IBOutlet weak var txt_Alternativenumber: UITextField!
    @IBOutlet weak var btn_birthtime: UIButton!
    @IBOutlet weak var btnsign: UIButton!
    @IBOutlet weak var btncountryy: UIButton!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var mainDropDown: DropDown!
    
    @IBOutlet weak var txtPlace: UITextField!
    @IBOutlet weak var txtQuery: UITextField!
    
    @IBOutlet weak var textQuery: UITextView!
    
}

class ProfileCellTwoButtons: UITableViewCell {
    
    @IBOutlet weak var buttonSample: ZFRippleButton!
    @IBOutlet weak var buttonDone: ZFRippleButton!
}
