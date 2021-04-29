//
//  HoroScopeVC.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 21/04/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
class HoroscopeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: ImageView_Customization!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var viewCell: UIView!
}

class HoroScopeVC: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    var index_value = 0

    var horoscopeRes = [[String:Any]]()
    var cornerRadius: CGFloat = 0
    @IBOutlet weak var horoscopeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadius = (((UIScreen.main.bounds.width - 50)/3)-6)/2
        self.horoscopeCollectionView.delegate = self
        self.horoscopeCollectionView.dataSource = self
        self.horoscopeCollectionView.allowsSelection = true
        horoscopeApiCallMethods()
    }
    @IBAction func buttonBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
     func horoscopeApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey.count > 0 ? user_apikey : "7bd679c21b8edcc185d1b6859c2e56ad" ,"user_id":user_id.count > 0 ? user_id: "CUSGUS","zodic_id":""]
        print(setparameters)
        //        ActivityIndicator.shared.startLoading()
        //AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.HOROSCOPE.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        ActivityIndicator.shared.stopLoader()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            var arrhoroscope = [[String:Any]]()
                                            
                                            self.horoscopeRes = [[String:Any]]()
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=tempDict["data"] as! [[String:Any]]
                                            for i in 0..<arrProducts.count
                                            {
                                                var dict_Products = arrProducts[i]
                                                dict_Products["isSelectedDeselected"] = "0"
                                                dict_Products["id"] = i+1
                                                self.index_value = i
                                               arrhoroscope.append(dict_Products)
                                            }
                                            
                                            self.horoscopeRes = arrhoroscope
                                            self.horoscopeCollectionView.reloadData()
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return horoscopeRes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoroscopeCell", for: indexPath) as! HoroscopeCell
        let dict_eventpoll = self.horoscopeRes[indexPath.row]
        
        cell.viewCell.cornerRadius = self.cornerRadius
        cell.viewCell.borderColor = UIColor.lightGray
        cell.viewCell.borderWidth = 1
        let Image=dict_eventpoll["zodiac_category_img"] as! String
        let name=dict_eventpoll["zodiac_category_name"] as! String
        
        cell.imageViewCell.sd_setImage(with: URL(string: Image), placeholderImage: UIImage(named: "Placeholder.png"))
        cell.lblHeading.text =  name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dict_eventpoll = self.horoscopeRes[indexPath.row]
        ZodiacID = dict_eventpoll["cms_zodiac_cms_id"] as! String
        ZodiacName = dict_eventpoll["zodiac_category_name"] as! String
        let Dailyhoroscope = self.storyboard?.instantiateViewController(withIdentifier: "DailyhoroscopeVC") as! DailyhoroscopeVC
        Dailyhoroscope.selectedZodiac = dict_eventpoll
        self.navigationController?.pushViewController(Dailyhoroscope, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = UIScreen.main.bounds.width - 50
        return CGSize(width: width/3  , height: width/3)
    }
}
