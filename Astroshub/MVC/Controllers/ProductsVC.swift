//
//  ProductsVC.swift
//  Astroshub
//
//  Created by Kriscent on 10/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage

class ProductsVC: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var buttonInfo: UIButton!
    @IBOutlet weak var viewNote: UIView!
    @IBOutlet weak var constraintNoteHeight: NSLayoutConstraint!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet var tbl_productcategory: UITableView!
    @IBOutlet var txt_search: UITextField!
    var arrProductcategory = [[String:Any]]()
    var categoryID = ""
    var notes = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ProductCategoryApiCallMethods()
        self.setNote()
        // Do any additional setup after loading the view.
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    func setNote() {
        //        if self.categoryID == "9" || self.categoryID == "8" || self.categoryID == "6" || self.categoryID == "4" || self.categoryID == "3" || self.categoryID == "2" {
        //            self.buttonInfo.isHidden = false
        //        } else {
        //            self.buttonInfo.isHidden = true
        //        }
        
        // past life regresstion = 9, graphology = 8, online vastu service = 7, birthtime = 6, yantras = 4, rudraksha = 3 , gemstone 2,
        switch self.categoryID {
        case "2":
            self.lblNote.text = "Note:- These are sample products, actual product may vary a little bit, but the quality of the stones will be same. All the prices mention are on the basis of per Ratti"
        case "6":
            self.lblNote.text = "Note :-You will get a call from our expert astrologer in 3-5 days after the confirmation of payment."
        case "8":
            self.lblNote.text = "Note:-You will get the report in 3-5 days on your provided e-mail."
        case "9":
            self.lblNote.text = "Note:-You will get a call from our astrologer within 24 hours after the confirmation of payment"
        case "7":
            self.lblNote.text = "Note:-For online map consulting, the customer has to provide a proper map of their house and add sample report on Vastu services"
        default:
            self.viewNote.isHidden = true
            self.lblNote.text = ""
            self.constraintNoteHeight.constant = 0
        }
    }
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func ProductCategoryApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"category":catyegoryIDD,"search":txt_search.text as Any] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("products", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            self.arrProductcategory = [[String:Any]]()
                                            
                                            if let arrtimeslot = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrProductcategory = arrtimeslot
                                            }
                                            print("arrProductcategory is:- ",self.arrProductcategory)
                                            
                                            self.tbl_productcategory.reloadData()
                                            
                                            
                                            
                                        }
                                        
                                        else
                                        {
                                            self.arrProductcategory = [[String:Any]]()
                                            self.tbl_productcategory.isHidden = true
                                            
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                        }
                                        
                                        
                                      }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    func ProductCategoryApiCallMethods1() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"category":catyegoryIDD,"search":txt_search.text ?? ""] as [String : Any]
        
        print(setparameters)
        // AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("products", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        // let message=tempDict["msg"] as!   String
                                        
                                        if success == true {
                                            self.arrProductcategory = [[String:Any]]()
                                            if let arrtimeslot = tempDict["data"] as? [[String:Any]]
                                            {
                                                self.arrProductcategory = arrtimeslot
                                            }
                                            print("arrProductcategory is:- ",self.arrProductcategory)
                                            self.tbl_productcategory.isHidden = false
                                            self.tbl_productcategory.reloadData()
                                            
                                        }else {
                                            self.arrProductcategory = [[String:Any]]()
                                            self.tbl_productcategory.isHidden = true
                                            //CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                        }
                                      }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    
    
    @IBAction func btnInfoAction(_ sender: Any) {
        let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.categoryID = categoryID
        modalViewController.notes = self.notes
        self.present(modalViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func txt_Search(_ sender: Any)
    {
        self.ProductCategoryApiCallMethods1()
    }
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProductcategory.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell_Add.img_user.layer.cornerRadius = cell_Add.img_user.frame.size.height/2
        cell_Add.img_user.clipsToBounds = true
        cell_Add.btnEnquiry.layer.cornerRadius = 6.0
        cell_Add.btnEnquiry.tag = indexPath.row
        cell_Add.btnEnquiry.addTarget(self, action: #selector(self.btn_Enquiry(_:)), for: .touchUpInside)
        cell_Add.view1.layer.shadowColor = UIColor.lightGray.cgColor
        cell_Add.view1.layer.shadowOpacity = 5.0
        cell_Add.view1.layer.shadowRadius = 5.0
        cell_Add.view1.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        cell_Add.view1.layer.masksToBounds = false
        cell_Add.view1.layer.cornerRadius = 5.0
        cell_Add.img_user.kf.indicatorType = .activity
        let dict_eventpoll = self.arrProductcategory[indexPath.row]
        let Name = dict_eventpoll["product_name"] as! String
        let Description = dict_eventpoll["description"] as! String
        let Image = dict_eventpoll["product_image"] as! String
        
        cell_Add.lbl1.text = Name
        if CurrentLocation == "India" {
            cell_Add.lbl2.text =  "₹ \(dict_eventpoll["price_inr"] as! String)"
        } else {
            cell_Add.lbl2.text = "$ \(dict_eventpoll["price_dollar"] as! String)"
            
        }
        cell_Add.lbl3.text = Description.htmlToString
        
        cell_Add.labelCategory.text = dict_eventpoll["product_category_name"] as? String
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = cell_Add.img_user.center
        activityIndicator.hidesWhenStopped = true
        cell_Add.img_user.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        cell_Add.img_user.sd_setImage(with: URL(string: Image), completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
            activityIndicator.removeFromSuperview()
        })
        return cell_Add
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //tbl_productcategory.deselectRow(at: indexPath as IndexPath, animated: true)
        //let EnquiryShop = self.storyboard?.instantiateViewController(withIdentifier: "EnquiryShopVC")
        //self.navigationController?.pushViewController(EnquiryShop!, animated: true)
    }
    
    @objc func btn_Enquiry(_ sender: UIButton){
        if self.PerformActionIfLogin(changeMessage: true) {
            let dict_eventpoll = self.arrProductcategory[sender.tag]
            productcatyegoryIDD = dict_eventpoll["productid"] as! String
            let EnquiryShop = self.storyboard?.instantiateViewController(withIdentifier: "EnquiryShopVC") as! EnquiryShopVC
            EnquiryShop.arrProductcategory = dict_eventpoll
            self.navigationController?.pushViewController(EnquiryShop, animated: true)
        }
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
}
class ProductCell: UITableViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var btnEnquiry: UIButton!
    
    @IBOutlet weak var labelCategory: UILabel!
    
}
