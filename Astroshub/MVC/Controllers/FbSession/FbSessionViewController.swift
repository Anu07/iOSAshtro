//
//  FbSessionViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 30/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import ObjectMapper
class FbSessionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrForList:[Get_session_list]?
    override func viewDidLoad() {
        super.viewDidLoad()
        apiForGetSession()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    func apiForGetSession() {
        
        let setparameters = ["user_api_key":user_apikey.count > 0 ? user_apikey : "7bd679c21b8edcc185d1b6859c2e56ad","user_id":user_id.count > 0 ? user_id: "CUSGUS"]
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.fbSession.rawValue, params:setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            
                                            if let responseObject = respose as? [String:Any] {
                                                if let loginData = Mapper<FbSessionBase>().map(JSONObject: responseObject) {
                                                    self.arrForList = loginData.data?.get_session_list 
                                                }
                                            }
                                            if self.arrForList?.count ?? 0 > 0 {
                                                self.tableView.backgroundView = nil

                                            } else {


                                                let noDataLabel: UILabel = UILabel(frame: CGRect(x:0, y:0, width:self.tableView.bounds.size.width, height:self.tableView.bounds.size.height))
                                                        noDataLabel.text = "No facebook sessions available"
                                                noDataLabel.textColor = UIColor.black
                                                noDataLabel.textAlignment = NSTextAlignment.center
                                                        self.tableView.backgroundView = noDataLabel

                                            }
                                            self.tableView.reloadData()
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
    
}
extension FbSessionViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.arrForList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FbSessionTableViewCell", for: indexPath) as! FbSessionTableViewCell
        let data = self.arrForList?[indexPath.row]
        cell.labelName.text = data?.host_name
        cell.label1.text = data?.session_title
        cell.label2.text = "On \(data?.session_date ?? "") at \(data?.session_time ?? "")"
//        cell.imageViewuser.sd_setImage(with: URL(string: data?.host_image ??
//                                                        ""), placeholderImage:#imageLiteral(resourceName: "user2"))
//        cell.imageViewuser.image = #imageLiteral(resourceName: "user2")
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(sharelink), for: .touchUpInside)
        cell.fbButton.tag = indexPath.row
        cell.fbButton.addTarget(self, action: #selector(fbOpen), for: .touchUpInside)

        return cell
    }
    
    @objc  func sharelink(_ sender: UIButton) {
        let data = self.arrForList?[sender.tag]        
        let text = ""
        let myWebsite = URL(string: data?.session_url ?? "")
        let shareAll = [text , myWebsite as Any] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
       }
    @objc  func fbOpen(_ sender: UIButton) {
        let data = self.arrForList?[sender.tag]

        let whatsappURL = URL(string: data?.session_url ?? "")
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
        }
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.arrForList?[indexPath.row]

        let whatsappURL = URL(string: "https://www.facebook.com/astroshubh.in/videos/904817060050655/")
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 140.0
        }
    }
