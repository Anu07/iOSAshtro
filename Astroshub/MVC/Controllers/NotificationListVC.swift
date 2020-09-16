//
//  NotificationListVC.swift
//  Astroshub
//
//  Created by Kriscent on 28/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class NotificationListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    
    let kMaxItemCount = 1000
    let kPageLength   = 10
    var items: [Int] = []
    
    var page = 0
    var pagereload = 0
    var url_flag = 1
    var index_value = 0
    var refreshController = UIRefreshControl()
    
    @IBOutlet var tbl_notificationlist: UITableView!
    var arrnotification = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action:#selector(handleRefresh(_:)), for: .valueChanged)
        tbl_notificationlist.addSubview(refreshController)
        
        tbl_notificationlist.tableFooterView = UIView()
        AutoBcmLoadingView.show("Loading......")
        self.func_Notificationlist()
        self.tbl_notificationlist.am.addInfiniteScrolling { [unowned self] in
            self.fetchMoreData(completion: { (fetchedItems) in
                self.items.append(contentsOf: fetchedItems)
             
                if self.arrnotification.count >= 10
                {
                    self.pagereload = 1
                    self.page = self.page + 1
                    self.url_flag = 1
                    
                    self.func_Notificationlist()
                }
                self.tbl_notificationlist.reloadData()
                self.tbl_notificationlist.am.infiniteScrollingView?.stopRefreshing()
                if fetchedItems.count == 0 {
                    //No more data is available
                    self.tbl_notificationlist.am.infiniteScrollingView?.hideInfiniteScrollingView()
                }
            })
        }
         self.tbl_notificationlist.am.pullToRefreshView?.trigger()
        // Do any additional setup after loading the view.
    }
    @objc func handleRefresh(_ sender: Any?)
    {
        print("Pull To Refresh Method Called")
        page = 0
        pagereload = 0
        url_flag = 1
        refreshController.endRefreshing()
        func_Notificationlist()
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_Notificationlist() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        //let setparameters = ["app_type":"ios","app_version":"1.0","user_id":UserUniqueID ,"user_api_key":UserApiKey,"state_id":userStateId]
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey,"page":page] as [String : Any]
        print(setparameters)
        
        AppHelperModel.requestPOSTURL("notificationList", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            
                                            let dict_data = tempDict["data"] as! [String:Any]
                                            print("dict_data is:- ",dict_data)
                                           // self.arrnotification=dict_data["language"] as! [[String:Any]]
                                            
                                            
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=dict_data["language"] as! [[String:Any]]
                                            print("arrProducts is:-",arrProducts)
                                            
                                            if self.url_flag == 1
                                            {
                                                if self.pagereload == 0
                                                {
                                                    self.arrnotification.removeAll()
                                                 
                                                    
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = i+1
                                                        self.index_value = i
                                                        
                                                        self.arrnotification.append(dict_Products)
                                                    }
                                                }
                                                else
                                                {
                                                   
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = self.index_value + 1
                                                        self.index_value = self.index_value + 1
                                                        
                                                        self.arrnotification.append(dict_Products)
                                                    }
                                                }
                                            }
                                            
                                            
                                           
                                            
 
                                            
                                            self.tbl_notificationlist.reloadData()
                                            
                                            
                                            
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
        self.navigationController?.popViewController(animated: true)
    }
    
    //****************************************************
    // MARK: - Table Method
    //****************************************************
    //     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    //     {
    //
    //         return 51
    //
    //     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return self.arrnotification.count
       // return 10
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let PackageList2 = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let dict_eventpoll = self.arrnotification[indexPath.row]

        let title = dict_eventpoll["title"] as! String
        let message = dict_eventpoll["message"] as! String

        PackageList2.lbl_title.text = title
        PackageList2.lbl_message.text = message
        
//        PackageList2.lbl_title.text = "Bhunesh"
//        PackageList2.lbl_message.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        
        return PackageList2
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        
        
        
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
}
class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_message: UILabel!
    
}
