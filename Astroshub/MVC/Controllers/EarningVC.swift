//
//  EarningVC.swift
//  Astroshub
//
//  Created by Kriscent on 08/01/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class EarningVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var view_top: UIView!
    @IBOutlet var tbl_earning: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    var arrEarning = [[String:Any]]()
    var refreshController = UIRefreshControl()
    var page = 1
    var pagereload = 0
    var url_flag = 1
    var index_value = 0
    var fetchingMore = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_earning.tableFooterView = UIView()
        
        //view_top.layer.cornerRadius = 5.0
        
        //        refreshController = UIRefreshControl()
        //        refreshController.addTarget(self, action:#selector(handleRefresh(_:)), for: .valueChanged)
        //        tbl_earning.addSubview(refreshController)
        
        
        viewSearch.layer.cornerRadius = 8.0
        viewSearch.layer.borderColor = UIColor.lightGray.cgColor
        viewSearch.layer.borderWidth = 1
        self.earningApiCallMethods()
        // Do any additional setup after loading the view.
    }
    
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    @objc func handleRefresh(_ sender: Any?)
    {
        print("Pull To Refresh Method Called")
        page = 1
        pagereload = 0
        url_flag = 1
        refreshController.endRefreshing()
        
        //  func_API_GroupIndex()
    }
    
    
    //     MARK: - Scrolling data 1-10 Method
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        let currentOffset: CGFloat = scrollView.contentOffset.y
        let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        //fetchingMore = true
        // tbl_earning.reloadSections(IndexSet(integer: 1), with: .none)
        if maximumOffset - currentOffset <= 10.0
        {
            print("Scroll is End")
            if self.arrEarning.count >= 10
            {
                // fetchingMore = true
                pagereload = 1
                page = page + 1
                url_flag = 1
                
                // func_API_GroupIndex()
            }
        }
    }
    
    //        func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //            let currentOffset: CGFloat = scrollView.contentOffset.y
    //           let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
    //           fetchingMore = true
    //           tbl_earning.reloadSections(IndexSet(integer: 1), with: .none)
    //           if maximumOffset - currentOffset <= 10.0
    //           {
    //               print("Scroll is End")
    //               if self.arrEarning.count >= 10
    //               {
    //                   fetchingMore = true
    //                  // pagereload = 1
    //                  // page = page + 1
    //                 //  url_flag = 1
    //
    //                  // func_API_GroupIndex()
    //               }
    //           }
    //           else
    //           {
    //
    //             self.fetchingMore = false
    //             self.tbl_earning.reloadData()
    //
    //            }
    //        }
    //
    //        func beginBatchFetch() {
    //            fetchingMore = true
    //            print("beginBatchFetch!")
    //            tbl_earning.reloadSections(IndexSet(integer: 1), with: .none)
    //
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
    //                       let newItems = (self.arrEarning.count...self.arrEarning.count + 12).map { index in index }
    //                       //self.items.append(contentsOf: newItems)
    //                       self.fetchingMore = false
    //                       self.tbl_earning.reloadData()
    //                   })
    //
    //        }
    //
    
    //        func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //              let currentOffset: CGFloat = scrollView.contentOffset.y
    //               let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
    //
    //               if maximumOffset - currentOffset <= 10.0
    //               {
    //                   print("Scroll is End")
    //                   if self.arrEarning.count >= 10
    //                   {
    //                       pagereload = 1
    //                       page = page + 1
    //                       url_flag = 1
    //
    //                      // func_API_GroupIndex()
    //                   }
    //               }
    //        }
    
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    
    func earningApiCallMethods() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":MethodName.APPTYPE.rawValue,"app_version":MethodName.APPVERSION.rawValue,"user_id":user_id ,"user_api_key":user_apikey,"page_no":"0","location":CurrentLocation]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("getAmountHistory", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            
                                            
                                            let dict_Data=tempDict["data"] as! [String:Any]
                                            print("dict_Data is:-",dict_Data)
                                            
                                            var arrProducts = [[String:Any]]()
                                            arrProducts=dict_Data["amount_history"] as! [[String:Any]]
                                            print("arrProducts is:-",arrProducts)
                                            
                                            
                                            if self.url_flag == 1
                                            {
                                                if self.pagereload == 0
                                                {
                                                    
                                                    
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = i+1
                                                        self.index_value = i
                                                        
                                                        self.arrEarning.append(dict_Products)
                                                    }
                                                }
                                                else
                                                {
                                                    
                                                    for i in 0..<arrProducts.count
                                                    {
                                                        var dict_Products = arrProducts[i]
                                                        dict_Products["pagingGroup"] = self.index_value + 1
                                                        self.index_value = self.index_value + 1
                                                        
                                                        self.arrEarning.append(dict_Products)
                                                    }
                                                }
                                            }
                                            
                                            self.tbl_earning.reloadData()
                                            
                                        }
                                            
                                        else
                                        {
                                            self.tbl_earning.isHidden = true
                                            
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
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //return 170
        
        //             if indexPath.section == 0
        //             {
        return 170
        //             }
        //            else
        //             {
        //                return 44
        //             }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        
        //              if section == 0
        //              {
        return self.arrEarning.count
        //              }
        //              else if section == 1 && fetchingMore
        //              {
        //                  return 1
        //              }
        //              return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        // CONSTANTIA
        
        //              if indexPath.section == 0 {
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "EarningHistoryCell", for: indexPath) as! EarningHistoryCell
        
        cell_Add.view1.layer.shadowColor = UIColor.lightGray.cgColor
        cell_Add.view1.layer.shadowOpacity = 5.0
        cell_Add.view1.layer.shadowRadius = 5.0
        cell_Add.view1.layer.shadowOffset = CGSize (width: 1.5, height: 1.5)
        cell_Add.view1.layer.masksToBounds = false
        cell_Add.view1.layer.cornerRadius = 5.0
        
        let dict_eventpoll = self.arrEarning[indexPath.row]
        let description = dict_eventpoll["wallet_history_description"] as! String
        let orederdate = dict_eventpoll["created_at"] as! String
        
        
        cell_Add.lbl1.text = orederdate
        
        // cell_Add.lbl2.text = amount
        cell_Add.lbl3.text = description
        
        let debitamt = dict_eventpoll["debit_amt"] as! String
        let creditamt = dict_eventpoll["credit_amt"] as! String
        
        
        if debitamt == "0.00"
        {
            cell_Add.lbl2.text = rupee + " " + creditamt
            cell_Add.lbl2.textColor = UIColor.green
        }
        else
        {
            cell_Add.lbl2.text = rupee + " " +  debitamt
            cell_Add.lbl2.textColor = UIColor.red
        }
        
        return cell_Add
        
        //             }
        //              else
        //              {
        //                 let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
        //                 cell.spinner.startAnimating()
        //                 return cell
        //              }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
}
class EarningHistoryCell: UITableViewCell {
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var lbl8: UILabel!
    @IBOutlet weak var lbl9: UILabel!
    
    @IBOutlet weak var btn_next: UIButton!
    
    
    
    // Initialization code
}
