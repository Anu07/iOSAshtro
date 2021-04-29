//
//  SpeclistViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 17/12/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import MapKit
class SpeclistViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MKMapViewDelegate {
        @IBOutlet var txt_search: UITextField!
        @IBOutlet weak var view_top: UIView!
        @IBOutlet var tbl_talklist: UITableView!
        var arrTalk = [[String:Any]]()
    var speclist:Array<Any>?
        let kMaxItemCount = 1000
        let kPageLength   = 10
        var items: [Int] = []
        var isSearchingEnable = false
        var page = 0
        var pagereload = 0
        var url_flag = 1
        var index_value = 0
        
        var refreshController = UIRefreshControl()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            refreshController.addTarget(self, action:#selector(handleRefresh(_:)), for: .valueChanged)
            tbl_talklist.addSubview(refreshController)
        }
        
        @objc func handleRefresh(_ sender: Any?)
        {
            print("Pull To Refresh Method Called")
            page = 0
            pagereload = 0
            url_flag = 1
            refreshController.endRefreshing()
        }
        func fetchDataFromStart(completion handler:@escaping (_ fetchedItems: [Int])->Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2)
            {
                let fetchedItems = Array(0..<self.kPageLength)
                handler(fetchedItems)
            }
        }
        
        func getCategoryString(data:[[String:Any]]) -> String {
            var category = ""
            for value in data {
                if let getString = value["master_category_title"] as? String {
                    category = category + getString + ","
                }
            }
            return category
        }
        
        func fetchMoreData(completion handler:@escaping (_ fetchedItems: [Int])->Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if self.items.count >= self.kMaxItemCount {
                    handler([])
                    return
                }
                
                let fetchedItems = Array(self.items.count..<(self.items.count + self.kPageLength))
                handler(fetchedItems)
            }
        }
       
      
        
        @IBAction func btn_backAction(_ sender: Any)
        {
            self.navigationController?.popViewController(animated: true)
        }
        @IBAction func txt_Search(_ sender: Any)
        {
        }
        //****************************************************
        // MARK: - Tableview Method
        //****************************************************
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            return 150
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            
            return self.speclist?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "SpecalistListCell", for: indexPath) as! SpecalistListCell
            
            cell_Add.view_back.layer.shadowColor = UIColor.lightGray.cgColor
            cell_Add.view_back.layer.shadowOpacity = 5.0
            cell_Add.view_back.layer.shadowRadius = 5.0
            cell_Add.view_back.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
            cell_Add.view_back.layer.masksToBounds = false
            cell_Add.view_back.layer.cornerRadius = 5.0
         
            cell_Add.btnBookNow.tag = indexPath.row
            cell_Add.btnBookNow.addTarget(self, action: #selector(self.btn_bookNow(_:)), for: .touchUpInside)
            print(speclist ?? [])
            let dict_eventpoll = self.speclist?[indexPath.row] as! [String:Any]
            var category = ""
            if let getCategoryArray = dict_eventpoll["category_arr"] as? [[String:Any]] {
                category = self.getCategoryString(data: getCategoryArray)
            }
            let varify = dict_eventpoll["verify"] as? String ?? ""
            let name =   dict_eventpoll["astrologers_name"] as? String ?? ""
            let exp =    dict_eventpoll["astrologers_experience"] as? String ?? ""
            let desc =   dict_eventpoll["astro_product_package"] as? [String:Any]
//            if desc == nil {
            let price1 = desc?["inr_price"] as? String ?? ""
            let price2 = desc?["doller_price"] as? String ?? ""
            cell_Add.lbl_Category.text = desc?["description_price"] as? String ?? ""
                if CurrentLocation == "India"
                {
                    cell_Add.labelLng.text = rupee + String(price1)
                } else {
                    cell_Add.labelLng.text = "$" + String(price2)
                }
//            } else {
//                let price1 = desc?["inr_price"] as? String ?? ""
//                let price2 = desc?["doller_price"] as? String ?? ""
//                cell_Add.lbl_Category.text = desc?["description_price"] as? String ?? ""
//                if CurrentLocation == "India"
//                {
//                    cell_Add.labelLng.text = rupee + String(price1)
//                } else {
//                    cell_Add.labelLng.text = "$" + String(price2)
//                }
//            }
            
            let imagee = dict_eventpoll["astrologers_image_url"] as? String ?? ""
            let rating = dict_eventpoll["avrageRating"] as? String ?? ""
            let Rating = dict_eventpoll["rating"] as? String ?? ""
            let rating1 = Double(rating)
            
            print(rating1 ?? "nil")
            
            //let avvv = name.uppercased
            cell_Add.labellanguage.text =  dict_eventpoll["astrologers_language"] as? String ?? ""
//            cell_Add.labelDesc.text = ""

            let capStr = name.capitalized
            
            // let m = name.firstCharacterUpperCase()
            
            let rating2 = Int(rating1!)
            
            print(rating2)
            cell_Add.lbl_total.text = "\(rating1 ?? 0.0) (\(Rating))"
            cell_Add.img_User.sd_setImage(with: URL(string: imagee), placeholderImage:#imageLiteral(resourceName: "userdefault"))

            cell_Add.lbl_Username.text = capStr
            
            //  cell_Add.img_varify.isHidden = true
            if varify == "0"
            {
                // cell_Add.img_varify.isHidden = true
                
                cell_Add.img_varify.image = #imageLiteral(resourceName: "checked")
            }
            if varify == "1"
            {
                // cell_Add.img_varify.isHidden = false
                cell_Add.img_varify.image = #imageLiteral(resourceName: "checked")
            }
            cell_Add.ratingView.rating = rating1 ?? 0.0
            cell_Add.ratingView.editable = false
            return cell_Add
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            //AstrologerUniID
            
        }
        @objc func buttonShareAction(sender:UIButton) {
            let text = ""
            let shareAll = [text ] as [Any]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
       
    @objc func btn_bookNow(_ sender: UIButton)
    {
        if self.PerformActionIfLogin(changeMessage: true) {
            let dict_eventpoll = self.speclist?[sender.tag] as? [String:Any]
            let desc = dict_eventpoll?["astro_product_package"] as? [String:Any]
            
            let EnquiryShop = self.storyboard?.instantiateViewController(withIdentifier: "EnquiryShopVC") as! EnquiryShopVC
            if desc == nil {
            productcatyegoryIDD = desc?["astrologers_id"] as! String
                EnquiryShop.getTotalPrice = dict_eventpoll?["package_inr_price"] as? String ?? ""
            } else {
                productcatyegoryIDD = desc?["product_id"] as! String
                EnquiryShop.getTotalPrice = dict_eventpoll?["inr_price"] as? String ?? ""

            }
          
            EnquiryShop.bookNowVar = "bookSpec"
            EnquiryShop.arrProductcategory = dict_eventpoll ?? [:]
            self.navigationController?.pushViewController(EnquiryShop, animated: true)
        }
        
      
    }
    
    @objc func btn_CallRequest(_ sender: UIButton)
    {
        if self.PerformActionIfLogin(changeMessage: true) {
            let dict_eventpoll = self.speclist?[sender.tag] as? [String:Any]
            productcatyegoryIDD = dict_eventpoll?["astrologers_id"] as! String
            let EnquiryShop = self.storyboard?.instantiateViewController(withIdentifier: "EnquiryShopVC") as! EnquiryShopVC
            EnquiryShop.arrProductcategory = dict_eventpoll ?? [:]
//            EnquiryShop.productid = categoryID
            EnquiryShop.bookNowVar = "call"
            self.navigationController?.pushViewController(EnquiryShop, animated: true)
        }
    }
        
        @objc func btn_Profile(_ sender: UIButton)
        {
            let dict_eventpoll = self.arrTalk[sender.tag]
            
            chatcallingFormmm = "Calling"
            //AstrologerUniID = dict_eventpoll["astrologers_uni_id"] as! String
            //Astrologer_apikey = dict_eventpoll["astrologers_uni_id"] as! String
            AstrologerFullData = dict_eventpoll
            let NewProfile = self.storyboard?.instantiateViewController(withIdentifier: "NewProfileVC")
            self.navigationController?.pushViewController(NewProfile!, animated: true)
        }
        //****************************************************
        // MARK: - Memory CleanUP
        //****************************************************
        
        
    }

    extension SpeclistViewController {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
            if text == "", isSearchingEnable {
                self.isSearchingEnable = true
            }
                    if text.count >= 3 {
                        self.isSearchingEnable = true
                        self.page = 0
                        self.arrTalk.removeAll()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        }
            
                    } else if text.count == 2 {
                        if isSearchingEnable {
                            self.isSearchingEnable = false
                            self.page = 0
                            self.arrTalk.removeAll()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            }
                        }
                    }
            return true
        }
    }


    class SpecalistListCell: UITableViewCell {
        @IBOutlet weak var imageTag: UIImageView!
        @IBOutlet weak var labelForTag: UILabel!
        @IBOutlet weak var view_back: UIView!
        @IBOutlet weak var img_User: UIImageView!
        @IBOutlet weak var lbl_Username: UILabel!
        @IBOutlet weak var lbl_Category: UILabel!
        @IBOutlet weak var lbl_total: UILabel!
        @IBOutlet weak var btnCall: UIButton!
        @IBOutlet weak var lbl_exp: UILabel!
        @IBOutlet weak var lbl_price: UILabel!
        @IBOutlet weak var img_varify: UIImageView!
        @IBOutlet weak var btnProfile: UIButton!

        @IBOutlet weak var labellanguage: UILabel!
        @IBOutlet weak var labelDesc: UILabel!
        @IBOutlet weak var btnBookNow: UIButton!
        @IBOutlet weak var buttonCallRequest: UIButton!
        @IBOutlet weak var labelLng: UILabel!
        @IBOutlet weak var ratingView: FloatRatingView!
    }
//    extension String {
//        func capitalizingFirstLetter() -> String {
//            return prefix(1).uppercased() + self.lowercased().dropFirst()
//        }
//
//        mutating func capitalizeFirstLetter() {
//            self = self.capitalizingFirstLetter()
//        }
//    }
//
//
//    class EstimatePriceModel {
//        var name = ""
//        var charge = ""
//        var balance = ""
//        var number = ""
//        var timeInHours = ""
//    }
//
//    extension AstroTalkListVC {
//        func NotifyCallMethods(_ astroId:String) {
//
//
//            let deviceID = UIDevice.current.identifierForVendor!.uuidString
//            print(deviceID)
//            let setparameters = ["app_type":MethodName.APPTYPE.rawValue,
//                                 "app_version":MethodName.APPVERSION.rawValue,
//                                 "user_api_key":user_apikey,
//                                 "user_id":user_id,"astrologer_id":astroId,"request_type":"call"] as [String : Any]
//            print(setparameters)
//            AutoBcmLoadingView.show("Loading......")
//            AppHelperModel.requestPOSTURL("astroNotifyMe", params: setparameters as [String : AnyObject],headers: nil,
//                                          success: { (respose) in
//                                            AutoBcmLoadingView.dismiss()
//                                            let tempDict = respose as! NSDictionary
//                                            print(tempDict)
//
//                                            let success=tempDict["response"] as!   Bool
//                                            let message=tempDict["msg"] as!   String
//
//                                            if success == true
//                                            {
//
//                                            }
//
//            }) { (error) in
//                AutoBcmLoadingView.dismiss()
//            }
//
//
//
//        }
//
//    }
