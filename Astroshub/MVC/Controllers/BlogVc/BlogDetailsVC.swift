//
//  BlogDetailsVC.swift
//  Astroshub
//
//  Created by Kriscent on 23/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage
import Kingfisher
import AVFoundation
class BlogDetailsVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_blog: UITableView!
    
    let speechSynthesizer                       = AVSpeechSynthesizer()
    var previousSelectedIndexPath              : IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_blog.tableFooterView = UIView()
        
        self.BlogviewMethods()
        // Do any additional setup after loading the view.
    }
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func BlogviewMethods() {
        
        
           let iddd = BlogDetails["blog_id"] as! String
           
           let deviceID = UIDevice.current.identifierForVendor!.uuidString
           print(deviceID)
           let setparameters = ["app_type":"ios","app_version":"1.0","user_api_key":user_apikey.count > 0 ? user_apikey : "7bd679c21b8edcc185d1b6859c2e56ad","user_id":user_id.count > 0 ? user_id: "CUSGUS","blog_id":iddd]
           
           print(setparameters)
           //AutoBcmLoadingView.show("Loading......")
           AppHelperModel.requestPOSTURL("blogView", params: setparameters as [String : AnyObject],headers: nil,
                                         success: { (respose) in
                                           AutoBcmLoadingView.dismiss()
                                           let tempDict = respose as! NSDictionary
                                           print(tempDict)
                                           let success=tempDict["response"] as!   Bool
                                         //  let message=tempDict["msg"] as!   String
                                           
                                           if success == true
                                           {
                                               
                                               
                                               
                                               
                                               
                                               
                                           }
                                               
                                           else
                                           {
                                               
                                               
                                              
                                               
                                           }
                                           
                                           
           }) { (error) in
               print(error)
               AutoBcmLoadingView.dismiss()
           }
       }
    
    
    
    //****************************************************
    // MARK: - Action Method
    //****************************************************
    @IBAction func btn_backAction(_ sender: Any)
    {
        speechSynthesizer.stopSpeaking(at: .immediate)

        self.navigationController?.popViewController(animated: true)
    }
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    //       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    //       {
    //           return 320
    //       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
        
        
        cell_Add.view_back.layer.shadowColor = UIColor.lightGray.cgColor
        cell_Add.view_back.layer.shadowOpacity = 5.0
        cell_Add.view_back.layer.shadowRadius = 5.0
        cell_Add.view_back.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        cell_Add.view_back.layer.masksToBounds = false
        cell_Add.view_back.layer.cornerRadius = 5.0
        
        // cell_Add.img_blog.layer.cornerRadius = 12
        
        //           let dict_eventpoll = self.arrBlogs[indexPath.row]
        //           
        let package_icon_url = BlogDetails["blog_image_url"] as! String
        //cell_Add.img_blog.sd_setImage(with: URL(string: package_icon_url), placeholderImage: UIImage(named: "astroshubh_full log"))
        let views = BlogDetails["blog_total_views"] as! String
        
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = cell_Add.img_blog.center
        activityIndicator.hidesWhenStopped = true
        cell_Add.img_blog.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        cell_Add.img_blog.sd_setImage(with: URL(string: package_icon_url), completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
            activityIndicator.removeFromSuperview()
        })
        
        let title = BlogDetails["blog_title"] as! String
        let description = BlogDetails["blog_content"] as! String
        //let blogcategoryid = dict_eventpoll["blog_category_id"] as! String
        
        cell_Add.lbl_blogtitle.text  = title
        //cell_Add.lbl_blogdescription.text  = "Description : " + description
        cell_Add.lbl_blogdescription.attributedText =  description.htmlToAttributedString
        cell_Add.lbl_views.text  = "Views : " + views
        cell_Add.playButtonDetail.tag = indexPath.row
        cell_Add.playButtonDetail.addTarget(self, action: #selector(playButton), for: .touchUpInside)
        return cell_Add
        
    }
    @objc func playButton(_ sender :UIButton){
        sender.isSelected = !sender.isSelected
//        let dict_eventpoll = self.BlogDetails[sender.tag]
        let point = sender.convert(CGPoint.zero, to: self.tbl_blog)
        let indexPath = self.tbl_blog.indexPathForRow(at: point)
        let cell = self.tbl_blog.cellForRow(at: indexPath!) as! BlogCell
        cell.playButtonDetail.setImage(#imageLiteral(resourceName: "pause"), for: .normal)

        if speechSynthesizer.isSpeaking {
            cell.playButtonDetail.setImage(#imageLiteral(resourceName: "play"), for: .normal)

            speechSynthesizer.stopSpeaking(at: .immediate)

        } else {
            let content = removeSpecialCharsFromString(text: BlogDetails["blog_content"] as! String)

            let speechUtterance = AVSpeechUtterance(string: (BlogDetails["blog_content"] as! String).withoutSpecialCharacters)
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "hi-IN")

            DispatchQueue.main.async {
                self.speechSynthesizer.speak(speechUtterance)
            }
        }

    }
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return text.filter {okayChars.contains($0) }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        tbl_blog.deselectRow(at: indexPath as IndexPath, animated: true)
        //let ZoomImage = self.storyboard?.instantiateViewController(withIdentifier: "ZoomImageVC")
        //self.navigationController?.pushViewController(ZoomImage!, animated: true)
    }
    
    
    
    
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
}
extension BlogDetailsVC: AVSpeechSynthesizerDelegate {

       func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {

           speechSynthesizer.stopSpeaking(at: .word)

           if previousSelectedIndexPath != nil {
               let speechUtterance = AVSpeechUtterance(string: BlogDetails["blog_content"] as! String)
               DispatchQueue.main.async {
                   self.speechSynthesizer.speak(speechUtterance)
               }
           }
       }
   }
