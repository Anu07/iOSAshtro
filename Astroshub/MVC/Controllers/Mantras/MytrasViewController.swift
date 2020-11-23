//
//  MytrasViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 11/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import AVFoundation

class MytrasViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var audioPlayer : AVPlayer!

    var dataStatus =  Array<Any>()
    var idForMantras :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "HeaderSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderSectionTableViewCell")
        
        apiForGetmytras()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func apiForGetmytras() {
        
        AutoBcmLoadingView.show("Loading......")
        AppHelperModel.requestPOSTURL(MethodName.getMytras.rawValue, params:nil,headers: nil,
                                      success: { (respose) in
                                        AutoBcmLoadingView.dismiss()
                                        let tempDict = respose as! NSDictionary
                                        print(tempDict)
                                        
                                        let success=tempDict["response"] as!   Bool
                                        let message=tempDict["msg"] as!   String
                                        if success == true
                                        {
                                            let dict_Data = tempDict["data"] as! [String:Any]
                                            self.dataStatus = dict_Data["mantra_list"] as! Array<Any>
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
extension MytrasViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSectionTableViewCell", for: indexPath) as! HeaderSectionTableViewCell
        let data = self.dataStatus[indexPath.row] as! [String:Any]
        cell.tableViewHeading.text = data["mantra_title"] as? String
        cell.labeForTime.text = data["created_date"] as? String
        //        cell.imageViewForuser.layer.cornerRadius =  cell.imageViewForuser.frame.height/2
        //        cell.imageViewForuser.clipsToBounds = true
        cell.imageViewForuser.sd_setImage(with: URL(string: data["mantra_image"] as? String ??
                                                        ""), placeholderImage:#imageLiteral(resourceName: "astroshubhL"))
//
        
        if data["mantra_file"] as? String == ""{
            cell.downloadOption.isHidden = true
            
        } else {
            let array = (data["mantra_file"] as! String ).components(separatedBy: ".")
            if array.contains("pdf"){
            cell.downloadOption.isHidden = false
            cell.downloadOption.tag = indexPath.row
            cell.downloadOption.addTarget(self, action: #selector(downloadFile), for: .touchUpInside)
                
            } else {
                cell.downloadOption.isHidden = true
            }
        }
        
        if data["mantra_file"] as? String == ""{
            cell.playBtn.isHidden = true
            
        } else {
            let array = (data["mantra_file"] as! String ).components(separatedBy: ".")
            if array.contains("mp3") || array.contains("mp4") {
            cell.playBtn.isHidden = false
            cell.playBtn.tag = indexPath.row
            
            cell.playBtn.addTarget(self, action: #selector(playAudioFromURL), for: .touchUpInside)
            } else {
                cell.playBtn.isHidden = true
            }
        }
        if data["id"] as? String == idForMantras {
            cell.view2.isHidden = false
            //            cell.label1.text =  data["mantra_content"] as? String
            cell.label1.attributedText =  (data["mantra_content"] as? String)?.htmlToAttributedString
            
        }
        else{
            cell.view2.isHidden = true
            
        }
        return cell
    }
    
    @objc  func playAudioFromURL(_ sender: UIButton) {
        let data = self.dataStatus[sender.tag] as! [String:Any]
        sender.isSelected = !sender.isSelected
        let url = URL.init(string: data["mantra_file"]  as? String  ?? "")
        audioPlayer = AVPlayer.init(url: url!)
        if sender.isSelected {
            audioPlayer.play()
        } else {
            
            audioPlayer.pause()
        }
        

//        playSound(data["mantra_file"]  as? String  ?? "")
       }
    @objc   func downloadFile(_ sender:UIButton) {
        AutoBcmLoadingView.show("Loading......")
        let data = self.dataStatus[sender.tag] as! [String:Any]
        
        let querydownload = data["mantra_file"] as! String
        //  pdfString = querydownload
        DispatchQueue.main.async {
            self.downloadpdf(pdfURL: querydownload)
        }
    }
    func downloadpdf(pdfURL : String){
        let urlString = pdfURL
        let url = URL(string: urlString)
        let fileName = String((url!.lastPathComponent)) as NSString
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
        //Create URL to the source file you want to download
        let fileURL = URL(string: urlString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    AutoBcmLoadingView.dismiss()
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                        //Show UIActivityViewController to save the downloaded file
                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                        for indexx in 0..<contents.count {
                            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                self.present(activityViewController, animated: true, completion: nil)
                            }
                        }
                    }
                    catch (let err) {
                                   print("error: \(err)")
                               }
                           } catch (let writeError) {
                               print("Error creating a file \(destinationFileUrl) : \(writeError)")
                           }
                       } else {
                           print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
                       }
                   }
                   task.resume()
        //       let url = URL(string: pdfURL)
        //       FileDownloader.loadFileAsync(url: url!) { (path, error) in
        //           print("PDF File downloaded to : \(path!)")
        //          AutoBcmLoadingView.dismiss()
        //       }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = self.dataStatus[indexPath.row] as! [String:Any]
        
        if data["id"] as? String == idForMantras {
            return UITableView.automaticDimension
        } else {
            return 100
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.dataStatus[indexPath.row] as! [String:Any]
        idForMantras = data["id"] as? String
        self.tableView.reloadData()
    }
}
