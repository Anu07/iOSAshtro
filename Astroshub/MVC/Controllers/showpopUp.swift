//
//  showpopUp.swift
//  aive
//
//  Created by Bhunesh Kahar on 07/05/19.
//  Copyright © 2019 Raja Vikram Singh. All rights reserved.
//

import UIKit
var popup_description = ""

class showpopUp: UIViewController {
    
    var popupTimer: Timer!
    @IBOutlet var btnBook: ZFRippleButton!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var txt_comment: UITextField!
    var reviewrating = ""
    //  @IBOutlet weak var txt_description: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "stargray") as UIImage?
        btn1.setImage(image, for: .normal)
        btn2.setImage(image, for: .normal)
        btn3.setImage(image, for: .normal)
        btn4.setImage(image, for: .normal)
        btn5.setImage(image, for: .normal)
        
        
        let btnayer = CAGradientLayer()
        
        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: btnBook.frame.size.width, height: btnBook.frame.size.height)
        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        btnBook.layer.insertSublayer(btnayer, at: 1)
        
        // txt_description.text = popup_description
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            //    self.popupTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: false)
            
            
            
            
            //self.removeAnimate()
        });
    }
    @objc func runTimedCode() {
        
        self.removeAnimate()
        
        //notificationTimer.invalidate()
        
    }
    @IBAction func btn_CrossAction(_ sender: Any)
    {
        self.removeAnimate()
    }
    @IBAction func btn_SubmitAction(_ sender: Any)
    {
        
        
        guard validateMethod() else {
            return
        }
        
        self.func_reviewcomment()
    }
    func validateMethod () -> Bool
    {
        guard  !(self.txt_comment.text)!.isBlank  else{
            
            CommenModel.showDefaltAlret(strMessage: "Please enter Comment.", controller: self)
            
            return false
        }
        
        
        return  true
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                
                //  let CheckinViewController = self.storyboard?.instantiateViewController(withIdentifier: "CheckinViewController") as! CheckinViewController
                //  self.navigationController?.pushViewController(CheckinViewController, animated: false)
            }
        });
    }
    
    func func_reviewcomment() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"review_for_id":AstrologerUniID,"review_rating":reviewrating,"review_comment":txt_comment.text as Any] as [String : Any]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("addReviews", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        //let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            self.removeAnimate()
                                            self.navigationController?.popToRootViewController(animated: true)
                                        }
                                        else
                                        {
                                        }
                                        
                                        
        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    @IBAction func btn_Submit1Action(_ sender: Any)
    {
        let image = UIImage(named: "star") as UIImage?
        let image1 = UIImage(named: "stargray") as UIImage?
        btn1.setImage(image, for: .normal)
        btn2.setImage(image1, for: .normal)
        btn3.setImage(image1, for: .normal)
        btn4.setImage(image1, for: .normal)
        btn5.setImage(image1, for: .normal)
        
        reviewrating = "1"
        
    }
    @IBAction func btn_Submit2Action(_ sender: Any)
    {
        let image = UIImage(named: "star") as UIImage?
        let image1 = UIImage(named: "stargray") as UIImage?
        btn1.setImage(image, for: .normal)
        btn2.setImage(image, for: .normal)
        btn3.setImage(image1, for: .normal)
        btn4.setImage(image1, for: .normal)
        btn5.setImage(image1, for: .normal)
        reviewrating = "2"
    }
    @IBAction func btn_Submit3Action(_ sender: Any)
    {
        let image = UIImage(named: "star") as UIImage?
        let image1 = UIImage(named: "stargray") as UIImage?
        btn1.setImage(image, for: .normal)
        btn2.setImage(image, for: .normal)
        btn3.setImage(image, for: .normal)
        btn4.setImage(image1, for: .normal)
        btn5.setImage(image1, for: .normal)
        reviewrating = "3"
    }
    @IBAction func btn_Submit4Action(_ sender: Any)
    {
        let image = UIImage(named: "star") as UIImage?
        let image1 = UIImage(named: "stargray") as UIImage?
        btn1.setImage(image, for: .normal)
        btn2.setImage(image, for: .normal)
        btn3.setImage(image, for: .normal)
        btn4.setImage(image, for: .normal)
        btn5.setImage(image1, for: .normal)
        reviewrating = "4"
    }
    
    @IBAction func btn_Submit5Action(_ sender: Any)
    {
        let image = UIImage(named: "star") as UIImage?
        
        btn1.setImage(image, for: .normal)
        btn2.setImage(image, for: .normal)
        btn3.setImage(image, for: .normal)
        btn4.setImage(image, for: .normal)
        btn5.setImage(image, for: .normal)
        reviewrating = "5"
    }
    
    
}
