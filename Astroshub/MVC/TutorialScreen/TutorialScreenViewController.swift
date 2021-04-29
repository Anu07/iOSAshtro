//
//  TutorialScreenViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 12/12/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class TutorialScreenViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var imageViewScreen: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    var thisWidth:CGFloat = 0

    @IBOutlet weak var pageControl: UIPageControl!
    var headerText: [String] = ["100 % AUTHENTIC AND TRUSTED PROFESSIONALS","CONSULATION AVAILABLE 24/7","MOST TRUSTED BRAND IN GEMSTONES AND RUDRAKSHA","SIGN UP AND CONNECT INDIA'S BEST ASTROLOGER"]
    var lowerText: [String] = ["Consult India's best astrologers,psychic,numerologist,tarot readers,vastu experts,healers at one simple click","Talk/Chat to our best astrolgers 24/7 at one simple click. Recharge your wallet 100 % secure payments with many exciting offers" ,"India's most trusted brand for buying most authentic and certified gemstones and rudraksh","7+ glorious years in the market with 70000+ happy customers around the world"]
    var images: [String] = ["ScreenNew3","Screen5" ,"ScreenNew1","SignUpImage"]
    var frame = CGRect.zero
    override func viewDidLoad() {
        super.viewDidLoad()
        thisWidth = CGFloat(self.collectionView.frame.width)
           collectionView.delegate = self
           collectionView.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
//           pageControl.hidesForSinglePage = true
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCollectionViewCell", for: indexPath) as! TutorialCollectionViewCell
        cell.imageScreen.image = UIImage(named: images[indexPath.section])
        cell.label1.text = headerText[indexPath.section]
        cell.label2.text = lowerText[indexPath.section]
        if indexPath.section == 3{
            cell.buttonFOrGo.isHidden = false
        } else {
            cell.buttonFOrGo.isHidden = true
        }
        cell.buttonFOrGo.addTarget(self, action: #selector(buttonForGo), for: .touchUpInside)
        return cell
    }
    @objc func buttonForGo(_ sender:UIButton){
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.section
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        thisWidth = CGFloat(self.collectionView.frame.width)
        return CGSize(width: thisWidth, height: self.view.frame.height)
    }
}
