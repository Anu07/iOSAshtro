//
//  ProductCategoryVC.swift
//  Astroshub
//
//  Created by Kriscent on 10/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCategoryVC: UIViewController , UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var tbl_productcategory: UITableView!
    @IBOutlet var colllectionproduct: UICollectionView!
    @IBOutlet var txt_search: UITextField!
    var arrProductcategory = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ProductCategoryApiCallMethods()
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func ProductCategoryApiCallMethods() {
           
           let deviceID = UIDevice.current.identifierForVendor!.uuidString
           print(deviceID)
          let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"search":txt_search.text as Any] as [String : Any]
           
           print(setparameters)
           AutoBcmLoadingView.show("Loading......")
           AppHelperModel.requestPOSTURL("productCategory", params: setparameters as [String : AnyObject],headers: nil,
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
                                            
//                                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//                                                self.tbl_productcategory.reloadData()
//                                                self.tbl_productcategory.isHidden = false
//                                            }

                                            self.colllectionproduct.reloadData()
                                               

                                               
                                           }
                                               
                                           else
                                           {
                                                  self.arrProductcategory = [[String:Any]]()
                                                   self.colllectionproduct.isHidden = true
                                               
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
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"search":txt_search.text ?? ""] as [String : Any]
           
           print(setparameters)
           //AutoBcmLoadingView.show("Loading......")
           AppHelperModel.requestPOSTURL("productCategory", params: setparameters as [String : AnyObject],headers: nil,
                                         success: { (respose) in
                                           AutoBcmLoadingView.dismiss()
                                           let tempDict = respose as! NSDictionary
                                           print(tempDict)
                                           let success=tempDict["response"] as!   Bool
                                          // let message=tempDict["msg"] as!   String
                                           
                                           if success == true
                                           {
                                               //self.tbl_productcategory.isHidden = false
                                               self.arrProductcategory = [[String:Any]]()
                                               if let arrtimeslot = tempDict["data"] as? [[String:Any]]
                                               {
                                                   self.arrProductcategory = arrtimeslot
                                               }
                                               print("arrProductcategory is:- ",self.arrProductcategory)

                                               self.colllectionproduct.reloadData()
                                               

                                               
                                           }
                                               
                                           else
                                           {
                                                  self.arrProductcategory = [[String:Any]]()
                                                  self.colllectionproduct.isHidden = true
                                               
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

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//
//        return 51
//
//    }
//
  
    
    
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
    //****************************************************
    // MARK: - Collectionview Method
    //****************************************************
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.arrProductcategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionCell
        let dict_eventpoll = self.arrProductcategory[indexPath.row]
        let name = dict_eventpoll["name"] as! String
        let image = dict_eventpoll["image"] as! String
        cell.imgall.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "Placeholder.png"))
        cell.lbltitle.text =  name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width)/2.2   , height: (collectionView.bounds.size.width)/2.2);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict_eventpoll = self.arrProductcategory[indexPath.row]
         catyegoryIDD = dict_eventpoll["id"] as! String
        let Products = self.storyboard?.instantiateViewController(withIdentifier: "ProductsVC") as! ProductsVC
        Products.categoryID = catyegoryIDD
        Products.notes = dict_eventpoll["notes"] as? String ?? ""
        self.navigationController?.pushViewController(Products, animated: true)
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************

}
class ProductCategoryCell: UITableViewCell {
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var img_user: UIImageView!
    

    // Initialization code
}
