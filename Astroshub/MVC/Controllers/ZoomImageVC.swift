//
//  ZoomImageVC.swift
//  Astroshub
//
//  Created by Kriscent on 28/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage
import Kingfisher
class ZoomImageVC: UIViewController,EFImageViewZoomDelegate {
    
    @IBOutlet weak var imageView: EFImageViewZoom!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
//        activityIndicator.center = imageView.center
//        activityIndicator.hidesWhenStopped = true
//        imageView.addSubview(activityIndicator)
//        activityIndicator.startAnimating()

        
        
        AutoBcmLoadingView.show("Loading......")
        self.imageView._delegate = self
        let package_icon_url = BlogDetails["blog_image_url"] as! String
        DispatchQueue.global(qos: .background).async {
            do
            {
                let data = try Data.init(contentsOf: URL.init(string:package_icon_url)!)
                DispatchQueue.main.async {
                    let image: UIImage = UIImage(data: data)!
                    self.imageView.image = image
                    //activityIndicator.removeFromSuperview()
                    AutoBcmLoadingView.dismiss()
                }
            }
            catch {
                // error
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    
    @IBAction func btn_backAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
}
