//
//  MytrasViewController.swift
//  Astroshub
//
//  Created by Gurpreet Singh on 11/11/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import AVFoundation
import PDFKit
import QuickLook
class MytrasViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var audioPlayer : AVPlayer!
    var docController:UIDocumentInteractionController!
    
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
//        cell.imageViewForuser.sd_setImage(with: URL(string: data["mantra_image"] as? String ??
//                                                        ""), placeholderImage:#imageLiteral(resourceName: "appstore"))
        //
        cell.imageViewForuser.image = #imageLiteral(resourceName: "Mantras-1")
        if data["mantra_file"] as? String == ""{
            cell.downloadOption.isHidden = true
            
        } else {
            let array = (data["mantra_file"] as! String ).components(separatedBy: ".")
            if array.contains("pdf"){
                cell.downloadOption.isHidden = false
                cell.downloadOption.tag = indexPath.row
                cell.downloadOption.addTarget(self, action: #selector(downloadFilePdf), for: .touchUpInside)
                
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
    @objc  func downloadFilePdf(_ sender:UIButton) {
        //        AutoBcmLoadingView.show("Loading......")
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
        
        if !urlString.isEmpty{
            checkBookFileExists(withLink: urlString){ [weak self] downloadPath in
                guard let self = self else{
                    return
                }
                //                    play(url: downloadedURL)
            }
        }
    }
    func checkBookFileExists(withLink link: String, completion: @escaping ((_ filePath: URL)->Void)){
        let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        if let url  = URL.init(string: urlString ?? ""){
            let fileManager = FileManager.default
            if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){
                
                let filePath = documentDirectory.appendingPathComponent(url.lastPathComponent, isDirectory: false)
                
                do {
                    if try filePath.checkResourceIsReachable() {
                        print("file exist")
                        completion(filePath)
                        self.open_pdf(pdfUrl : filePath)
                        
                    } else {
                        print("file doesnt exist")
                        downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
                    }
                } catch {
                    print("file doesnt exist")
                    downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
                }
            }else{
                print("file doesnt exist")
            }
        }else{
            print("file doesnt exist")
        }
    }
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data.init(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                print("saved at \(filePath.absoluteString)")
                self.open_pdf(pdfUrl : filePath)
                DispatchQueue.main.async {
                    completion(filePath)
                }
            } catch {
                print("an error happened while downloading or saving the file")
            }
        }
    }
    func open_pdf(pdfUrl : URL) {
        
        //        if let fileURL = NSBundle.mainBundle().URLForResource("MyImage", withExtension: "jpg") {
        // Instantiate the interaction controller
        
        //        if (pdfUrl != "") {
        // Initialize Document Interaction Controller
        self.docController = UIDocumentInteractionController(url: pdfUrl)
        
        // Configure Document Interaction Controller
        self.docController.delegate = self
        
        // Present Open In Menu
        self.docController.presentOptionsMenu(from: view.frame, in: self.view, animated: true)
        //presentOpenInMenuFromRect
        //           }
        //                }
        //            let pdfView = PDFViewController()
        //            pdfView.pdfURL = pdfUrl
        //            present(pdfView, animated: true, completion: nil)
        
        //        let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
        //
        //            documentPicker.delegate = self
        //        if #available(iOS 13.0, *) {
        //            documentPicker.directoryURL = pdfUrl
        //        } else {
        //            // Fallback on earlier versions
        //        }
        //            present(documentPicker, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = self.dataStatus[indexPath.row] as! [String:Any]
        
        if data["id"] as? String == idForMantras {
            return UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
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



extension MytrasViewController:UIDocumentInteractionControllerDelegate{
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}
