//
//  NewProfileVC.swift
//  Astroshub
//
//  Created by Kriscent on 10/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage

class NewProfileVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet var tbl_profile: UITableView!
    @IBOutlet weak var view_top: UIView!
    var LanguageArray = NSArray()
    var arrReviews = [[String:Any]]()
    // var AstrocatArray = NSArray()
    var AstrocatArray = [[String:Any]]()
    
    @IBOutlet weak var buttonForNotify: UIButton!
    var arrRating1 = [[String:Any]]()
    var arrRating2 = [[String:Any]]()
    var arrRating3 = [[String:Any]]()
    var arrRating4 = [[String:Any]]()
    var arrRating5 = [[String:Any]]()
    
    var userId:String?
    var astroApiKey:String?

    var valueeee1 = Float()
    var valueeee2 = Float()
    var valueeee3 = Float()
    var valueeee4 = Float()
    var valueeee5 = Float()
    var placeHolderImg = ""
    var categoryArray = [String]()
    var completionHandler:(([String : Any]) -> [String : Any])?
    var AstrologerFullData1 = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.func_GetProfiledata()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonNotify(_ sender: UIButton) {
        NotifyCallMethods(AstrologerFullData1["astrologers_uni_id"] as? String ?? "")
        
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    func NotifyCallMethods(_ astroId:String) {
        
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,
                             "app_version":MethodName.APPVERSION.rawValue,
                             "user_api_key":user_apikey,
                             "user_id":user_id,"astrologer_id":astroId,"request_type":chatcallingFormmm == "Chat" ? "chat" : "call"] as [String : Any]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("astroNotifyMe", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
//                                            self.buttonForNotify.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
                                            
                                            if chatcallingFormmm == "Chat" {
                                            

                                                if self.AstrologerFullData1["chat_notify_status"] as? String == "" {
                                                    self.AstrologerFullData1["chat_notify_status"] = "0"
                                                    self.buttonForNotify.setImage(#imageLiteral(resourceName: "notification (2)"), for: .normal)

                                                }
                                                else {
                                                    self.buttonForNotify.setImage(#imageLiteral(resourceName: "notificationWhite"), for: .normal)
                                                    self.AstrologerFullData1["chat_notify_status"] = ""

                                                }
                                                
                                            } else {
 
                                                if  self.AstrologerFullData1["call_notify_status"] as? String == "" {
                                                    self.buttonForNotify.setImage(#imageLiteral(resourceName: "notification (2)"), for: .normal)
                                                    self.AstrologerFullData1["call_notify_status"] = "0"
                                            } else {
                                                //                buttonForNotify.isSelected = true
                                                self.buttonForNotify.setImage(#imageLiteral(resourceName: "notificationWhite"), for: .normal)
                                                self.AstrologerFullData1["call_notify_status"] = ""

                                                
                                            }
                                             
                                            }
                                            let refreshAlert = UIAlertController(title: "AstroShubh", message:     "You will receive a notification when astrologer comes online."
, preferredStyle: UIAlertController.Style.alert)
                                            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                                                                                    {
                                                                                        (action: UIAlertAction!) in
                                                                                        self.dismiss(animated: true, completion: nil)
                                                                                        
                                                                                    }))
                                            self.present(refreshAlert, animated: true, completion: nil)
                                            self.completionHandler!(self.AstrologerFullData1)
                                        }
                                        
                                      }) { (error) in
            AutoBcmLoadingView.dismiss()
        }
        
        
        
    }
    @IBAction func buttonForShare(_ sender: UIButton) {
        let text =  "Chat with India' best astrologer \(AstrologerFullData1["astrologers_name"] as! String) and get accurate predictions"
        let myWebsite = URL(string:"https://apps.apple.com/in/app/astroshubh/id1509641168")
        let shareAll = [text , myWebsite as Any] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_GetProfiledata() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"astrologer_id":userId ?? "" ,"astrologer_api_key":astroApiKey ?? ""] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.GETPROFILEDATA.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                           print(success)
                                            personaldetailss = tempDict["data"] as! [String:Any]
                                            print("personaldetailss is:- ",personaldetailss)
//                                            self.AstrologerFullData1 = personaldetailss
                                            self.allData()
                                        } else {
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                        }
                                      }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    func allData() {
        arrReviews = [[String:Any]]()
        self.placeHolderImg = chatcallingFormmm == "Chat" ? "astrochat" : "astrotalk"
        self.AstrocatArray = personaldetailss["category_arr"] as! [[String:Any]]
        
        self.arrReviews = personaldetailss["reviewRating"] as! [[String:Any]]
        if chatcallingFormmm == "Chat" {
            let chatStatus = personaldetailss["astro_chat_status"] as? String ?? ""
            if chatStatus == "1"{
                buttonForNotify.setImage(#imageLiteral(resourceName: "notification (2)"), for: .normal)
                buttonForNotify.isEnabled = false
            } else if chatStatus == "2" {
                buttonForNotify.setImage(#imageLiteral(resourceName: "notification (2)"), for: .normal)
                buttonForNotify.isEnabled = false
            }else {
                buttonForNotify.isEnabled = true

            if AstrologerFullData1["chat_notify_status"] as? String == "" {
                buttonForNotify.setImage(#imageLiteral(resourceName: "notificationWhite"), for: .normal)
            } else {
                buttonForNotify.setImage(#imageLiteral(resourceName: "notification (2)"), for: .normal) }
            }
        } else {
            let chatStatus = personaldetailss["astro_call_status"] as? String ?? ""
            if chatStatus == "1"{
                buttonForNotify.setImage(#imageLiteral(resourceName: "notification (2)"), for: .normal)
                buttonForNotify.isEnabled = false
            } else if chatStatus == "2" {
                buttonForNotify.setImage(#imageLiteral(resourceName: "notification (2)"), for: .normal)
                buttonForNotify.isEnabled = false
            }else {
                buttonForNotify.isEnabled = true
        if  AstrologerFullData1["call_notify_status"] as? String == "" {
            //                   buttonForNotify.isSelected = false
            buttonForNotify.setImage(#imageLiteral(resourceName: "notificationWhite"), for: .normal)
        } else {
            //                buttonForNotify.isSelected = true
            buttonForNotify.setImage(#imageLiteral(resourceName: "notification (2)"), for: .normal)
        }
            }
        }
        categoryArray.removeAll()
        for i in 0..<self.AstrocatArray.count
        {
            let data = self.AstrocatArray[i]
            categoryArray.append(data["master_category_title"] as! String)
        }
        for j in 0..<self.arrReviews.count
        {
            
            let dict2 = self.arrReviews[j] as NSDictionary
            
            let ratinggg = dict2["review_rating"] as! String
            
            if ratinggg == "1"
            {
                
                let dict = [
                    "rating" : dict2["review_rating"] as! String,
                    
                ] as [String : Any]
                arrRating1.append(dict)
                
                
                
            }
            if ratinggg == "2"
            {
                let dict = [
                    "rating" : dict2["review_rating"] as! String,
                    
                ] as [String : Any]
                arrRating2.append(dict)
            }
            if ratinggg == "3"
            {
                let dict = [
                    "rating" : dict2["review_rating"] as! String,
                    
                ] as [String : Any]
                arrRating3.append(dict)
            }
            if ratinggg == "4"
            {
                let dict = [
                    "rating" : dict2["review_rating"] as! String,
                    
                ] as [String : Any]
                arrRating4.append(dict)
            }
            if ratinggg == "5"
            {
                let dict = [
                    "rating" : dict2["review_rating"] as! String,
                    
                ] as [String : Any]
                arrRating5.append(dict)
            }
            
        }
        
        
        let valuev = self.arrReviews.count
        
        let count1: Int  = arrRating1.count
        let devide1: Double = Double(count1) / Double(valuev)
        
        
        valueeee1 = Float(devide1)
        print(valueeee1)
        
        let count2: Int = arrRating2.count
        let devide2: Double = Double(count2) / Double(valuev)
        
        
        valueeee2 = Float(devide2)
        print(valueeee2)
        
        let count3: Int = arrRating3.count
        let devide3: Double = Double(count3) / Double(valuev)
        
        
        valueeee3 = Float(devide3)
        print(valueeee3)
        
        let count4: Int = arrRating4.count
        let devide4: Double = Double(count4) / Double(valuev)
        
        
        valueeee4 = Float(devide4)
        print(valueeee4)
        
        let count5: Int = arrRating5.count
        let devide5: Double  = Double(count5) / Double(valuev)
        
        
        valueeee5 = Float(devide5)
        print(valueeee5)
   
        self.tbl_profile.reloadData()
    }
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_EDITAction(_ sender: Any)
    {
        let Profile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
        self.navigationController?.pushViewController(Profile!, animated: true)
    }
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return personaldetailss.count == 0 ? 0 : 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section {
        case 0,1,2,3,4:
            return 1
        case 5:
            return  arrReviews.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell_Add.img_profile.layer.cornerRadius = cell_Add.img_profile.frame.size.height/2
//            if AstrologerFullData1.count != 0
//            {
//                let Image = AstrologerFullData1["astrologers_image_url"] as! String
//                let name = AstrologerFullData1["astrologers_name"] as? String ?? ""
//                let exp = AstrologerFullData1["astrologers_experience"] as? String ?? ""
//                let capStr = name.capitalized
//                let arrastroprice = (personaldetailss["astro_price"] as? [[String:Any]])!
//                let astro_price_inrchat = (arrastroprice[0]["astro_price_inr"]  as? String)!
//                let astro_price_dollarchat = (arrastroprice[0]["astro_price_dollar"]  as? String)!
//                let astro_price_inrcall = (arrastroprice[1]["astro_price_inr"]  as? String)!
//                let astro_price_dollarcall = (arrastroprice[1]["astro_price_dollar"]  as? String)!
//                let chatStatus = AstrologerFullData1["astro_chat_status"] as? String ?? ""
//                let talk = AstrologerFullData1["astro_call_status"] as? String ?? ""
//
//                if CurrentLocation == "India"
//                {
//                    cell_Add.lbl_onlinetime.text =  astro_price_inrcall + " " + rupee + " / minute"
//                    cell_Add.lblPrice.text =  astro_price_inrchat + " " + rupee + " / minute"
//                }
//                else
//                {
//                    cell_Add.lbl_onlinetime.text =  astro_price_dollarcall + " $/ minute"
//                    cell_Add.lblPrice.text =  astro_price_dollarchat + " $/ minute"
//                }
//
//                if chatcallingFormmm == "Chat" {
//                if chatStatus == "1" {
//                    cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 0.06656374782, green: 0.6171005368, blue: 0.03814116493, alpha: 1)
//                    cell_Add.circlImage.layer.borderWidth = 3.0
//                } else  if chatStatus == "2"  {
//                    cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
//                    cell_Add.circlImage.layer.borderWidth = 3.0
//                    cell_Add.lbl_onlinetime.text = AstrologerFullData1["astrologers_available_time"] as? String
//                } else {
//                    cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//                    cell_Add.circlImage.layer.borderWidth = 3.0
//                    cell_Add.lbl_onlinetime.text = AstrologerFullData1["astrologers_available_time"] as? String
//                 }
//                    if CurrentLocation == "India"{
//                        cell_Add.lblPrice.text =  "\(rupee) \(AstrologerFullData1["astro_price_inrchat"] as? String ?? "")/minute"
//                    } else {
//                        cell_Add.lblPrice.text = "$ \(AstrologerFullData1["astro_price_dollarchat"] as? String ?? "")/minute"
//                    }
//                } else {
//                    if talk == "1"{
//                        cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 0.06656374782, green: 0.6171005368, blue: 0.03814116493, alpha: 1)
//                        cell_Add.circlImage.layer.borderWidth = 3.0
//                    } else  if  talk == "2" {
//                        cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
//                        cell_Add.circlImage.layer.borderWidth = 3.0
//                        cell_Add.lbl_onlinetime.text = AstrologerFullData1["astrologers_available_time"] as? String
//                    } else {
//                        cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//                        cell_Add.circlImage.layer.borderWidth = 3.0
//                        cell_Add.lbl_onlinetime.text = AstrologerFullData1["astrologers_available_time"] as? String
//                    }
//                    if CurrentLocation == "India"{
//                    cell_Add.lblPrice.text = "\(rupee) \(AstrologerFullData1["astro_price_inrcall"] as? String ?? "")/minute"
//
//                    } else {
//                        cell_Add.lblPrice.text = "$ \(AstrologerFullData1["astro_price_dollarcall"] as? String ?? "")/minute"
//                    }
//                }
//
//                cell_Add.circlImage.layer.cornerRadius = cell_Add.circlImage.frame.height/2
//                cell_Add.circlImage.clipsToBounds = true
//                cell_Add.img_profile.sd_setImage(with: URL(string: Image), placeholderImage: #imageLiteral(resourceName: "appstore"))
//                cell_Add.lbl_name.text = capStr
//                cell_Add.lbl_exp.text = exp + " Years"
//                cell_Add.tagList.removeAllTags()
//                cell_Add.tagList.addTags(categoryArray)
//                cell_Add.tagList.alignment = .center
//
//            }
            
            if AstrologerFullData1.count != 0
            {
                let Image = AstrologerFullData1["astrologers_image_url"] as! String
                let name = AstrologerFullData1["astrologers_name"] as! String
                let lang = AstrologerFullData1["category_title"] as! String
                let exp = AstrologerFullData1["astrologers_experience"] as! String
                let capStr = name.capitalized
                // let string = LanguageArray.componentsJoined(by: ",")
                let chatStatus = AstrologerFullData1["astro_chat_status"] as? String ?? ""
                let talk = AstrologerFullData1["astro_call_status"] as? String ?? ""
                if chatcallingFormmm == "Chat" {
                if chatStatus == "1" {
                    cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 0.06656374782, green: 0.6171005368, blue: 0.03814116493, alpha: 1)
                    cell_Add.circlImage.layer.borderWidth = 3.0
                } else  if chatStatus == "2"  {
                    cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                    cell_Add.circlImage.layer.borderWidth = 3.0
                    cell_Add.lbl_onlinetime.text = AstrologerFullData1["astrologers_available_time"] as? String
                } else {
                    cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                    cell_Add.circlImage.layer.borderWidth = 3.0
                    cell_Add.lbl_onlinetime.text = AstrologerFullData1["astrologers_available_time"] as? String
                 }
                    if CurrentLocation == "India"{
                        cell_Add.lblPrice.text =  "\(rupee) \(AstrologerFullData1["chat_price_Inr"] as? String ?? "")/minute"
                    } else {
                        cell_Add.lblPrice.text = "$ \(AstrologerFullData1["chat_price_dollar"] as? String ?? "")/minute"
                    }
                } else {
                    if talk == "1"{
                        cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 0.06656374782, green: 0.6171005368, blue: 0.03814116493, alpha: 1)
                        cell_Add.circlImage.layer.borderWidth = 3.0
                    } else  if  talk == "2" {
                        cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                        cell_Add.circlImage.layer.borderWidth = 3.0
                        cell_Add.lbl_onlinetime.text = AstrologerFullData1["astrologers_available_time"] as? String
                    } else {
                        cell_Add.circlImage.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                        cell_Add.circlImage.layer.borderWidth = 3.0
                        cell_Add.lbl_onlinetime.text = AstrologerFullData1["astrologers_available_time"] as? String
                    }
                    if CurrentLocation == "India"{
                    cell_Add.lblPrice.text = "\(rupee) \(AstrologerFullData1["call_price_Inr"] as? String ?? "")/minute"

                    } else {
                        cell_Add.lblPrice.text = "$ \(AstrologerFullData1["call_price_dollar"] as? String ?? "")/minute"
                    }
                }

                cell_Add.circlImage.layer.cornerRadius = cell_Add.circlImage.frame.height/2
                cell_Add.circlImage.clipsToBounds = true

                cell_Add.img_profile.sd_setImage(with: URL(string: Image), placeholderImage: #imageLiteral(resourceName: "userdefault"))
                cell_Add.lbl_name.text = capStr
                cell_Add.lbl_exp.text = exp + " Years"
                cell_Add.tagList.removeAllTags()
                cell_Add.tagList.addTags(categoryArray)
                cell_Add.tagList.alignment = .center
            }
            return cell_Add
        }
        
        else if indexPath.section == 1
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ImagesTableViewCell", for: indexPath) as! ImagesTableViewCell
            cell_Add.labelForCallMin.text = "\(personaldetailss["call_minutes"] ?? "0") mins"
            cell_Add.labelForChatMin.text = "\(personaldetailss["chat_minutes"] ?? "0") mins"
            cell_Add.arrFOrimage =  personaldetailss["astro_gallery"] as? [[String:Any]] ?? []
            let valueoFimages = personaldetailss["astro_gallery"] as? [[String:Any]] ?? []
            let width  = (cell_Add.collectionView.frame.width-10)/3
            if valueoFimages.count == 0 {
                cell_Add.heightConstraintForcollevtion.constant = 0
            } else {
                cell_Add.heightConstraintForcollevtion.constant = width
            }
            cell_Add.collectionView.reloadData()
            return cell_Add
        }
        else if indexPath.section == 2
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "AbountUsCell1", for: indexPath) as! AbountUsCell1
            let biography = personaldetailss["astrologers_long_biography"] as? String ?? ""
            cell_Add.textVieww.attributedText = biography.htmlToAttributedString
            return cell_Add
        }
        //        else if indexPath.section == 2
        //        {
        //            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "AbountUsCell", for: indexPath) as! AbountUsCell
        //            let biography = AstrologerFullData1["astrologers_long_biography"] as? String ?? ""
        //            cell_Add.lbl_Packagetitle.attributedText =  biography.htmlToAttributedString
        //            return cell_Add
        //        }
        else if indexPath.section == 3
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ReviewsCell", for: indexPath) as! ReviewsCell
            return cell_Add
        }
        else if indexPath.section == 4
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ReviewsPageCell", for: indexPath) as! ReviewsPageCell
            cell_Add.taskProgress1.trackTintColor = UIColor.clear
            cell_Add.taskProgress1.tintColor = UIColor.clear
            let Progress1: Float = valueeee1
            cell_Add.taskProgress1.setProgress(Progress1, animated: true)
            cell_Add.taskProgress2.trackTintColor = UIColor.clear
            cell_Add.taskProgress2.tintColor = UIColor.clear
            let Progress2: Float = valueeee2
            cell_Add.taskProgress2.setProgress(Progress2, animated: true)
            cell_Add.taskProgress3.trackTintColor = UIColor.clear
            cell_Add.taskProgress3.tintColor = UIColor.clear
            let Progress3: Float = valueeee3
            cell_Add.taskProgress3.setProgress(Progress3, animated: true)
            cell_Add.taskProgress4.trackTintColor = UIColor.clear
            cell_Add.taskProgress4.tintColor = UIColor.clear
            let Progress4: Float = valueeee4
            cell_Add.taskProgress4.setProgress(Progress4, animated: true)
            cell_Add.taskProgress5.trackTintColor = UIColor.clear
            cell_Add.taskProgress5.tintColor = UIColor.clear
            let Progres5: Float = valueeee5
            cell_Add.taskProgress5.setProgress(Progres5, animated: true)
            cell_Add.taskProgress1.setProgress(Progress1, animated: true)
            cell_Add.taskProgress1.trackTintColor = UIColor.init(red: 246/255.0, green: 197/255.0, blue: 0/255.0, alpha: 1.0)
            cell_Add.taskProgress1.tintColor = UIColor.white
            cell_Add.taskProgress2.setProgress(Progress2, animated: true)
            cell_Add.taskProgress2.trackTintColor = UIColor.init(red: 246/255.0, green: 197/255.0, blue: 0/255.0, alpha: 1.0)
            cell_Add.taskProgress2.tintColor = UIColor.white
            cell_Add.taskProgress3.setProgress(Progress3, animated: true)
            cell_Add.taskProgress3.trackTintColor = UIColor.init(red: 246/255.0, green: 197/255.0, blue: 0/255.0, alpha: 1.0)
            cell_Add.taskProgress3.tintColor = UIColor.white
            cell_Add.taskProgress4.setProgress(Progress4, animated: true)
            cell_Add.taskProgress4.trackTintColor = UIColor.init(red: 246/255.0, green: 197/255.0, blue: 0/255.0, alpha: 1.0)
            cell_Add.taskProgress4.tintColor = UIColor.white
            cell_Add.taskProgress5.setProgress(Progres5, animated: true)
            cell_Add.taskProgress5.trackTintColor = UIColor.init(red: 246/255.0, green: 197/255.0, blue: 0/255.0, alpha: 1.0)
            cell_Add.taskProgress5.tintColor = UIColor.white
            cell_Add.label1.text = "\(Progres5 * 100) %"
            cell_Add.label2.text = "\(Progress4 * 100) %"
            cell_Add.label3.text = "\(Progress3 * 100) %"
            cell_Add.label4.text = "\(Progress2 * 100) %"
            cell_Add.label5.text = "\(Progress1 * 100) %"
            let rating = AstrologerFullData1["rating"] as? String ?? ""
            let avrageRating = personaldetailss["avrageRating"] as? String ?? ""
            let reviewrating = Double(avrageRating)
            cell_Add.lbl_totalreviews.text = rating + " " + "Total"
            cell_Add.totalReviews.text = "\(arrReviews.count)" + " " + "Reviews"
            
            cell_Add.lbl_reviews.text = avrageRating
            cell_Add.floatingView.editable = false
            cell_Add.floatingView.rating = reviewrating ?? 0.0
            
            cell_Add.buttonReview.addTarget(self, action: #selector(ratingButton), for: .touchUpInside)
            return cell_Add
        }
        else if indexPath.section == 5
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ReviewsPageListCell", for: indexPath) as! ReviewsPageListCell
            cell_Add.img_User.layer.cornerRadius = cell_Add.img_User.frame.size.height/2
            cell_Add.img_User.clipsToBounds = true
            cell_Add.view_back.layer.shadowColor = UIColor.lightGray.cgColor
            cell_Add.view_back.layer.shadowOpacity = 5.0
            cell_Add.view_back.layer.shadowRadius = 5.0
            cell_Add.view_back.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
            cell_Add.view_back.layer.masksToBounds = false
            cell_Add.view_back.layer.cornerRadius = 5.0
            cell_Add.view_back1.layer.cornerRadius = 5.0
            if self.arrReviews.count == 0{
                
            } else {
            let dict_eventpoll = self.arrReviews[indexPath.row]
            let username = dict_eventpoll["username"] as! String
            let rating1 = dict_eventpoll["review_rating"] as! String
            
            if let getImage = dict_eventpoll["customer_image_url"] as? String {
                cell_Add.img_User.image = #imageLiteral(resourceName: "userdefault")
            } else {
                cell_Add.img_User.image = #imageLiteral(resourceName: "userdefault")
            }
            
            let date = dict_eventpoll["created_at"] as! String
            let description = dict_eventpoll["review_comment"] as! String
            
            cell_Add.lbl_Username.text = username
            cell_Add.lbl_date.text = date
            cell_Add.lbl_description.text = description
            cell_Add.floatingView.editable = false
            cell_Add.floatingView.rating = Double(rating1) ?? 0.0
                if (dict_eventpoll["comment_reply"] as? String ?? "").count == 0 {
                       cell_Add.viewForReply.isHidden = true
                } else {
                    cell_Add.viewForReply.isHidden = false
                    cell_Add.labelForReply.text = dict_eventpoll["comment_reply"] as? String ?? ""
                    cell_Add.labelForAstroName.text = (AstrologerFullData1["astrologers_name"] as? String ?? "").capitalized
                }
            
            }
            return cell_Add
        }
       return UITableViewCell()
        
    }
    
    
    @objc func ratingButton(_ sender:UIButton){
        if self.PerformActionIfLogin() {
            //            let dict_eventpoll = self.arrTalk[sender.tag]
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RateUsVC") as! RateUsVC
            controller.modalPresentationStyle = .overCurrentContext
            controller.astroId = AstrologerFullData1["astrologers_uni_id"] as? String  ?? ""
            controller.strForCloseDisable = "Astro"
            controller.completionHandler = {
                print("hell")
                let refreshAlert = UIAlertController(title: "AstroShubh", message: "Your Review is Added Successfully", preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:
                                                        {
                                                            (action: UIAlertAction!) in
                                                            self.dismiss(animated: true, completion: nil)
                                                            
                                                        }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 172, height: 59)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.AstrocatArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as? CategoryCollectionCell
        cell!.view_back.layer.cornerRadius = 10.0
        cell!.view_back.layer.borderColor = UIColor.black.cgColor
        cell!.view_back.layer.borderWidth = 1
        
        let dict_eventpoll = self.AstrocatArray[indexPath.row]
        //cell_Add.img_blog.kf.indicatorType = .activity
        
        let package_icon_url = dict_eventpoll["master_category_title"] as! String
        //cell!.view_back!.backgroundColor = UIColor .white
        cell?.lbl_Categorytitle?.textColor = UIColor .black
        cell?.lbl_Categorytitle.text = package_icon_url
        return cell!
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
}
class CategoryCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var img_Category: UIImageView!
    @IBOutlet weak var lbl_Categorytitle: UILabel!
    
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var btn_click: UIButton!
    
}
class AbountUsCell: UITableViewCell {
    
    @IBOutlet weak var lbl_Packagetitle: UILabel!
}
class AbountUsCell1: UITableViewCell {
    
    @IBOutlet weak var textVieww: UITextView!
    @IBOutlet weak var lbl_Packagetitle: UILabel!
    
}
class ReviewsCell: UITableViewCell {
    
    
}
class ReviewsPageCell: UITableViewCell {
    
    
    @IBOutlet weak var floatingView: FloatRatingView!
    @IBOutlet weak var img_1: UIImageView!
    @IBOutlet weak var img_2: UIImageView!
    @IBOutlet weak var img_3: UIImageView!
    @IBOutlet weak var img_4: UIImageView!
    @IBOutlet weak var img_5: UIImageView!
    @IBOutlet weak var lbl_reviews: UILabel!
    @IBOutlet weak var lbl_totalreviews: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var totalReviews: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var taskProgress1:UIProgressView!
    @IBOutlet weak var taskProgress2:UIProgressView!
    @IBOutlet weak var taskProgress3:UIProgressView!
    @IBOutlet weak var taskProgress4:UIProgressView!
    @IBOutlet weak var taskProgress5:UIProgressView!
    
    @IBOutlet weak var buttonReview: UIButton!
}
class ReviewsPageListCell: UITableViewCell {
    
    @IBOutlet weak var floatingView: FloatRatingView!
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var img_1: UIImageView!
    @IBOutlet weak var viewForReply: UIView!
    @IBOutlet weak var img_2: UIImageView!
    @IBOutlet weak var img_3: UIImageView!
    @IBOutlet weak var img_4: UIImageView!
    @IBOutlet weak var img_5: UIImageView!
    @IBOutlet weak var lbl_Username: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var view_back1: UIView!
    @IBOutlet weak var lbl_circlename: UILabel!
    
    @IBOutlet weak var labelForReply: UILabel!
    @IBOutlet weak var labelForAstroName: UILabel!
}
//extension String {
//    func capitalizingFirstLetter() -> String {
//        return prefix(1).capitalized + dropFirst()
//    }
//
//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
//}
extension String {
    func firstCharacterUpperCase() -> String? {
        guard !isEmpty else { return nil }
        let lowerCasedString = self.lowercased()
        return lowerCasedString.replacingCharacters(in: lowerCasedString.startIndex...lowerCasedString.startIndex, with: String(lowerCasedString[lowerCasedString.startIndex]).uppercased())
    }
}
