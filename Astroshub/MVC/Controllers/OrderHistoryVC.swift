//
//  OrderHistoryVC.swift
//  Astroshub
//
//  Created by Kriscent on 05/03/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage
class OrderHistoryVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{

    @IBOutlet var tbl_orderHistory: UITableView!
    var arrHistoryList = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl_orderHistory.isHidden = true
        self.orderhistoryApiCallMethods()

        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    
    

    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func orderhistoryApiCallMethods() {
           
           
           let deviceID = UIDevice.current.identifierForVendor!.uuidString
           print(deviceID)
           let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id]
           print(setparameters)
           //ActivityIndicator.shared.startLoading()
           AutoBcmLoadingView.show("Loading......")
           AppHelperModel.requestPOSTURL(MethodName.ViewProductEnquiryShop.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                         success: { (respose) in
                                           AutoBcmLoadingView.dismiss()
                                           let tempDict = respose as! NSDictionary
                                           print(tempDict)
                                           
                                           let success=tempDict["response"] as!   Bool
                                           let message=tempDict["msg"] as!   String
                                           
                                           if success == true
                                           {
                                               self.arrHistoryList = [[String:Any]]()
                                            
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                               
                                               
                                            if let arrSliderImages = dict_Data["user_id"] as? [[String:Any]]
                                            {
                                                self.arrHistoryList = arrSliderImages
                                            }
                                            print("arrWaletList is:- ",self.arrHistoryList)
                                            
                                               
                                               
                                               self.tbl_orderHistory.reloadData()
                                               self.tbl_orderHistory.isHidden = false
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
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.arrHistoryList.count
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        
        let cell_User3 = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryCellN", for: indexPath) as! OrderHistoryCellN
        
        cell_User3.img_product.layer.cornerRadius = cell_User3.img_product.frame.size.height/2
               
        cell_User3.img_product.clipsToBounds = true
        
        let dict_eventpoll = self.arrHistoryList[indexPath.row]
        let PName = dict_eventpoll["product_name"] as! String
        let Title = dict_eventpoll["title"] as! String
        let Image = dict_eventpoll["product_image_url"] as! String
        let Subject = dict_eventpoll["enquiry_subject"] as! String
        let Name = dict_eventpoll["enquiry_person_name"] as! String
        let Email = dict_eventpoll["enquiry_person_email"] as! String
        let Phone = dict_eventpoll["enquiry_person_phone"] as! String
        let Message = dict_eventpoll["enquiry_person_message"] as! String
        
        cell_User3.lbl1.text = PName
        cell_User3.lbl2.text = Title
        cell_User3.lbl3.text = Subject
        cell_User3.lbl4.text = Name
        cell_User3.lbl5.text = Email
        cell_User3.lbl6.text = Phone
        cell_User3.lbl7.text = Message
        
        
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = cell_User3.img_product.center
        activityIndicator.hidesWhenStopped = true
        cell_User3.img_product.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        cell_User3.img_product.sd_setImage(with: URL(string: Image), completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
            activityIndicator.removeFromSuperview()
        })
       
        return cell_User3
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    

    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    

}
class OrderHistoryCellN: UITableViewCell {
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var img_product: UIImageView!
    
    
    // Initialization code
}
