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
    
    var arrRating1 = [[String:Any]]()
    var arrRating2 = [[String:Any]]()
    var arrRating3 = [[String:Any]]()
    var arrRating4 = [[String:Any]]()
    var arrRating5 = [[String:Any]]()
    
    
    var valueeee1 = Float()
    var valueeee2 = Float()
    var valueeee3 = Float()
    var valueeee4 = Float()
    var valueeee5 = Float()
    var placeHolderImg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(AstrologerFullData)
        arrReviews = [[String:Any]]()
        self.placeHolderImg = chatcallingFormmm == "Chat" ? "astrochat" : "astrotalk"
         self.AstrocatArray = AstrologerFullData["category_arr"] as! [[String:Any]]
        
         self.arrReviews = AstrologerFullData["reviews"] as! [[String:Any]]
        
        
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
        //view_top.layer.cornerRadius = 5.0
        
        self.func_GetProfiledata()
        
        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_GetProfiledata() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"astrologer_id":user_id ,"astrologer_api_key":user_apikey]
        
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
                                            
                                            
                                            personaldetailss = tempDict["data"] as! [String:Any]
                                            print("personaldetailss is:- ",personaldetailss)
                                            
                                            //  self.AstrocatArray = personaldetailss["astrologer_category"] as! NSArray
                                            
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
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if section == 0
        {
            return 1
        }
        else  if section == 1
        {
            return 1
        }
        else  if section == 2
        {
            return 1
        }
        else  if section == 3
        {
            return 1
        }
        else  if section == 4
        {
            return 1
        }
        else
        {
            return arrReviews.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.section == 0
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell_Add.colletionCategoryyy.tag=2
            cell_Add.colletionCategoryyy.reloadData()
             cell_Add.img_profile.layer.cornerRadius = cell_Add.img_profile.frame.size.height/2
            
            if AstrologerFullData.count != 0
            {
                      let Image = AstrologerFullData["astrologers_image_url"] as! String
                      let name = AstrologerFullData["astrologers_name"] as! String
                      let lang = AstrologerFullData["language_name"] as! String
                      let exp = AstrologerFullData["astrologers_experience"] as! String
                
                      let capStr = name.capitalized
                     // let string = LanguageArray.componentsJoined(by: ",")
                
                        if chatcallingFormmm == "Chat"
                        {
                          let time = AstrologerFullData["astro_online_chat_time"] as! String
                          let date = AstrologerFullData["astro_online_chat_date"] as! String
                          
                          if time == ""
                          {
                            cell_Add.lbl_onlinetime.text = "Online"
                          }
                          else
                          {
                            cell_Add.lbl_onlinetime.text = date + " ," + time
                           
                          }
                            
                            
                        }
                        if chatcallingFormmm == "Calling"
                        {
                           let time = AstrologerFullData["astro_call_online_time"] as! String
                           let date = AstrologerFullData["astro_call_online_date"] as! String
                            if time == ""
                            {
                                cell_Add.lbl_onlinetime.text = "Online"
                            }
                            else
                            {
                                cell_Add.lbl_onlinetime.text = date + " ," + time
                                
                            }
                        }

                      
                cell_Add.img_profile.sd_setImage(with: URL(string: Image), placeholderImage: UIImage(named: placeHolderImg))
                      cell_Add.lbl_name.text = capStr
                      cell_Add.lbl_exp.text = exp + " Years"
                      cell_Add.lbl_language.text = lang
                
            }
            
            
            
            return cell_Add
        }
        else if indexPath.section == 1
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "AbountUsCell1", for: indexPath) as! AbountUsCell1
            
            return cell_Add
        }
        else if indexPath.section == 2
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "AbountUsCell", for: indexPath) as! AbountUsCell
            let biography = AstrologerFullData["astrologers_long_biography"] as? String ?? ""
            cell_Add.lbl_Packagetitle.attributedText =  biography.htmlToAttributedString
            return cell_Add
        }
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
            cell_Add.taskProgress1.trackTintColor = UIColor.init(red: 239/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
            cell_Add.taskProgress1.tintColor = UIColor.init(red: 255/255.0, green: 123/255.0, blue: 24/255.0, alpha: 1.0)
            cell_Add.taskProgress2.setProgress(Progress2, animated: true)
            cell_Add.taskProgress2.trackTintColor = UIColor.init(red: 239/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
            cell_Add.taskProgress2.tintColor = UIColor.init(red: 255/255.0, green: 123/255.0, blue: 24/255.0, alpha: 1.0)
            cell_Add.taskProgress3.setProgress(Progress3, animated: true)
            cell_Add.taskProgress3.trackTintColor = UIColor.init(red: 239/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
            cell_Add.taskProgress3.tintColor = UIColor.init(red: 255/255.0, green: 123/255.0, blue: 24/255.0, alpha: 1.0)
            cell_Add.taskProgress4.setProgress(Progress4, animated: true)
            cell_Add.taskProgress4.trackTintColor = UIColor.init(red: 239/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
            cell_Add.taskProgress4.tintColor = UIColor.init(red: 255/255.0, green: 123/255.0, blue: 24/255.0, alpha: 1.0)
            cell_Add.taskProgress5.setProgress(Progres5, animated: true)
            cell_Add.taskProgress5.trackTintColor = UIColor.init(red: 239/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.0)
            cell_Add.taskProgress5.tintColor = UIColor.init(red: 255/255.0, green: 123/255.0, blue: 24/255.0, alpha: 1.0)
            let rating = AstrologerFullData["rating"] as! String
            let avrageRating = AstrologerFullData["avrageRating"] as! String
            let reviewrating = Int(avrageRating)
            cell_Add.lbl_totalreviews.text = rating + " " + "Total"
            cell_Add.lbl_reviews.text = avrageRating
            if reviewrating == 0
            {
                cell_Add.img_1.image = UIImage(named: "stargray")
                cell_Add.img_2.image = UIImage(named: "stargray")
                cell_Add.img_3.image = UIImage(named: "stargray")
                cell_Add.img_4.image = UIImage(named: "stargray")
                cell_Add.img_5.image = UIImage(named: "stargray")
            }
            if reviewrating == 1
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "stargray")
                cell_Add.img_3.image = UIImage(named: "stargray")
                cell_Add.img_4.image = UIImage(named: "stargray")
                cell_Add.img_5.image = UIImage(named: "stargray")
               // cell_Add.lbl_line1.isHidden = false
            }
            if reviewrating == 2
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "star")
                cell_Add.img_3.image = UIImage(named: "stargray")
                cell_Add.img_4.image = UIImage(named: "stargray")
                cell_Add.img_5.image = UIImage(named: "stargray")
               // cell_Add.lbl_line2.isHidden = false
            }
            if reviewrating == 3
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "star")
                cell_Add.img_3.image = UIImage(named: "star")
                cell_Add.img_4.image = UIImage(named: "stargray")
                cell_Add.img_5.image = UIImage(named: "stargray")
               // cell_Add.lbl_line3.isHidden = false
            }
            if reviewrating == 4
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "star")
                cell_Add.img_3.image = UIImage(named: "star")
                cell_Add.img_4.image = UIImage(named: "star")
                cell_Add.img_5.image = UIImage(named: "stargray")
               // cell_Add.lbl_line4.isHidden = false
            }
            if reviewrating == 5
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "star")
                cell_Add.img_3.image = UIImage(named: "star")
                cell_Add.img_4.image = UIImage(named: "star")
                cell_Add.img_5.image = UIImage(named: "star")
               // cell_Add.lbl_line5.isHidden = false
            }
            return cell_Add
        }
        else
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
           
            
            let dict_eventpoll = self.arrReviews[indexPath.row]
            let username = dict_eventpoll["username"] as! String
            let rating1 = dict_eventpoll["review_rating"] as! String
            
                if let getImage = dict_eventpoll["customer_image_url"] as? String {
                    cell_Add.img_User.sd_setImage(with: URL(string: getImage), placeholderImage: UIImage(named: placeHolderImg))
                } else {
                    cell_Add.img_User.image = UIImage(named:placeHolderImg)
                }
                    
            let reviewrating = Int(rating1)
            let date = dict_eventpoll["created_at"] as! String
            let description = dict_eventpoll["review_comment"] as! String
            
            cell_Add.lbl_Username.text = username
            cell_Add.lbl_date.text = date
            cell_Add.lbl_description.text = description
            
            if reviewrating == 0
            {
                cell_Add.img_1.image = UIImage(named: "stargray")
                cell_Add.img_2.image = UIImage(named: "stargray")
                cell_Add.img_3.image = UIImage(named: "stargray")
                cell_Add.img_4.image = UIImage(named: "stargray")
                cell_Add.img_5.image = UIImage(named: "stargray")
            }
            if reviewrating == 1
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "stargray")
                cell_Add.img_3.image = UIImage(named: "stargray")
                cell_Add.img_4.image = UIImage(named: "stargray")
                cell_Add.img_5.image = UIImage(named: "stargray")
            }
            if reviewrating == 2
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "star")
                cell_Add.img_3.image = UIImage(named: "stargray")
                cell_Add.img_4.image = UIImage(named: "stargray")
                cell_Add.img_5.image = UIImage(named: "stargray")
            }
            if reviewrating == 3
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "star")
                cell_Add.img_3.image = UIImage(named: "star")
                cell_Add.img_4.image = UIImage(named: "stargray")
                cell_Add.img_5.image = UIImage(named: "stargray")
            }
            if reviewrating == 4
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "star")
                cell_Add.img_3.image = UIImage(named: "star")
                cell_Add.img_4.image = UIImage(named: "star")
                cell_Add.img_5.image = UIImage(named: "stargray")
            }
            if reviewrating == 5
            {
                cell_Add.img_1.image = UIImage(named: "star")
                cell_Add.img_2.image = UIImage(named: "star")
                cell_Add.img_3.image = UIImage(named: "star")
                cell_Add.img_4.image = UIImage(named: "star")
                cell_Add.img_5.image = UIImage(named: "star")
            }
            
            
            return cell_Add
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
    
    
}
class ReviewsCell: UITableViewCell {
    
    
}
class ReviewsPageCell: UITableViewCell {
    

    @IBOutlet weak var img_1: UIImageView!
    @IBOutlet weak var img_2: UIImageView!
    @IBOutlet weak var img_3: UIImageView!
    @IBOutlet weak var img_4: UIImageView!
    @IBOutlet weak var img_5: UIImageView!
    @IBOutlet weak var lbl_reviews: UILabel!
    @IBOutlet weak var lbl_totalreviews: UILabel!
    
    
    @IBOutlet weak var taskProgress1:UIProgressView!
    @IBOutlet weak var taskProgress2:UIProgressView!
    @IBOutlet weak var taskProgress3:UIProgressView!
    @IBOutlet weak var taskProgress4:UIProgressView!
    @IBOutlet weak var taskProgress5:UIProgressView!
    
}
class ReviewsPageListCell: UITableViewCell {
    
    @IBOutlet weak var img_User: UIImageView!
    @IBOutlet weak var img_1: UIImageView!
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
