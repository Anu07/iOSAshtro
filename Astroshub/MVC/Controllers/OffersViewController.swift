//
//  OffersViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 11/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
enum forChatSide {
    case chat
    case recharge
}


class OffersViewController: UIViewController {
    
    
    @IBOutlet weak var myoffer: UILabel!
    @IBOutlet weak var coolectionMyOofers: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coll1HeightContraint: NSLayoutConstraint!
    var arrCouponList = [[String:Any]]()
    @IBOutlet weak var pageControlHigh: NSLayoutConstraint!
    var dataStatus =  Array<Any>()
    var datacouponList =  Array<Any>()
    var screenCome:forChatSide?
    var completionHandler:(([String : Any]) -> [String : Any])?
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        tableView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
        self.collectionView.isPagingEnabled = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        //        self.collectionView.
        //                 self.collectionView.reloadData()
        //        self.coolectionMyOofers.reloadData()
        if screenCome == .recharge{
            self.collectionView.isHidden = false
            self.coolectionMyOofers.isHidden = true
            getCouponListApiCallMethods()
            myoffer.isHidden = true
            
            
        } else{
            self.collectionView.isHidden = false
            self.coolectionMyOofers.isHidden = false
            apiForGetmytras()
            myoffer.isHidden = false
            
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func apiForGetmytras() {
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey,"user_id":user_id] 
        
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.coupon.rawValue, params:setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            self.dataStatus = dict_Data["get_customer_private_coupon"] as! Array<Any>
                                            
                                            self.datacouponList = dict_Data["coupon_list"] as! Array<Any>
                                            if self.datacouponList.count == 0 {
                                                self.coll1HeightContraint.constant = 0
                                                self.pageControlHigh.constant = 0
                                                self.pageControl.isHidden = true
                                                self.coll1HeightContraint?.isActive = true
                                                
                                            } else {
                                                self.coll1HeightContraint.constant = 130.0
                                                self.pageControlHigh.constant = 30.0
                                                self.coll1HeightContraint?.isActive = true
                                                self.pageControl.isHidden = false
                                                
                                                
                                            }
                                            self.collectionView.reloadData()
                                            self.coolectionMyOofers.reloadData()
                                            
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
    func getCouponListApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("getCouponList", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            
                                            if let arrcoupon = dict_Data["Couponslist"] as? [[String:Any]]
                                            {
                                                self.arrCouponList = arrcoupon
                                            }
                                            if self.arrCouponList.count == 0{
                                                self.pageControlHigh.constant = 0
                                                self.pageControl.isHidden = true
                                            } else{
                                                self.pageControlHigh.constant = 30.0
                                                self.pageControl.isHidden = false
                                            }
                                            print("arrCouponList is:- ",self.arrCouponList)
                                            self.collectionView.reloadData()
                                            
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
    
    func applycouponcodeApiCallMethods() {
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"coupon_code":CouponCode,"amount":OnTabWalletAmount,"location":CurrentLocation]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("applyCouponCode", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            
                                            CouponDiscountAmount = dict_Data["coupon_discount_amt"] as! String
                                            //TotalDiscount = dict_Data["coupon_discount_amt"] as! Float
                                            CouponApplyID = dict_Data["coupon_apply_id"] as! Int
                                            CouponID = dict_Data["coupon_id"] as! String
                                            RemainingDiscountAmount = dict_Data["remainingAmount"] as! String
                                            
                                            //OnTabWalletAmount = RemainingDiscountAmount
                                            
                                            self.navigationController?.popViewController(animated: true)
                                            // CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
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
    
}
//extension OffersViewController:UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return  self.dataStatus.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell", for: indexPath) as! OffersTableViewCell
//        let data = self.dataStatus[indexPath.row] as! [String:Any]
//        cell.labelOfferName.text = "Coupon Code:  \(data["coupon_code"] as! String)"
//        cell.labelDate.text = "Valid Till : \(data["coupon_expiry_date"] as! String)"
//        cell.labelForDesc.text =  "\(data["coupon_description"] as? String ?? "")" 
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.01
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                let data = self.dataStatus[indexPath.row] as! [String:Any]
//        //        idForMantras = data["id"] as? String
//        //        self.tableView.reloadData()
//        self.completionHandler!(data)
//        self.navigationController?.popViewController(animated: false)
//
//    }
//}
extension OffersViewController : UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        switch screenCome {
        case .recharge:
            return self.arrCouponList.count
        default:
            if collectionView == coolectionMyOofers {
                return  self.dataStatus.count
            } else {
                return  self.datacouponList.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        switch screenCome {
        case .recharge:
            let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyOffersCollectionViewCell", for: indexPath) as! MyOffersCollectionViewCell
            let dict_coupon = self.arrCouponList[indexPath.row]
            collCell.label1.text = dict_coupon["coupon_code"] as? String
            collCell.label2.text = dict_coupon["coupon_description"] as? String
            collCell.label3.text = "Valid Till : \(dict_coupon["valid_to"] as? String ?? "")"
            self.pageControl.numberOfPages = self.arrCouponList.count
            return collCell
        default:
            if collectionView == coolectionMyOofers {
                let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionMyOffers", for: indexPath) as! OffersCollectionViewCell
                let data = dataStatus[indexPath.row] as! [String:Any]
                collCell.labelForName.text = data["coupon_code"] as? String
                collCell.labelDesc.text = data["coupon_description"] as? String
                
                return collCell
            } else {
                let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyOffersCollectionViewCell", for: indexPath) as! MyOffersCollectionViewCell
                let data = datacouponList[indexPath.row] as! [String:Any]
                collCell.label1.text = data["coupon_code"] as? String
                collCell.label2.text = data["coupon_description"] as? String
                collCell.label3.text = "Valid Till : \(data["coupon_expiry_date"] as? String ?? "")"
                self.pageControl.numberOfPages = self.datacouponList.count
                return collCell
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == coolectionMyOofers {
        if  self.dataStatus.count == 0 {
            
        }else{
            guard let data = self.dataStatus[indexPath.row] as? [String:Any] else {
                return
            }
            if screenCome == .chat {
                if collectionView == coolectionMyOofers {
                    self.completionHandler!(data)        } else {
                        //                    self.completionHandler!(dataCoupon)
                        
                    }
            }
            self.navigationController?.popViewController(animated: false)
        }
        } else {
        if  self.datacouponList.count == 0 {
            
        }else{
            guard  let dataCoupon = self.datacouponList[indexPath.row] as? [String:Any] else{
                return
            }
            if screenCome == .chat {
                if collectionView == coolectionMyOofers {
                    //                self.completionHandler!(data)
                    
                } else {
                    self.completionHandler!(dataCoupon)
                    
                }
            }
            self.navigationController?.popViewController(animated: false)
        }
        }
//        if  self.arrCouponList.count == 0 {
//            
//        }else{
//            guard  let dataCoupon = self.arrCouponList[indexPath.row] as? [String:Any] else{
//                return
//            }
//            if screenCome == .recharge {
//                CouponCode = dataCoupon["coupon_code"] as! String
//                //                    self.completionHandler!(dataCoupon)
//                self.applycouponcodeApiCallMethods()
//                
//            }
//            //                   self.navigationController?.popViewController(animated: false)
//        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == coolectionMyOofers {
            return CGSize(width: (collectionView.bounds.size.width)/2.2   , height: (collectionView.bounds.size.width)/2.2);
        } else {
            return CGSize(width:collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        }
    }
    //ScrollView delegate method
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        self.pageControl.currentPage = self.currentPage
    }
}
