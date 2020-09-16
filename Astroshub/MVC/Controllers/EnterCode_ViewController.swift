//
//  EnterCode_ViewController.swift
//  aive
//
//  Created by Rahul Mishra on 05/12/17.
//  Copyright © 2017 Raja Vikram Singh. All rights reserved.
//

// 38 136 145


import UIKit
import Alamofire
import SwiftyJSON
import SJSwiftSideMenuController
import FirebaseAuth
import Firebase
var str_Format_MobileAfterRegister:String = ""

class EnterCode_ViewController: UIViewController
{
    //    MARK:- vars
    var arr_KeyBoard:[String]!=["","","","","",""]
    var int_IndexForKeyboard:Int! = 0
    var strOTP=""
    //var ref: DatabaseReference!
    var countryCode = ""
    
    
    
    //    MARK:- IBOutlet
    @IBOutlet weak var lbl_First: Label_Customization!
    @IBOutlet weak var lbl_Second: Label_Customization!
    @IBOutlet weak var lbl_Third: Label_Customization!
    @IBOutlet weak var lbl_Fourth: Label_Customization!
    @IBOutlet weak var lbl_Fifth: Label_Customization!
    @IBOutlet weak var lbl_Six: Label_Customization!
    @IBOutlet weak var lbl_Enter4digit: UILabel!
    @IBOutlet weak var btn_Resendcode: UIButton!
    
    
    
    //    MARK:- ViewController's methods
    //    MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        lbl_Enter4digit.text = "Enter the 6-digit code sent to you at \(self.countryCode) \(OTPPhnNumber)"
        print(" lbl_Enter4digit.text  is:-",lbl_Enter4digit.text ?? "nil")
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK:- IBAction methods
    //    MARK: btn_BackSpaceKeyBoard
    @IBAction func btn_BackSpaceKeyBoard(_ sender: Any)
    {
        //      for var i in (0..<results.count).reverse()
        for (index,txt_ForLabel) in arr_KeyBoard.enumerated().reversed()
        {
            print("i is:-",index)
        }
        
        print("arr_KeyBoard is:-",arr_KeyBoard)
        strOTP = arr_KeyBoard.joined(separator: "")
        print("strOTP is:-",strOTP)
        for (index,txt_ForLabel) in arr_KeyBoard.enumerated().reversed()
        {
            if index == 0
            {
                if txt_ForLabel == ""
                {
                    print("already empty")
                }
                else
                {
                    arr_KeyBoard[index] = ""
                    print("arr_KeyBoard is:-",arr_KeyBoard)
                    strOTP = arr_KeyBoard.joined(separator: "")
                    print("strOTP is:-",strOTP)
                    lbl_First.text = ""
                    lbl_First.backgroundColor=UIColor .clear
                    lbl_Second.backgroundColor=UIColor .clear
                    lbl_Third.backgroundColor=UIColor .clear
                    lbl_Fourth.backgroundColor=UIColor .clear
                    
                    break
                }
            }
            if index == 1
            {
                if txt_ForLabel == ""
                {
                    print("already empty")
                }
                else
                {
                    arr_KeyBoard[index] = ""
                    print("arr_KeyBoard is:-",arr_KeyBoard)
                    strOTP = arr_KeyBoard.joined(separator: "")
                    print("strOTP is:-",strOTP)
                    lbl_First.text = ""
                    lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                    lbl_Second.backgroundColor=UIColor .clear
                    lbl_Third.backgroundColor=UIColor .clear
                    lbl_Fourth.backgroundColor=UIColor .clear
                    lbl_Fifth.backgroundColor=UIColor .clear
                    lbl_Six.backgroundColor=UIColor .clear
                    
                    break
                }
            }
            if index == 2
            {
                if txt_ForLabel == ""
                {
                    print("already empty")
                }
                else
                {
                    arr_KeyBoard[index] = ""
                    print("arr_KeyBoard is:-",arr_KeyBoard)
                    strOTP = arr_KeyBoard.joined(separator: "")
                    print("strOTP is:-",strOTP)
                    lbl_First.text = ""
                    lbl_First.backgroundColor=UIColor .clear
                    lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                    lbl_Third.backgroundColor=UIColor .clear
                    lbl_Fourth.backgroundColor=UIColor .clear
                    lbl_Fifth.backgroundColor=UIColor .clear
                    lbl_Six.backgroundColor=UIColor .clear
                    
                    break
                }
            }
            if index == 3
            {
                if txt_ForLabel == ""
                {
                    print("already empty")
                }
                else
                {
                    arr_KeyBoard[index] = ""
                    print("arr_KeyBoard is:-",arr_KeyBoard)
                    lbl_First.text = ""
                    strOTP = arr_KeyBoard.joined(separator: "")
                    print("strOTP is:-",strOTP)
                    lbl_First.backgroundColor=UIColor .clear
                    lbl_Second.backgroundColor=UIColor .clear
                    lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                    lbl_Fourth.backgroundColor=UIColor .clear
                    lbl_Fifth.backgroundColor=UIColor .clear
                    lbl_Six.backgroundColor=UIColor .clear
                    
                    
                    break
                }
            }
            if index == 4
            {
                if txt_ForLabel == ""
                {
                    print("already empty")
                }
                else
                {
                    arr_KeyBoard[index] = ""
                    print("arr_KeyBoard is:-",arr_KeyBoard)
                    lbl_First.text = ""
                    lbl_First.backgroundColor=UIColor .clear
                    lbl_Second.backgroundColor=UIColor .clear
                    lbl_Third.backgroundColor=UIColor .clear
                    lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                    lbl_Fifth.backgroundColor=UIColor .clear
                    lbl_Six.backgroundColor=UIColor .clear
                    
                    break
                }
            }
            if index == 5
            {
                if txt_ForLabel == ""
                {
                    print("already empty")
                }
                else
                {
                    arr_KeyBoard[index] = ""
                    print("arr_KeyBoard is:-",arr_KeyBoard)
                    lbl_First.text = ""
                    
                    lbl_First.backgroundColor=UIColor .clear
                    lbl_Second.backgroundColor=UIColor .clear
                    lbl_Third.backgroundColor=UIColor .clear
                    lbl_Fourth.backgroundColor=UIColor .clear
                    lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                    lbl_Six.backgroundColor=UIColor .clear
                    
                    
                    break
                }
            }
        }
        
        print("arr_KeyBoard is:-",arr_KeyBoard)
        for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
        {
            if index == 0
            {
                lbl_First.text = txt_ForLabel
            }
            if index == 1
            {
                lbl_Second.text = txt_ForLabel
            }
            if index == 2
            {
                lbl_Third.text = txt_ForLabel
            }
            if index == 3
            {
                lbl_Fourth.text = txt_ForLabel
            }
            if index == 4
            {
                lbl_Fifth.text = txt_ForLabel
            }
            if index == 5
            {
                lbl_Six.text = txt_ForLabel
            }
            
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //    MARK: btn_KeyboardButtons
    @IBAction func btn_KeyboardButtons(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_First.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
        }
        if sender.tag == 2
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_First.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
        }
        if sender.tag == 3
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_First.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
        }
        if sender.tag == 4
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_First.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
            
        }
        if sender.tag == 5
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        lbl_First.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        
                        
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
        }
        if sender.tag == 6
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        lbl_First.text = "\(sender.tag)"
                        
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
        }
        if sender.tag == 7
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_First.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
        }
        if sender.tag == 8
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_First.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
        }
        if sender.tag == 9
        {
            
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_First.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        
                        break
                    }
                }
                
            }
        }
        if sender.tag == 0
        {
            for (index,txt_ForLabel) in arr_KeyBoard.enumerated()
            {
                if index == 0
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_First.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        self.btn_Submit(UIButton())
                        
                        break
                    }
                }
                if index == 1
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Second.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        self.btn_Submit(UIButton())
                        
                        break
                    }
                }
                if index == 2
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Third.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        
                        self.btn_Submit(UIButton())
                        
                        break
                    }
                }
                if index == 3
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fourth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .clear
                        self.btn_Submit(UIButton())
                        
                        break
                    }
                }
                if index == 4
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Fifth.text = "\(sender.tag)"
                        
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        lbl_Six.backgroundColor=UIColor .clear
                        self.btn_Submit(UIButton())
                        break
                    }
                }
                if index == 5
                {
                    if txt_ForLabel == ""
                    {
                        arr_KeyBoard[index] = "\(sender.tag)"
                        
                        lbl_Six.text = "\(sender.tag)"
                        lbl_First.backgroundColor=UIColor .clear
                        lbl_Second.backgroundColor=UIColor .clear
                        lbl_Third.backgroundColor=UIColor .clear
                        lbl_Fourth.backgroundColor=UIColor .clear
                        lbl_Fifth.backgroundColor=UIColor .clear
                        lbl_Six.backgroundColor=UIColor .init(red: 253.0/255.0, green: 165.0/255.0, blue: 47.0/255.0, alpha: 1.0)
                        self.btn_Submit(UIButton())
                        break
                    }
                }
                
            }
        }
            
        else
        {
            print(strOTP)
            self.btn_Submit(UIButton())
        }
    }
    
    @IBAction func btn_ResendAction(_ sender: Any)
    {
        PhoneAuthProvider.provider().verifyPhoneNumber(str_ContNo_CounCode, uiDelegate: nil) { (verificationID, error) in
            
            
            print(str_ContNo_CounCode)
            
            if  error != nil
            {
                print(NSLocalizedDescriptionKey)
                print(NSLocalizedFailureReasonErrorKey)
                print("error: \(String(describing: error?.localizedDescription))")
                CommenModel.showDefaltAlret(strMessage:String(describing: error?.localizedDescription), controller: self)
                
                //SKToast.show(withMessage: "Invalid phone number")
                
            }
            else
            {
                let defaults = UserDefaults.standard
                defaults.set(verificationID, forKey: "authVID")
                print(verificationID ?? "nil")
                
                
            }
            
        }
       
    }
    
    //    MARK: btn_CrossBack
    @IBAction func btn_CrossBack(_ sender: Any)
    {
        //  self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
     func PhoneVarified()
     {
    
       let defaults = UserDefaults.standard
       let fcm = defaults.string(forKey: "FcmToken")
       print(fcm ?? "")
      
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")! ,
                                                                       verificationCode: self.strOTP)
            Auth.auth().signInAndRetrieveData(with: credential) { authData, error in
                if ((error) != nil) {
                // Handles error
                    
                let alert = UIAlertController(title: "Astroshubh", message: "Please enter Valid Code", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
              }
                _ = authData!.user
                guard let userID = Auth.auth().currentUser?.uid else { return }
                fcmUserID = userID
                print(fcmUserID)
                AutoBcmLoadingView.show("Loading......")
                self.loginApiCallMethods()
               
            }
        
        
     }
    
    
    //    MARK: btn_Submit
    @IBAction func btn_Submit(_ sender: Any)
    {
        print(strOTP)
        let boolIsValid =  funcValidation()
        if boolIsValid == false
        {
            return
        }
        
    
        let defaults = UserDefaults.standard
        let fcm = defaults.string(forKey: "FcmToken")
        print(fcm ?? "")
        
        self.PhoneVarified()
        

        
    }
    // MARK: funcValidation
    func funcValidation() -> Bool
    {
        
        
        for (_,txt_ForLabel) in arr_KeyBoard.enumerated()
        {
            if txt_ForLabel.isEmpty
            {
                //                let alert = UIAlertController(title: "Alert", message: "Enter the 4-digit code sent to you at +966 555 6780", preferredStyle: UIAlertController.Style.alert)
                //                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                //                self.present(alert, animated: true, completion: nil)
                
                return false
            }
            else
            {
                
                // strOTP = strOTP+txt_ForLabel
                // print("strOTP is:-",strOTP)
                
                strOTP = arr_KeyBoard.joined(separator: "")
            }
        }
        print(strOTP)
        return true
    }
    
    
    
    //    MARK:- Api methods
    //    MARK: callOtpVarifyAPI
    func loginApiCallMethods()
      {
          
          let deviceID = UIDevice.current.identifierForVendor!.uuidString
          print(deviceID)
          let defaults = UserDefaults.standard
          
          let fcm = defaults.string(forKey: "FcmToken")
          
          print(fcm ?? "")
          let setparameters = ["app_type":MethodName.APPTYPE.rawValue,
                               "app_version":MethodName.APPVERSION.rawValue,
                               "phone":OTPPhnNumber,
                               "country_id":countrycodeID,
                               "user_token":fcm ?? "",
                               "fcm_userid":fcmUserID]
          print(setparameters)
          //ActivityIndicator.shared.startLoading()
          
          AppHelperModel.requestPOSTURL(MethodName.CUSTOMERLOGIN.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                        success: { (respose) in
                                          AutoBcmLoadingView.dismiss()
                                          let tempDict = respose as! NSDictionary
                                          print(tempDict)
                                          
                                          let success=tempDict["response"] as!   Bool
                                          let message=tempDict["msg"] as!   String
                                          
                                          if success == true
                                          {
                                              str_ContNo_CounCode = "+91"+OTPPhnNumber
                                              dictloginnn = [
                                                  "userName":OTPPhnNumber,
                                                 // "userPWD":self.Password
                                              ]
                                            
                                              dictloginData = (tempDict["data"] as! NSDictionary) as! [String : Any]
                                            User.currentProfile(from: dictloginData)
                                              let dict_Data = tempDict["data"] as! NSDictionary
                                              print("dict_Data is:-",dict_Data)
                                              let keyyyy = dictloginData["user_api_key"] as? String ?? ""
                                              UserDefaults.standard.setValue(keyyyy, forKey:"userKey")
                                              
                                              //user_apikey = dict_Data["user_api_key"] as! String
                                              
                                              let data_Dict_IsUserData = NSKeyedArchiver.archivedData(withRootObject: dict_Data)
                                              UserDefaults.standard.setValue(data_Dict_IsUserData, forKey: "isUserData")
                                             
//                                            self.ref = Database.database().reference(fromURL:"https://astroshubh-43977.firebaseio.com/")
                                            
//                                            let userReference = self.ref!.child("users").child(fcmUserID)
                            
                                            
                                            let dictMovieRefAvengers: [String: String] = ["device_token": fcm!, "image": dictloginData["customer_image_url"] as! String, "name": dictloginData["username"] as! String, "email": dictloginData["email"] as! String, "thumb_image": "default", "Astro": "User", "ID": dictloginData["user_uni_id"] as! String]
                                            
                                            // self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(dictMovieRefAvengers)
                                            
//                                            userReference.updateChildValues(dictMovieRefAvengers) { (error, ref) in
//                                                if error != nil {
//                                                    print(error!)
//                                                    return
//                                                }
//
//                                                //  self.inputContainerView.inputTextField.text = nil
//
//
//                                            }
                                            
                                            
                                            let months = DateFormatter().monthSymbols
                                            let days = DateFormatter().weekdaySymbols
                                            
                                            
                                            
                                            let data_Dict_IsLogin = NSKeyedArchiver.archivedData(withRootObject: dictloginnn)
                                            UserDefaults.standard.setValue(data_Dict_IsLogin, forKey: "isLogin")
                                            
                                            let mainVC = SJSwiftSideMenuController()
                                            
                                            let sideVC_L : SideMenuController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                                            sideVC_L.menuItems = months as NSArray? ?? NSArray()
                                            
                                            let sideVC_R : SideMenuController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                                            sideVC_R.menuItems = days as NSArray? ?? NSArray()
                                            
                                            
                                            let DashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC")
                                            SJSwiftSideMenuController.setUpNavigation(rootController: DashboardVC!, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)
                                            
                                            SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
                                            
                                            SJSwiftSideMenuController.enableDimbackground = true
                                            SJSwiftSideMenuController.leftMenuWidth = 340
                                            
                                            self.navigationController?.pushViewController(mainVC, animated: true)
                                              
                                              
                                           
                                          }
                                              
                                          else
                                          {
                                              let refreshAlert = UIAlertController(title: "Astroshubh", message: message, preferredStyle: UIAlertController.Style.alert)
                                              refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                                                  {
                                                      (action: UIAlertAction!) in
                                                    self.navigationController?.popViewController(animated: true)
                                              }))
                                            self.present(refreshAlert, animated: true, completion: nil)
                                              
                                          }
                                          
          }) { (error) in
              print(error)
              AutoBcmLoadingView.dismiss()
            let refreshAlert = UIAlertController(title: "Astroshubh", message: "Please login again", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                {
                    (action: UIAlertAction!) in
                  self.navigationController?.popViewController(animated: true)
            }))
          }
      }
    func otpApiCallMethods() {
        
        
        let defaults = UserDefaults.standard
        
        let fcm = defaults.string(forKey: "FcmToken")
        
        print(fcm ?? "")
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"phone":OTPPhnNumber,"otp":strOTP]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.LOGIN.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            let defaults = UserDefaults.standard
                                          
                                           
                                            self.strOTP = ""
                                            LoginModel.sharedInstance.updateUserLoginDetails(lobjDict: tempDict)
                                            let dict_Data = tempDict["data"] as! NSDictionary
                                            print("dict_Data is:-",dict_Data)
                                            
                                            let onoff = dict_Data["astro_call_status"] as! String
                                            let astro_call_online_date1 = dict_Data["astro_call_online_date"] as! String
                                            let astro_call_online_time1 = dict_Data["astro_call_online_time"] as! String
                                            
                                            UserDefaults.standard.setValue(onoff, forKey: "callstatus")
                                            UserDefaults.standard.setValue(astro_call_online_date1, forKey: "astro_call_date")
                                            UserDefaults.standard.setValue(astro_call_online_time1, forKey: "astro_call_time")
                                            
                                            
                                            let onoffchat = dict_Data["astro_chat_status"] as! String
                                            let astro_chat_online_date11 = dict_Data["astro_online_chat_date"] as! String
                                            let astro_chat_online_time11 = dict_Data["astro_online_chat_time"] as! String
                                            
                                            
                                            UserDefaults.standard.setValue(onoffchat, forKey: "chatstatus")
                                            UserDefaults.standard.setValue(astro_chat_online_date11, forKey: "astro_chat_date")
                                            UserDefaults.standard.setValue(astro_chat_online_time11, forKey: "astro_chat_time")
                                            
                                            
                                            let data_Dict_IsUserData = NSKeyedArchiver.archivedData(withRootObject: dict_Data)
                                            UserDefaults.standard.setValue(data_Dict_IsUserData, forKey: "isUserData")
                                            
                                            let data_Dict_IsLogin = NSKeyedArchiver.archivedData(withRootObject: data_Dict_IsUserData)
                                            UserDefaults.standard.setValue(data_Dict_IsLogin, forKey: "isLogin")
                                           // let Dashboard = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC")
                                            //self.navigationController?.pushViewController(Dashboard!, animated: true)
                                            
                                            
                                            let credential : PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: self.strOTP)
                                            Auth.auth().signIn(with: credential) { (authResult, error) in
                                                
                                                if  error != nil
                                                {
                                                   
                                                         if let user = authResult?.user {
                                                            print(user)
                                                            
                                                            
                                                            
//                                                            self.ref = Database.database().reference(fromURL:"https://astroshubh-43977.firebaseio.com/")
//
//                                                            let userReference = self.ref!.child("users").child(user.uid)
                                                            
                                                            let dictMovieRefAvengers: [String: String] = ["device_token": fcm!, "image": dict_Data["customer_image_url"] as! String, "name": dict_Data["username"] as! String, "email": dict_Data["email"] as! String, "thumb_image": "default", "Astro": "User", "ID": dict_Data["user_uni_id"] as! String]
                                                            
                                                            // self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(dictMovieRefAvengers)
                                                            
//                                                            userReference.updateChildValues(dictMovieRefAvengers) { (error, ref) in
//                                                                if error != nil {
//                                                                    print(error!)
//                                                                    return
//                                                                }
//
//                                                                //  self.inputContainerView.inputTextField.text = nil
//
//
//                                                            }
                                                            
                                                             let months = DateFormatter().monthSymbols
                                                            let days = DateFormatter().weekdaySymbols
                                                            
                                                            
                                                            //  self.ref = Database.database().reference()
                                                            
                                                            // self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["username": dict_Data["id"] as! String])
                                                            let data_Dict_IsLogin = NSKeyedArchiver.archivedData(withRootObject: dictloginnn)
                                                            UserDefaults.standard.setValue(data_Dict_IsLogin, forKey: "isLogin")
                                                            
                                                            let mainVC = SJSwiftSideMenuController()
                                                            
                                                            let sideVC_L : SideMenuController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                                                            sideVC_L.menuItems = months as NSArray? ?? NSArray()
                                                            
                                                            let sideVC_R : SideMenuController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                                                            sideVC_R.menuItems = days as NSArray? ?? NSArray()
                                                            
                                                            
                                                            let DashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC")
                                                            SJSwiftSideMenuController.setUpNavigation(rootController: DashboardVC!, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)
                                                            
                                                            SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
                                                            
                                                            SJSwiftSideMenuController.enableDimbackground = true
                                                            SJSwiftSideMenuController.leftMenuWidth = 340
                                                            
                                                            self.navigationController?.pushViewController(mainVC, animated: true)
                                                            
                                                        }
                                               
                                                    
                                                }
                                                else
                                                {
                                                    if let user = authResult?.user
                                                    {
                                                        print(user)
                                                        
                                                        
                                                        
//                                                        self.ref = Database.database().reference(fromURL:"https://astroshubh-43977.firebaseio.com/")
//
//                                                        let userReference = self.ref!.child("users").child(user.uid)
                                                        
                                                        let dictMovieRefAvengers: [String: String] = ["device_token": fcm!, "image": dict_Data["customer_image_url"] as! String, "name": dict_Data["username"] as! String, "email": dict_Data["email"] as! String, "thumb_image": "default", "Astro": "User", "ID": dict_Data["user_uni_id"] as! String]
                                                        
                                                        // self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(dictMovieRefAvengers)
                                                        
//                                                        userReference.updateChildValues(dictMovieRefAvengers) { (error, ref) in
//                                                            if error != nil {
//                                                                print(error!)
//                                                                return
//                                                            }
//                                                            
//                                                            //  self.inputContainerView.inputTextField.text = nil
//                                                            
//                                                            
//                                                        }
                                                        
                                                        let months = DateFormatter().monthSymbols
                                                        let days = DateFormatter().weekdaySymbols
                                                        
                                                        
                                                        //  self.ref = Database.database().reference()
                                                        
                                                        // self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["username": dict_Data["id"] as! String])
                                                        let data_Dict_IsLogin = NSKeyedArchiver.archivedData(withRootObject: dictloginnn)
                                                        UserDefaults.standard.setValue(data_Dict_IsLogin, forKey: "isLogin")
                                                        
                                                        let mainVC = SJSwiftSideMenuController()
                                                        
                                                        let sideVC_L : SideMenuController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                                                        sideVC_L.menuItems = months as NSArray? ?? NSArray()
                                                        
                                                        let sideVC_R : SideMenuController = (self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController)!
                                                        sideVC_R.menuItems = days as NSArray? ?? NSArray()
                                                        
                                                        
                                                        let DashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC")
                                                        SJSwiftSideMenuController.setUpNavigation(rootController: DashboardVC!, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)
                                                        
                                                        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
                                                        
                                                        SJSwiftSideMenuController.enableDimbackground = true
                                                        SJSwiftSideMenuController.leftMenuWidth = 340
                                                        
                                                        self.navigationController?.pushViewController(mainVC, animated: true)
                                                    }
                                                }
                                                
                                            }
                                          
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
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
    
    
    //    MARK:- Finish
}


extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
