//
//  Button_Customization.swift
//  aive
//
//  Created by Shiv Pareek on 03/10/17.
//  Copyright © 2017 Raja Vikram Singh. All rights reserved.
//  255 68 68

import Foundation
import UIKit

//    MARK:- @IBDesignable for UIButton
@IBDesignable class Button_Customization: UIButton
{
    //    Property observer
    @IBInspectable var bottun_BorderColor:UIColor = UIColor .clear
        {
        willSet
        {
            self.layer.borderColor = self.bottun_BorderColor.cgColor
        }
        didSet
        {
            self.layer.borderColor = self.bottun_BorderColor.cgColor
        }
    }
    
    @IBInspectable var bottun_BorderWidth:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            //            let float_ModuleValue = (self.bottun_BorderWidth/568)*100
            //            print("float_ModuleValue is:-",float_ModuleValue)
            //            let borderWidth = (float_ModuleValue*UIScreen.main.bounds.height)/100
            //            print("borderWidth is:-",borderWidth)
            
            self.layer.borderWidth = self.bottun_BorderWidth
        }
    }
    
    @IBInspectable var bottun_Coner:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            //            let float_ModuleValue = (self.bottun_Coner/568)*100
            //            print("float_ModuleValue is:-",float_ModuleValue)
            //            let cornerRadius = (float_ModuleValue*UIScreen.main.bounds.height)/100
            //            print("cornerRadius is:-",cornerRadius)
            
            self.layer.cornerRadius = self.bottun_Coner
            self.clipsToBounds = true
        }
    }
    
}


//    MARK:- @IBDesignable for UITextView
@IBDesignable class textView_Customization: UITextView
{
    //    Property observer
    @IBInspectable var txt_BorderColor:UIColor = UIColor .clear
        {
        willSet
        {
            self.layer.borderColor = self.txt_BorderColor.cgColor
        }
        didSet
        {
            self.layer.borderColor = self.txt_BorderColor.cgColor
        }
    }
    
    @IBInspectable var txt_BorderWidth:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            self.layer.borderWidth = self.txt_BorderWidth
        }
    }
    
    @IBInspectable var txt_Corner:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            self.layer.cornerRadius = self.txt_Corner
            self.clipsToBounds = true
        }
    }
}


//    MARK:- @IBDesignable for UITextField
@IBDesignable class text_Customization: UITextField
{
    var text_PlaceholderValue = ""
    
    @IBInspectable var text_PlaceholderName:String = "Placeholder"
        {
        didSet
        {
            //            self.text_PlaceholderValue = self.text_PlaceholderValue
            self.attributedPlaceholder = NSAttributedString(string: self.text_PlaceholderName, attributes: [NSAttributedString.Key.foregroundColor: UIColor .white])
        }
    }
    
    //    @IBInspectable var color_Placeholder:UIColor = UIColor .clear
    //    {
    //        didSet
    //        {
    //                self.attributedPlaceholder = NSAttributedString(string: self.text_PlaceholderName, attributes: [NSForegroundColorAttributeName:color_Placeholder])
    //        }
    //    }
    //
    //    Property observer
    @IBInspectable var txt_BorderColor:UIColor = UIColor .clear
        {
        willSet
        {
            self.layer.borderColor = self.txt_BorderColor.cgColor
        }
        didSet
        {
            self.layer.borderColor = self.txt_BorderColor.cgColor
        }
    }
    
    @IBInspectable var txt_BorderWidth:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            self.layer.borderWidth = self.txt_BorderWidth
        }
    }
    
    @IBInspectable var txt_Corner:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            self.layer.cornerRadius = self.txt_Corner
            self.clipsToBounds = true
        }
    }
}

//    MARK:- @IBDesignable for View_Customization
@IBDesignable class View_Customization: UIView
{
    @IBInspectable var view_ShadowColor:UIColor = UIColor .clear
        {
        didSet
        {
            self.layer.shadowColor = self.view_ShadowColor.cgColor
        }
    }
    
    @IBInspectable var view_ShadowOpacity:Float = 0.0
        {
        didSet
        {
            self.layer.shadowOpacity = self.view_ShadowOpacity
        }
    }
    
    @IBInspectable var view_ShadowRadius:CGFloat = 0.0
        {
        didSet
        {
            self.layer.shadowRadius = self.view_ShadowRadius
        }
    }
    @IBInspectable var view_ShadowOffset:CGSize = CGSize(width: 0.0, height: 0.0)
        {
        didSet
        {
            self.layer.shadowOffset = self.view_ShadowOffset
            self.layer.masksToBounds = false
        }
    }
    
    //    Property observer
    @IBInspectable var view_BorderColor:UIColor = UIColor .clear
        {
        willSet
        {
            self.layer.borderColor = self.view_BorderColor.cgColor
        }
        didSet
        {
            self.layer.borderColor = self.view_BorderColor.cgColor
        }
    }
    
    @IBInspectable var view_BorderWidth:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            let float_ModuleValue = (self.view_BorderWidth/568)*100
            print("float_ModuleValue is:-",float_ModuleValue)
            let borderWidth = (float_ModuleValue*UIScreen.main.bounds.height)/100
            print("borderWidth is:-",borderWidth)
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var view_Corner:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            //            let float_ModuleValue = (self.view_Corner/568)*100
            //            print("float_ModuleValue is:-",float_ModuleValue)
            //            let cornerRadius = (float_ModuleValue*UIScreen.main.bounds.height)/100
            //            print("cornerRadius is:-",cornerRadius)
            //
            self.layer.cornerRadius = self.view_Corner
            self.clipsToBounds = true
        }
    }
    
    
    //    @IBInspectable var view_BorderWidth:CGFloat = 0
    //        {
    //        willSet
    //        {
    //
    //        }
    //        didSet
    //        {
    //            self.layer.borderWidth = self.view_BorderWidth
    //        }
    //    }
    //
    //    @IBInspectable var view_Coner:CGFloat = 0
    //        {
    //        willSet
    //        {
    //
    //        }
    //        didSet
    //        {
    //            self.layer.cornerRadius = self.view_Coner
    //        }
    //    }
    
    //    @IBInspectable var gradientColorFirst:UIColor = UIColor .clear
    //    {
    //        didSet
    //        {
    //            let gradientLayer = CAGradientLayer()
    //            gradientLayer.frame = self.frame//self.bounds
    //            gradientLayer.colors = [UIColor.funcGradientLayerEx().gradientColorFirst.cgColor, UIColor.funcGradientLayerEx().gradientColorSecond.cgColor]
    //            self.layer.insertSublayer(gradientLayer, at: 0)
    //        }
    //    }
    
}

//    MARK:- @IBDesignable for UILabel
@IBDesignable class Label_Customization: UILabel
{
    //    Property observer
    @IBInspectable var lbl_BorderColor:UIColor = UIColor .clear
        {
        willSet
        {
            self.layer.borderColor = self.lbl_BorderColor.cgColor
        }
        didSet
        {
            self.layer.borderColor = self.lbl_BorderColor.cgColor
        }
    }
    
    @IBInspectable var lbl_BorderWidth:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            self.layer.borderWidth = self.lbl_BorderWidth
        }
    }
    
    @IBInspectable var lbl_Coner:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            self.layer.cornerRadius = self.lbl_Coner
            self.clipsToBounds = true
        }
    }
    
}

//    MARK:- ImageView_Customization
@IBDesignable class ImageView_Customization: UIImageView
{
    //    Property observer
    @IBInspectable var ImageView_BorderColor:UIColor = UIColor .clear
        {
        willSet
        {
            //            self.layer.borderColor = self.ImageView_BorderColor.cgColor
        }
        didSet
        {
            self.layer.borderColor = self.ImageView_BorderColor.cgColor
        }
    }
    
    @IBInspectable var ImageView_BorderWidth:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            self.layer.borderWidth = self.ImageView_BorderWidth
        }
    }
    
    @IBInspectable var ImageView_Coner:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            //            let float_ModuleValue = (self.ImageView_Coner/568)*100
            //            print("float_ModuleValue is:-",float_ModuleValue)
            //            let cornerRadius = (float_ModuleValue*UIScreen.main.bounds.height)/100
            //            print("cornerRadius is:-",cornerRadius)
            
            self.layer.cornerRadius = self.ImageView_Coner
            self.clipsToBounds = true
        }
    }
}


//    MARK:- @IBDesignable for UILabel
@IBDesignable class ImageView_CustomizationFix: UIImageView
{
    //    Property observer
    @IBInspectable var ImageView_BorderColor:UIColor = UIColor .clear
        {
        willSet
        {
            //            self.layer.borderColor = self.ImageView_BorderColor.cgColor
        }
        didSet
        {
            self.layer.borderColor = self.ImageView_BorderColor.cgColor
        }
    }
    
    @IBInspectable var ImageView_BorderWidth:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            self.layer.borderWidth = self.ImageView_BorderWidth
        }
    }
    
    @IBInspectable var ImageView_Coner:CGFloat = 0
        {
        willSet
        {
            
        }
        didSet
        {
            //            let float_ModuleValue = (self.ImageView_Coner/568)*100
            //            print("float_ModuleValue is:-",float_ModuleValue)
            //            let cornerRadius = (float_ModuleValue*UIScreen.main.bounds.height)/100
            //            print("cornerRadius is:-",cornerRadius)
            
            self.layer.cornerRadius = self.ImageView_Coner
            self.clipsToBounds = true
        }
    }
}

// MARK:- extension of UIColor
extension UIColor
{
    class func funcGradientLayerEx() -> (gradientColorFirst:UIColor , gradientColorSecond:UIColor)
    {
        let colorFirst = UIColor (red: 0.0/255.0, green: 195.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        let colorSecond = UIColor (red: 0.0/255.0, green: 112.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        return (colorFirst,colorSecond)
    }
    class func funcGradientLayerEx1() -> (gradientColorFirst:UIColor , gradientColorSecond:UIColor)
    {
        let colorFirst = UIColor (red: 0.0/255.0, green: 200.0/255.0, blue: 129.0/255.0, alpha: 1.0)
        let colorSecond = UIColor (red: 0.0/255.0, green: 156.0/255.0, blue: 119.0/255.0, alpha: 1.0)
        return (colorFirst,colorSecond)
    }
    class func funcColorEmptyText() -> UIColor
    {
        return UIColor (red: 255.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    }
}

@IBDesignable
class GradientView: UIView {
    
    
    @IBInspectable var startColor:   UIColor = UIColor.funcGradientLayerEx().gradientColorFirst { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = UIColor.funcGradientLayerEx().gradientColorSecond { didSet { updateColors() }}
    
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

@IBDesignable
class GradientView1: UIView {
    
    
    @IBInspectable var startColor:   UIColor = UIColor.funcGradientLayerEx1().gradientColorFirst { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = UIColor.funcGradientLayerEx1().gradientColorSecond { didSet { updateColors() }}
    
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

