

import UIKit

class FrequentlyAskQuestionVC: UIViewController {
    
    
    @IBOutlet weak var tableviewFAQ:UITableView!
    var openCell = -1
    
    var values = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableviewFAQ.estimatedSectionHeaderHeight = 70
        self.tableviewFAQ.sectionHeaderHeight = UITableView.automaticDimension
        self.tableviewFAQ.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
        self.tableviewFAQ.register(UINib(nibName: "FAQCell2", bundle: nil), forCellReuseIdentifier: "FAQCell2")
        self.func_termsConditiondata()
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func func_termsConditiondata() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios",
                             "app_version":"1.0",
                             "user_id":user_id ,
                             "user_api_key":user_apikey,
                             "page_type":"faq"]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        
//        AppHelperModel.requestGETURL("cms", success: { (result) in
//            AutoBcmLoadingView.dismiss()
//            if let getDict = result as? [String:Any] {
//                if let response = getDict["response"] as? Bool , response {
//                    if let getData = getDict["data"] as? [[String:String]] {
//                        self.values = getData
//                        self.tableviewFAQ.reloadData()
//                    }
//                } else {
//                    CommenModel.showDefaltAlret(strMessage:"Something went wrong", controller: self)
//                }
//            }
//            print(result)
//        }) { (error) in
//            AutoBcmLoadingView.dismiss()
//            CommenModel.showDefaltAlret(strMessage:"Something went wrong", controller: self)
//        }
        AppHelperModel.requestPOSTURL("cms", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
//                                        let tempDict = respose as! NSDictionary
//                                        print(tempDict)
                                        if let tempDict = respose as? NSDictionary {
                                            let dataObj = (tempDict["data"] as? [[String:Any]])
                                            
                                            if let getArray = dataObj?.first, let ArrayOfDict = getArray["page_description"] as? [[String:String]] {
                                                self.values = ArrayOfDict
                                                self.tableviewFAQ.reloadData()
                                            }
                                        } else {
                                            CommenModel.showDefaltAlret(strMessage:"message", controller: self)
                                        }


        }) { (error) in
            print(error)
            AutoBcmLoadingView.dismiss()
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        if sender.tag == self.openCell {
            self.openCell = -1
            self.tableviewFAQ.reloadData()
            return
        }
        self.openCell = sender.tag
        self.tableviewFAQ.reloadData()
    }
    
    
}

extension FrequentlyAskQuestionVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if openCell == section {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if openCell == indexPath.section {
            return UITableView.automaticDimension
        }
        return 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell2", for: indexPath) as! FAQCell2
        let value = values[indexPath.section]
        cell.lblText.text = value["answer"]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell") as! FAQCell
        let value = values[section]
        if section == openCell {
            cell.imgView.image = UIImage(named: "arrowUp")
            
        } else {
            cell.imgView.image = UIImage(named: "arrowDown")
        }
        cell.lblHeading.text = value["question"]
        cell.btnSelect.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        cell.btnSelect.tag = section
        return cell
    }
    
    
    
}
