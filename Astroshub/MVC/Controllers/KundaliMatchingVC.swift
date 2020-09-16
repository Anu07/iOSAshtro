//
//  KundaliMatchingVC.swift
//  Astroshub
//
//  Created by Kriscent on 11/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import GooglePlaces
import WebKit

class KundaliMatchingVC: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,WWCalendarTimeSelectorProtocol, GMSAutocompleteViewControllerDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var wkWebView: WKWebView!
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var date_Selectdate = ""
    var postdob = ""
    var Timmeee = ""
    var date_Selectdate1 = ""
    var postdob1 = ""
    var Timmeee1 = ""
    @IBOutlet var tbl_kundalimatch: UITableView!
    var dobandtimeclick = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AutoBcmLoadingView.show("Loading......")
        
        let url = URL (string: "http://kriscenttechnohub.com/demo/astroshubh/admin/kundali_matching.php")
        let requestObj = URLRequest(url: url!)
        self.wkWebView.load(requestObj)
        
        // Do any additional setup after loading the view.
    }
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
   func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AutoBcmLoadingView.dismiss()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("started")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        AutoBcmLoadingView.dismiss()
    }
    
    
    
    
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
    @IBAction func btn_submitAction(_ sender: Any)
    {
        let KundaliMatchingList = self.storyboard?.instantiateViewController(withIdentifier: "KundaliMatchingListVC")
        self.navigationController?.pushViewController(KundaliMatchingList!, animated: true)
    }
    
    
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 2
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if section==0
            
        {
            return 1
            
        }
            
        else
        {
            return 1
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "KundaliMatching1", for: indexPath) as! KundaliMatching1
            
            cell_Add.btndob.tag = indexPath.row
            cell_Add.btndob.addTarget(self, action: #selector(self.btn_DobAction(_:)), for: .touchUpInside)
            
            cell_Add.btntime.tag = indexPath.row
            cell_Add.btntime.addTarget(self, action: #selector(self.btn_TimeAction(_:)), for: .touchUpInside)
            
            cell_Add.btnplace.tag = indexPath.row
            cell_Add.btnplace.addTarget(self, action: #selector(self.btn_PlaceAction(_:)), for: .touchUpInside)
            
            if self.date_Selectdate != ""
            {
                cell_Add.btndob.setTitleColor(.black, for: .normal)
                cell_Add.btndob.setTitle(self.date_Selectdate,for: .normal)
            }
            if self.Timmeee != ""
            {
                cell_Add.btntime.setTitleColor(.black, for: .normal)
                cell_Add.btntime.setTitle(self.Timmeee,for: .normal)
            }
            return cell_Add
        }
        else
        {
            let cell_Add = tableView.dequeueReusableCell(withIdentifier: "KundaliMatching2", for: indexPath) as! KundaliMatching2
            
            
            cell_Add.btndob.tag = indexPath.row
            cell_Add.btndob.addTarget(self, action: #selector(self.btn_DobAction1(_:)), for: .touchUpInside)
            
            cell_Add.btntime.tag = indexPath.row
            cell_Add.btntime.addTarget(self, action: #selector(self.btn_TimeAction1(_:)), for: .touchUpInside)
            
            cell_Add.btnplace.tag = indexPath.row
            cell_Add.btnplace.addTarget(self, action: #selector(self.btn_PlaceAction1(_:)), for: .touchUpInside)
            
            if self.date_Selectdate1 != ""
            {
                cell_Add.btndob.setTitleColor(.black, for: .normal)
                cell_Add.btndob.setTitle(self.date_Selectdate1,for: .normal)
            }
            if self.Timmeee1 != ""
            {
                cell_Add.btntime.setTitleColor(.black, for: .normal)
                cell_Add.btntime.setTitle(self.Timmeee1,for: .normal)
            }
            
            return cell_Add
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    
    @objc func btn_PlaceAction(_ sender: UIButton)
    {
        func_AutocompleteViewController()
    }
    @objc func btn_TimeAction(_ sender: UIButton)
    {
        dobandtimeclick = "time"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        
        present(selector, animated: true, completion: nil)
    }
    @objc func btn_DobAction(_ sender: UIButton)
    {
        dobandtimeclick = "dob"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        
        present(selector, animated: true, completion: nil)
        
    }
    @objc func btn_TimeAction1(_ sender: UIButton)
    {
        dobandtimeclick = "time1"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        
        present(selector, animated: true, completion: nil)
    }
    @objc func btn_DobAction1(_ sender: UIButton)
    {
        dobandtimeclick = "dob1"
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        
        present(selector, animated: true, completion: nil)
        
    }
    @objc func btn_PlaceAction1(_ sender: UIButton)
    {
        func_AutocompleteViewController()
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        //   self.date_Selectdate = date.stringFromFormat("yyyy-MM-dd")
        
        if dobandtimeclick == "dob"
        {
            let dob = date.stringFromFormat("yyyy-MM-dd")
            self.date_Selectdate = self.formattedDateFromString(dateString: dob, withFormat: "dd MMM yyyy")!
            self.postdob = date.stringFromFormat("dd-MM-yyyy")
            self.tbl_kundalimatch.reloadData()
        }
        if dobandtimeclick == "time"
        {
            let time = date.stringFromFormat("hh:mm a")
            self.Timmeee = time
            self.tbl_kundalimatch.reloadData()
        }
        if dobandtimeclick == "dob1"
        {
            let dob = date.stringFromFormat("yyyy-MM-dd")
            self.date_Selectdate1 = self.formattedDateFromString(dateString: dob, withFormat: "dd MMM yyyy")!
            self.postdob1 = date.stringFromFormat("dd-MM-yyyy")
            self.tbl_kundalimatch.reloadData()
        }
        if dobandtimeclick == "time1"
        {
            let time = date.stringFromFormat("hh:mm a")
            self.Timmeee1 = time
            self.tbl_kundalimatch.reloadData()
        }
        print(self.date_Selectdate)
        
        // dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        if let date = dates.first {
            singleDate = date
            //  dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
        }
        else {
            // dateLabel.text = "No Date Selected"
        }
        multipleDates = dates
    }
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    func func_AutocompleteViewController()
      {
          let autocompleteViewController = GMSAutocompleteViewController()
          autocompleteViewController.delegate = self
          present(autocompleteViewController, animated: true, completion: nil)
      }
      
      //    MARK:- GMSAutocomplete'S delegate methods
      func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
      {
          print("Place : \(place)")
          print("Place name: \(place.name)")
          print("address is:-",place.formattedAddress ?? "address is nil")
    
          let location = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
          
          fetchCityAndCountry(from: location) { city, country, error in
              guard let city = city, let country = country, error == nil else { return }
              print(city + ", " + country)
              //self.txt_City.text = city // Rio de Janeiro, Brazil
              
              // self.btn_city.setTitle(city,for: .normal)
              // cityyPlans  = city
          }
          
          
          //str_Address=place.formattedAddress!
          // print(str_Address)
          //  btn_city.setTitle(str_Address,for: .normal)
          // self.btn_city.contentEdgeInsets = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 0)
          // cityyPlans  = place.formattedAddress!
          
          
          
          dismiss(animated: true, completion: nil)
      }
      
      func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ())
      {
          CLGeocoder().reverseGeocodeLocation(location)
          { placemarks, error in
              completion(placemarks?.first?.locality,
                         placemarks?.first?.country,
                         error)
              // self.locality2 = placemarks?.first?.locality
          }
          
          
      }
      
      
      func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
      {
          print("Error: \(error)")
          dismiss(animated: true, completion: nil)
      }
      
      // User cancelled the operation.
      func wasCancelled(_ viewController: GMSAutocompleteViewController)
      {
          print("Autocomplete was cancelled.")
          dismiss(animated: true, completion: nil)
      }
    
}
class KundaliMatching1: UITableViewCell {
    
    
    //@IBOutlet weak var view1: UIView!
    @IBOutlet weak var btndob: UIButton!
    @IBOutlet weak var btntime: UIButton!
    @IBOutlet weak var btnplace: UIButton!
    
    
    
    
    // Initialization code
}
class KundaliMatching2: UITableViewCell {
    
    
    // @IBOutlet weak var view1: UIView!
    @IBOutlet weak var btndob: UIButton!
    @IBOutlet weak var btntime: UIButton!
    @IBOutlet weak var btnplace: UIButton!
    
    
    
    
    // Initialization code
}
