//
//  ScratchCardViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 22/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SJSwiftSideMenuController

class ScratchCardViewController: UIViewController {

    @IBOutlet weak var scardCard: ScratchCard!
    @IBOutlet weak var labelForGift: UILabel!
    var randomcoupon  =  [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scardCard.scratchDelegate = self
        // Do any additional setup after loading the view.
        if randomcoupon.count == 0{
            labelForGift.text = "Better luck next time"

        } else {
        labelForGift.text = randomcoupon["coupon_code"] as? String
        }
    }
    
    @IBAction func buttonOk(_ sender: UIButton) {
        moveToDashBoardVC() 
    }
    
    func moveToDashBoardVC() {
        
        let months = DateFormatter().monthSymbols
        let days = DateFormatter().weekdaySymbols
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = SJSwiftSideMenuController()
        
        let sideVC_L : SideMenuController = (mainStoryboardIpad.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_L.menuItems = months as NSArray? ?? NSArray()
        
        let sideVC_R : SideMenuController = (mainStoryboardIpad.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
        sideVC_R.menuItems = days as NSArray? ?? NSArray()
        
        let initialViewControlleripad  = mainStoryboardIpad.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        
        SJSwiftSideMenuController.setUpNavigation(rootController: initialViewControlleripad, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)
        
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        
        SJSwiftSideMenuController.enableDimbackground = true
        SJSwiftSideMenuController.leftMenuWidth = 340
        
        let navigationController = UINavigationController(rootViewController: mainVC)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
}
extension ScratchCardViewController:ScratchDelegate {
    func scratch(percentage value: Int) {
        if value >= 70  {
//            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(update), userInfo: nil, repeats: false)
            update()
        }

       
        
    }
    @objc func update() {
        moveToDashBoardVC() 
    }
    
}
