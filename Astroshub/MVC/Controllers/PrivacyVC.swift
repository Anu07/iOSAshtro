//
//  PrivacyVC.swift
//  SearchDoctor
//
//  Created by Kriscent on 02/12/19.
//  Copyright © 2019 Kriscent. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    var arrPrivacy = [[String:Any]]()
    @IBOutlet var tbl_terms: UITableView!
    
    @IBOutlet weak var txt_description: UITextView!
    var pagedescriptionnnnnn = ""
    @IBOutlet weak var view_top: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_terms.tableFooterView = UIView()
        
        
        self.func_privacyPolicydata()
        
        // Do any additional setup after loading the view.
    }
    
    
    //****************************************************
    // MARK: - Custom Method
    //****************************************************
    
    //****************************************************
    // MARK: - API Methods
    //****************************************************
    func func_privacyPolicydata() {
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
        let setparameters = ["app_type":"ios","app_version":"1.0","user_id":user_id ,"user_api_key":user_apikey,"page_type":"privacy-policy"]
        
        print(setparameters)
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL("cms", params: setparameters as [String : AnyObject],headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        
                                        if success == true
                                        {
                                            self.arrPrivacy = (tempDict["data"] as? [[String:Any]])!
                                            print("dict_Data is:- ",self.arrPrivacy)
                                            
                                            for i in 0..<self.arrPrivacy.count
                                            {
                                                let dict_Users = self.arrPrivacy[i]
                                                self.pagedescriptionnnnnn=dict_Users["page_description"] as! String
                                                
                                                
                                            }
                                            
                                            // let url=dict_Data["page_link"] as! String
                                            
                                            // self.pagedescriptionnnnnn = dict_Data!["page_description"] as! String
                                            self.tbl_terms.reloadData()
                                            // self.txt_description.text = pagedescription
                                            
                                            //self.txt_description.attributedText = pagedescription.htmlToAttributedString
                                            
                                            
                                            
                                            
                                            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let PackageList2 = tableView.dequeueReusableCell(withIdentifier: "BloddescrCell", for: indexPath) as! BloddescrCell
        PackageList2.lbl_Packagetitle.attributedText = pagedescriptionnnnnn.htmlToAttributedString
        //PackageList2.lbl_Packagetitle.text = ppUSerApp
        
//       let theString = "<h1>H1 title</h1><b>Logo</b><img src='http://www.aver.com/Images/Shared/logo-color.png'><br>~end~"
//
//        let theAttributedString = try! NSAttributedString(data: theString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!,
//            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
//            documentAttributes: nil)
//
//        PackageList2.lbl_Packagetitle.attributedText = theAttributedString
        
        return PackageList2
        
       // Cannot convert value of type 'NSAttributedString.DocumentAttributeKey' to expected dictionary key type 'NSAttributedString.DocumentReadingOptionKey'
    }
    //****************************************************
    // MARK: - Memory CleanUP
    //****************************************************
    
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue) else { return NSAttributedString() }
        do {
            
            let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                    NSAttributedString.DocumentType.html]
            let attributedString = try? NSMutableAttributedString(data: htmlData,
                                                                      options: options,
                                                                      documentAttributes: nil)
            
            return attributedString
        } catch {
            return NSAttributedString()
        }
        
        
      
        
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
/*
 var htmlToAttributedString: NSAttributedString? {
     guard let data = data(using: .utf8) else { return NSAttributedString() }
     do {
         return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
     } catch {
         return NSAttributedString()
     }

     
 }
 */


//let ppUSerApp =
//"Astroshubh is India’s most trusted online astrology service.\n\nOnline Horoscope☎️📞Astrology✡🔮Kundli, Tarot, Numerology, Zodiac, Gemstone💎, Yantras, Rudraksha, Mobile numerology📱, Past life Regression, Graphology, Handwriting analysis📝, signature analysis✍🏻, Online Vastu services🧭, Colour therapy\n\n👨‍💻Get in touch with our BEST ASTROLOGERS in ONE easy step.\n👨‍💻Astroshubh hires astrologers after an interview to serve the best predictions for our valuable customers.\n😎 Know your FORTUNE and have a BETTER FUTURE!😎\n\n\n ASTROSHUBH“Astrologically Your’s”\n\n 🌟Astroshubh is the BEST ONLINE ASTROLOGY app. You can ask the following questions from our best astrologers When will I get married❓ When will I get into a relationship❓ Will my ex come back to my life? Can I get married to my boyfriend?❔ I am Manglik. What should I do❓ Will I have love or arrange marriage❓when will I get a job❔When will I get to change my job❓ When will I get promoted❓ Can I settle abroad❓ What kind of partner will I get❓What kind of business suits me❓ Which is lucky color for me❓ which entrance to choose for my home❓ When will I become a parent❓ Will, my child do well in studies❓ Will I have any health issues in the future❔ I am not getting results in life as per my efforts?❔What remedies should I do❓ Can I get an online Puja done to get over my issues❓Will I ever become famous❓ When can I acquire good wealth❓When can I buy a car❓ When will I buy my own house❓Which line should I start my business❓ Best muharat for a new beginning of a business? What should I name my business as per Numerology❔\n\n ☎️ 📱Talk to Astrologers\n Astroshubh provides TALK TO ASTROLOGER service, where you can connect instantly with India’s Best Astrologers.\n 📝Ask Query/Get Report\nAstroshubh provides ASK QUERY /GET REPORT services, this service is especially for those people who want to take guidance from our astrologers and have a low budget, in this you can ask about the difficulties of life in minimum price.💱\n 🛒  Astroshop🛒 Astro shop is a place where you can get Gemstones💎💍Yantra🔯✡️Rudraksh and much more exciting products, we believe in quality we sell all the international gemstones which are untreated and unheated and rudraksh from Indonesia and Nepal\n\n ☯️Know about your luck☯️\nThe luckiest factor is that Maharishi Parashar has left his divine knowledge fo the people in kalyuga and we can take advantage of that with accurate predictions by some experts by your Kundli Chart (Kundali / Birth Chart / Janampatri) using Vedic Astrology (Hindu Astrology / Indian Astrology / Jyotish/Nadi astrology/Kp Astrology/Free horoscopes/weekly horoscopes/monthly horoscopes ).\n\n 👩🏻🎓Areas of Expertise\nExpertise in Astrology,  Numerology, Tarot Card Reader, Vastu Shastra, Vedic Astrology, palmistry, Powerful Remedies Provider. Nadi Astrology, Laal Kitaab, Numerology, Mobile Numerology, Vastu, (KP) Astrology, Numerology, Karma Remedies & Puja Expert, Horary Astrology, Gemology & Medical Astrology, Spiritual Healer, Online Kundali Matching, Online Vastu🧭🏚️.\n\n ☀️Daily Life Astrology🔱💭💬\nMany types of services that have the ability to solve all the areas of your life, online horoscope, love horoscope, kundali matching / Kundli matching, astrology signs, horoscope by date of birth, lucky gemstone💎, 🔹🔸lucky color, lucky number, lucky day\n\n 🔒 Your PRIVACY and SECURITY 🔐our priority\n Your details and discussions are completely private between you and your astrologer. We assure your safety.\n\n 💯 Guaranteed Service\nYou can reach us 24*7 by a single click. Our astrologers will analyze your birth chart and your astrology sign and will provide the best horoscope astrology to you with accurate future predictions online. If in any case, the expected astrologer is not available at a time, Our customer service representative will always be available to help you."


let ppUSerApp = ""
