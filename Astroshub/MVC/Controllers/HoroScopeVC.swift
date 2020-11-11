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
    
    var horoscopeRes = [[String:Any]]()
    var cornerRadius: CGFloat = 0
    @IBOutlet weak var horoscopeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadius = (((UIScreen.main.bounds.width - 50)/3)-6)/2
        self.horoscopeCollectionView.delegate = self
        self.horoscopeCollectionView.dataSource = self
        self.horoscopeCollectionView.allowsSelection = true
    }
    @IBAction func buttonBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
