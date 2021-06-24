//
//  BlogVC.swift
//  Astroshub
//
//  Created by Kriscent on 18/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import SDWebImage
import Kingfisher
import AVFoundation
class BlogVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate{
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_blog: UITableView!
    var arrBlogs = [[String:Any]]()
    var blod_id = ""
    var blod_like = Int()
    
    let kMaxItemCount = 1000
    let kPageLength   = 10
    var items: [Int] = []
    
    var page = 0
    var pagereload = 0
    var url_flag = 1
    var index_value = 0
    var refreshController = UIRefreshControl()
    
    let speechSynthesizer                       = AVSpeechSynthesizer()
    var previousSelectedIndexPath              : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        AutoBcmLoadingView.show("Loading......")
        
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action:#selector(handleRefresh(_:)), for: .valueChanged)
        tbl_blog.addSubview(refreshController)
        
        tbl_blog.tableFooterView = UIView()
        
        speechSynthesizer.delegate = self

        self.blogApiCallMethods()
        self.tbl_blog.am.addInfiniteScrolling { [unowned self] in
            self.fetchMoreData(completion: { (fetchedItems) in
                self.items.append(contentsOf: fetchedItems)
                
                if self.arrBlogs.count >= 10
                {
                    self.pagereload = 1
                    self.page = self.page + 1
                    self.url_flag = 1
                    
                    self.blogApiCallMethods()
                }
                self.tbl_blog.reloadData()
                self.tbl_blog.am.infiniteScrollingView?.stopRefreshing()
                if fetchedItems.count == 0 {
                    //No more data is available
                    self.tbl_blog.am.infiniteScrollingView?.hideInfiniteScrollingView()
                }
            })
        }
        self.tbl_blog.am.pullToRefreshView?.trigger()
        
        // Do any additional setup after loading the view.
    }
    @objc func handleRefresh(_ sender: Any?)
    {
        print("Pull To Refresh Method Called")
        page = 0
        pagereload = 0
        url_flag = 1
        refreshController.endRefreshing()
        blogApiCallMethods()
    }
    func fetchDataFromStart(completion handler:@escaping (_ fetchedItems: [Int])->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
        {
            let fetchedItems = Array(0..<self.kPageLength)
            handler(fetchedItems)
        }
    }
    
    func fetchMoreData(completion handler:@escaping (_ fetchedItems: [Int])->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.items.count >= self.kMaxItemCount {
                handler([])
                return
            }
            
            let fetchedItems = Array(self.items.count..<(self.items.count + self.kPageLength))
            handler(fetchedItems)
        }
    }
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func blogApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_api_key":user_apikey.count > 0 ? user_apikey : "7bd679c21b8edcc185d1b6859c2e56ad","user_id":user_id.count > 0 ? user_id: "CUSGUS","page":page] as [String : Any]
        print(setparameters)
        
        AppHelperModel.requestPOSTURL(MethodName.BLOG.rawValue, params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            print("dict_Data is:- ",dict_Data)
                                            //                                            if let arrblog = dict_Data["blogs"] as? [[String:Any]]
                                            //                                            {
                                            //                                                self.arrBlogs = arrblog
                                            //                                            }
                                            //                                            print("arrBlogs is:- ",self.arrBlogs)
                                            
                                            
                                            
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=dict_Data["blogs"] as! [[String:Any]]
                                            print("arrProducts is:-",arrProducts)
                                            
                                            if self.url_flag == 1
                                            {
                                                if self.pagereload == 0
                                                {
                                                    self.arrBlogs.removeAll()
                                                    
                                                    
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = i+1
                                                        self.index_value = i
                                                        
                                                        self.arrBlogs.append(dict_Products)
                                                    }
                                                }
                                                else
                                                {
                                                    
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = self.index_value + 1
                                                        self.index_value = self.index_value + 1
                                                        
                                                        self.arrBlogs.append(dict_Products)
                                                    }
                                                }
                                            }
                                            
                                            
                                            self.tbl_blog.reloadData()
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
    
    func BloglikeApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"blog_id":blod_id]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("bloglike", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            self.blogApiCallMethods()
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                            
                                            
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
    
    
    func BlogunlikeApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"blog_id":blod_id]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("blogDislike", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            self.blogApiCallMethods()
                                            CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                            
                                            
                                            
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
        
        return self.arrBlogs.count
        
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
        cell_Add.img_blog.kf.indicatorType = .activity
        // cell_Add.img_blog.layer.cornerRadius = 12
        //  cell_Add.img_blog.SDWebImageActivityIndicator(true)
        // cell_Add.img_blog.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let dict_eventpoll = self.arrBlogs[indexPath.row]
        //cell_Add.img_blog.kf.indicatorType = .activity
        
        let package_icon_url = dict_eventpoll["blog_image_url"] as! String
        let blogtotallikes = dict_eventpoll["blog_total_likes"] as! String
        let like = dict_eventpoll["like"] as! Int
        // cell_Add.img_blog.sd_setImage(with: URL(string: package_icon_url), placeholderImage: UIImage(named: "astroshubh_full log"))
        
        
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center = cell_Add.img_blog.center
        activityIndicator.hidesWhenStopped = true
        cell_Add.img_blog.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        cell_Add.img_blog.sd_setImage(with: URL(string: package_icon_url), completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
            activityIndicator.removeFromSuperview()
        })
        
        
        
        
        //cell_Add.img_blog.sd_setShowActivityIndicatorView(true)
        // cell_Add.img_blog.sd_setIndicatorStyle(.gray)
        
        
        // cell_Add.img_blog.kf.setImage(with: fruit.image, placeholder: #imageLiteral(resourceName: "placeholder"))
        
        let title = dict_eventpoll["blog_title"] as! String
        let description = dict_eventpoll["blog_content"] as! String
        let views = dict_eventpoll["blog_total_views"] as! String
        cell_Add.btn_like.setTitle(blogtotallikes, for: .normal)
        
        cell_Add.btn_like.tag = indexPath.row
        cell_Add.btn_like.addTarget(self, action: #selector(self.btn_LikeAction(_:)), for: .touchUpInside)
        //let blogcategoryid = dict_eventpoll["blog_category_id"] as! String
        
        cell_Add.lbl_blogtitle.text  = title
        cell_Add.lbl_views.text  = "Views : " + views
        cell_Add.playButton.tag = indexPath.row
        cell_Add.playButton.addTarget(self, action: #selector(playButton), for: .touchUpInside)
        //  let partOne = NSMutableAttributedString(string: "Description : ", attributes: description.htmlToAttributedString)
        cell_Add.textView.delegate = self
        cell_Add.textView.isSelectable = true
        cell_Add.textView.isUserInteractionEnabled = true
        cell_Add.textView.attributedText =  description.htmlToAttributedString
        //cell_Add.lbl_blogdescription.text  = "Description : " + description
        if like == 0
        {
            let image1 = UIImage(named: "heart")
            cell_Add.btn_like.setImage(image1, for: .normal)
        }
        else
        {
            let image1 = UIImage(named: "like")
            cell_Add.btn_like.setImage(image1, for: .normal)
        }
        cell_Add.shareButton.tag = indexPath.row
        cell_Add.shareButton.addTarget(self, action: #selector(shareButton), for: .touchUpInside)
        
        return cell_Add
        
    }
    @objc func playButton(_ sender :UIButton){
        sender.isSelected = !sender.isSelected
        let dict_eventpoll = self.arrBlogs[sender.tag]

        let point = sender.convert(CGPoint.zero, to: self.tbl_blog)
        let indexPath = self.tbl_blog.indexPathForRow(at: point)

        if previousSelectedIndexPath == indexPath {

            let cell = self.tbl_blog.cellForRow(at: indexPath!) as! BlogCell
            speechSynthesizer.stopSpeaking(at: .immediate)
            cell.playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            previousSelectedIndexPath = nil

        } else {

            if previousSelectedIndexPath == nil {

                previousSelectedIndexPath = indexPath

                let cell = self.tbl_blog.cellForRow(at: indexPath!) as! BlogCell
                cell.playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)

                if speechSynthesizer.isSpeaking {

                    speechSynthesizer.stopSpeaking(at: .immediate)

                } else {
//                    let content = removeSpecialCharsFromString(text: dict_eventpoll["blog_content"] as! String)

                    let speechUtterance = AVSpeechUtterance(string: (dict_eventpoll["blog_content"] as! String).withoutSpecialCharacters)
                    speechUtterance.voice = AVSpeechSynthesisVoice(language: "hi-IN")

                    DispatchQueue.main.async {
                        self.speechSynthesizer.speak(speechUtterance)
                    }
                }

            } else {

                let oldCell = self.tbl_blog.cellForRow(at: previousSelectedIndexPath!) as! BlogCell
                oldCell.playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)

                let cell = self.tbl_blog.cellForRow(at: indexPath!) as! BlogCell
                cell.playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)

                previousSelectedIndexPath = indexPath

                if speechSynthesizer.isSpeaking {

                    speechSynthesizer.stopSpeaking(at: .immediate)
                    let content = removeSpecialCharsFromString(text: dict_eventpoll["blog_content"] as! String)

                    let speechUtterance = AVSpeechUtterance(string: (dict_eventpoll["blog_content"] as! String).withoutSpecialCharacters)
                    speechUtterance.voice = AVSpeechSynthesisVoice(language: "hi-IN")

                    self.speechSynthesizer.speak(speechUtterance)

                } else {
                    let content = removeSpecialCharsFromString(text: dict_eventpoll["blog_content"] as! String)

                    let speechUtterance = AVSpeechUtterance(string: (dict_eventpoll["blog_content"] as! String).withoutSpecialCharacters)
                    speechUtterance.voice = AVSpeechSynthesisVoice(language: "hi-IN")

                    DispatchQueue.main.async {
                        self.speechSynthesizer.speak(speechUtterance)
                    }
                }

            }
        }
    }
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return text.filter {okayChars.contains($0) }
    }
    @objc func shareButton(_ sender :UIButton){
        let dict_eventpoll = self.arrBlogs[sender.tag]
        let text = "Hey i am using Astroshubh to get predictions related to marriage, relationship and career."
        let myWebsite = URL(string:"https://apps.apple.com/in/app/astroshubh/id1509641168")
        let shareAll = [text , myWebsite as Any] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    @objc func btn_LikeAction(_ sender: UIButton)
    {
        let dict = self.arrBlogs[sender.tag]
        blod_id = dict["blog_id"] as! String
        blod_like = dict["like"] as! Int
        if blod_like == 0
        {
            self.BloglikeApiCallMethods()
        }
        else
        {
            self.BlogunlikeApiCallMethods()
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        speechSynthesizer.stopSpeaking(at: .immediate)
        BlogDetails = self.arrBlogs[indexPath.row]
        tbl_blog.deselectRow(at: indexPath as IndexPath, animated: true)
        let BlogDetails = self.storyboard?.instantiateViewController(withIdentifier: "BlogDetailsVC")
        self.navigationController?.pushViewController(BlogDetails!, animated: true)
    }
    
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        UIApplication.shared.open(URL.absoluteURL)
        return false
    }
    
}
extension BlogVC: AVSpeechSynthesizerDelegate {

       func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let dict_eventpoll = self.arrBlogs[previousSelectedIndexPath!.row]

           speechSynthesizer.stopSpeaking(at: .word)

           if previousSelectedIndexPath != nil {
               let speechUtterance = AVSpeechUtterance(string: dict_eventpoll["blog_content"] as! String)
               DispatchQueue.main.async {
                   self.speechSynthesizer.speak(speechUtterance)
               }
           }
       }
   }
extension String {
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
}
