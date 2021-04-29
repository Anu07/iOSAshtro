//
//  WalletVC.swift
//  SearchDoctor
//
//  Created by Kriscent on 08/11/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit
import SDWebImage

class WalletVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{

    let kMaxItemCount = 1000
    let kPageLength   = 10
    var items: [Int] = []
    
    var TotalwalletAmount = ""

    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var lbl_totalwalletamount: UILabel!
    @IBOutlet var tbl_wallet: UITableView!
    var arrWallet = [[String:Any]]()
    
    var page = 0
    var pagereload = 0
    var url_flag = 1
    var index_value = 0
    
    var refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action:#selector(handleRefresh(_:)), for: .valueChanged)
        tbl_wallet.addSubview(refreshController)
        AutoBcmLoadingView.show("Loading......")
        
        tbl_wallet.tableFooterView = UIView()
        view_top.layer.cornerRadius = 40.0
        let btnayer = CAGradientLayer()
        btnayer.frame = CGRect(x: 0.0, y: 0.0, width: view_top.frame.size.width, height: view_top.frame.size.height)
//        btnayer.colors = [mainColor1.cgColor, mainColor3.cgColor]
        btnayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view_top.layer.insertSublayer(btnayer, at: 1)
        let data_IsLogin = UserDefaults.standard.value(forKey: "isUserData") as? Data
        let dict_IsLogin = NSKeyedUnarchiver.unarchiveObject(with:data_IsLogin!) as! [String:Any]
        print("dict_IsLogin is:-",dict_IsLogin)
        print(self.view.frame.height)
        
        user_id = dict_IsLogin["user_uni_id"] as! String
        
//        self.tbl_wallet.am.addPullToRefresh { [unowned self] in
//           self.fetchDataFromStart(completion: { (fetchedItems) in
//               self.items = fetchedItems
//              // self.tbl_wallet.reloadData()
//               self.page = 0
//                self.pagereload = 0
//                self.url_flag = 1
//                self.index_value = 0
//               self.walletApiCallMethods()
//               self.tbl_wallet.am.pullToRefreshView?.stopRefreshing()
//           })
//       }
        
        
         self.walletApiCallMethods()
         self.tbl_wallet.am.addInfiniteScrolling { [unowned self] in
           self.fetchMoreData(completion: { (fetchedItems) in
               self.items.append(contentsOf: fetchedItems)
            
               if self.arrWallet.count >= 10
               {
                   self.pagereload = 1
                   self.page = self.page + 1
                   self.url_flag = 1
                   
                   self.walletApiCallMethods()
               }
               self.tbl_wallet.reloadData()
               self.tbl_wallet.am.infiniteScrollingView?.stopRefreshing()
               if fetchedItems.count == 0 {
                   //No more data is available
                   self.tbl_wallet.am.infiniteScrollingView?.hideInfiniteScrollingView()
               }
           })
       }
        self.tbl_wallet.am.pullToRefreshView?.trigger()
       
        // Do any additional setup after loading the view.
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
    // MARK: - Custom Method
    //****************************************************

    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func walletApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey,"page_no":page,"location":CurrentLocation] as [String : Any]
        print(setparameters)
  
        AppHelperModel.requestPOSTURL("getAmountHistory", params: setparameters as [String : AnyObject],headers: nil,
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
                                            self.TotalwalletAmount = dict_Data["user_amt"] as! String
                                            
                                            if CurrentLocation == "India"
                                            {
                                                self.lbl_totalwalletamount.text = "Wallet Amount:" + rupee + " " + self.TotalwalletAmount
                                            }
                                            else
                                            {
                                                self.lbl_totalwalletamount.text = "Wallet Amount:" + "$ " + self.TotalwalletAmount
                                            }
                                            
                                            
                                           // self.lbl_totalwalletamount.text = "Wallet Amount:" + self.TotalwalletAmount
                                            
 
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=dict_Data["amount_history"] as! [[String:Any]]
                                            print("arrProducts is:-",arrProducts)
                                            
                                            if self.url_flag == 1
                                            {
                                                if self.pagereload == 0
                                                {
                                                    self.arrWallet.removeAll()
                                                 
                                                    
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = i+1
                                                        self.index_value = i
                                                        
                                                        self.arrWallet.append(dict_Products)
                                                    }
                                                }
                                                else
                                                {
                                                   
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = self.index_value + 1
                                                        self.index_value = self.index_value + 1
                                                        
                                                        self.arrWallet.append(dict_Products)
                                                    }
                                                }
                                            }
                                            
                                           

                                            self.tbl_wallet.reloadData()
                                         
                                            
                                        }
                                            
                                        else
                                        {
                                            
                                            
                                              //  CommenModel.showDefaltAlret(strMessage:message, controller: self)
                                           
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
    
   
    @objc func handleRefresh(_ sender: Any?)
    {
        print("Pull To Refresh Method Called")
        page = 0
        pagereload = 0
        url_flag = 1
        refreshController.endRefreshing()
        walletApiCallMethods()
    }
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 149
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.arrWallet.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "WalletCell", for: indexPath) as! WalletCell
        
        cell_Add.view1.layer.shadowColor = UIColor.lightGray.cgColor
        cell_Add.view1.layer.shadowOpacity = 5.0
        cell_Add.view1.layer.shadowRadius = 5.0
        cell_Add.view1.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        cell_Add.view1.layer.masksToBounds = false
        cell_Add.view1.layer.cornerRadius = 5.0
        
        // cell_Add.lbl_date.text = "Item \(indexPath.row)"

        let dict_eventpoll = self.arrWallet[indexPath.row]

        //let transaction_mount = dict_eventpoll["transaction_amount"] as! String
        let wallethistorydescription = dict_eventpoll["wallet_history_description"] as! String
        let created_at = dict_eventpoll["created_at"] as! String

        let created_at1  = formattedDateFromString(dateString: created_at, withFormat: "dd MMM, yyyy")!

       // cell_Add.lbl_amount.text = transaction_mount
        cell_Add.lbl_date.text = created_at1
        cell_Add.lbl_title.text = wallethistorydescription
        let debitamt = dict_eventpoll["debit_amt"] as! String
        let creditamt = dict_eventpoll["credit_amt"] as! String
        let currency = dict_eventpoll["currency"] as! String
         if debitamt == "0.00"
         {
            cell_Add.lbl_amount.text = currency + "" + creditamt

         }
         else
         {
             cell_Add.lbl_amount.text = currency + "" + debitamt

         }
        
        return cell_Add
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"

            if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

                return outputFormatter.string(from: date)
        }

        return nil
    }

    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************


}
