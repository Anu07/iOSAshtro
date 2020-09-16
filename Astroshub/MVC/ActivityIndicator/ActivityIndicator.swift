//
//  ActivityIndicator.swift
//  My Door Step Now
//
//  Created by DS on 30/11/17.
//  Copyright © 2017 DS. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView {

    static let shared: ActivityIndicator = { ActivityIndicator(frame: UIScreen.main.bounds) }()
    var innerImage:UIImageView!
    var loader:AMTumblrHud!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInIt()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.commonInIt()
    }
    
    func commonInIt(){
        self.frame = UIScreen.main.bounds;
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        loader = AMTumblrHud(frame: CGRect(x: CGFloat((self.frame.size.width - 55) * 0.5), y: CGFloat((self.frame.size.height - 20) * 0.5), width: 75, height: 30))
        loader.hudColor = mainColor3
        
        
        self.addSubview(loader)
    }
    
    func startLoading() {
        kApplicationDelegate.window?.endEditing(true)
        kApplicationDelegate.window?.addSubview(self)
        loader.show(animated: true)
    }
    
    func stopLoader() {
        removeFromSuperview()
    }
}
