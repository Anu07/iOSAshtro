//
//  PanchangVC.swift
//  Astroshub
//
//  Created by Kriscent on 11/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import GooglePlaces
import WebKit
class PanchangVC: UIViewController ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,WWCalendarTimeSelectorProtocol,GMSAutocompleteViewControllerDelegate,WKNavigationDelegate{
    
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet var tbl_kundalimatch: UITableView!
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var date_Selectdate = ""
    var postdob = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AutoBcmLoadingView.show("Loading......")
        self.wkWebView.navigationDelegate = self
        let url = URL (string: "http://kriscenttechnohub.com/demo/astroshubh/admin/panchang.php")
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
        let PanchangList = self.storyboard?.instantiateViewController(withIdentifier: "PanchangListVC")
        self.navigationController?.pushViewController(PanchangList!, animated: true)
    }
    
    //****************************************************
    // MARK: - Tableview Method
    //****************************************************
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell_Add = tableView.dequeueReusableCell(withIdentifier: "KundaliMatching1", for: indexPath) as! KundaliMatching1
        
        cell_Add.btndob.tag = indexPath.row
        cell_Add.btndob.addTarget(self, action: #selector(self.btn_DobAction(_:)), for: .touchUpInside)
        
        cell_Add.btnplace.tag = indexPath.row
        cell_Add.btnplace.addTarget(self, action: #selector(self.btn_PlaceAction(_:)), for: .touchUpInside)
        
        if self.date_Selectdate != ""
        {
            cell_Add.btndob.setTitleColor(.black, for: .normal)
            cell_Add.btndob.setTitle(self.date_Selectdate,for: .normal)
        }
        
        return cell_Add
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
    }
    @objc func btn_PlaceAction(_ sender: UIButton)
    {
        func_AutocompleteViewController()
    }
    @objc func btn_DobAction(_ sender: UIButton)
    {
        
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
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        //   self.date_Selectdate = date.stringFromFormat("yyyy-MM-dd")
        
        let dob = date.stringFromFormat("yyyy-MM-dd")
        self.date_Selectdate = self.formattedDateFromString(dateString: dob, withFormat: "dd MMM yyyy")!
        self.postdob = date.stringFromFormat("dd-MM-yyyy")
        self.tbl_kundalimatch.reloadData()
        
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
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
    
    
}
