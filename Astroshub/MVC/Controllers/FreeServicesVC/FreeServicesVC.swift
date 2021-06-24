//
//  FreeServicesVC.swift
//  Astroshub
//
//  Created by Kriscent on 20/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class FreeServicesVC: UIViewController ,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var tbl_dashboard: UITableView!
    let propertyArray = [
        "Birth Chart",
        "Kundali Matching",
        "Numerology",
        "Baby Name Analysis",
//        "Festival 2021",
        "Daily Horoscope","Mantras","Panchang","Sade Sati"
    ]
    let propertyArrayImages = [
        "birthchart",
        "kundali-matching",
        "asset-4",
        "birth-name-analysis",
//        "festival2021",
        "horoscope","mantras","panchang","sa-2"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl_dashboard.delegate = self
        self.tbl_dashboard.dataSource = self
        self.tbl_dashboard.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.tbl_dashboard.reloadData()
            self.tbl_dashboard.isHidden = false
        }
        
        // self.tbl_dashboard.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell_User3 = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! tablecell
        cell_User3.cv.delegate = self
        cell_User3.cv.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2)
        {
            cell_User3.consHgtCv.constant = cell_User3.cv.contentSize.height + 10
        }
        
        cell_User3.cv.reloadData()
        return cell_User3
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    //****************************************************
    // MARK: - Collectionview Method
    //****************************************************
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.propertyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionCell
        cell.lbltitle.text = propertyArray[indexPath.row]
        let image = propertyArrayImages[indexPath.row]
        cell.imgall.image = UIImage(named:image)!
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: (collectionView.bounds.size.width)/2.2   , height: (collectionView.bounds.size.width)/2.2);
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.item == 5{
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "MytrasViewController") as! MytrasViewController
            self.navigationController?.pushViewController(controller, animated: true)
        } else{
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "BabypdfviewVC") as! BabypdfviewVC
            controller.value = indexPath.row
            self.navigationController?.pushViewController(controller, animated: true)
        }
       
    }
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    

    
}
