//
//  InfoVC.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 25/05/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {

    @IBOutlet weak var lblNote: UILabel!
    var categoryID = ""
    var notes = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.setNote()
        self.lblNote.text = self.notes
        // Do any additional setup after loading the view.
    }
    
    func setNote() {
        // past life regresstion = 9, graphology = 8, online vastu service = 7, birthtime = 6, yantras = 4, rudraksha = 3 , gemstone 2
        switch self.categoryID {
        case "2":
            self.lblNote.text = "Note:-Gemstones are available in customized with Ratti(Carat), so if the prize given is 5000 and you want to buy 5 Ratti(Carat), then the prize will be 5*5000=25000. These are sample products, the actual product may vary a little bit but the quality will be the same, and we provide energize stones with proper lab-tested certification. We deal in pure natural stones, non-heated, non-treated which are from different parts of the world i.e America, Italy, Iran, Burma, Srilanka, Bangkok etc."
        case "4":
            self.lblNote.text = "Note:-We have all the energized yantras. All the yantras are made of copper with proper frames to install it easily without any hassle."
        case "3":
            self.lblNote.text = "Note:-We provide all the energized rudraksha from Indonesia and Nepal."
        case "9": // past lime regression
            self.lblNote.text = "Everyone is gone through some or the another issues in their life and that creates curiosity to know that what can be our last JANAMA. No one comes in a person’s life without any reason. Every relationship is interlinked with each other by some means because of the past connections, some times we called them those relations as karmic relations or sometimes soul relations. If one keeps making relations and keep making contacts with people those he feels that he is so attached with somehow means that person karma is still pending and he has to finish it till it is not finished. It means, if someone keeps coming repeatedly in someone life or if one is not able to resolve some unfinished issues, then it means person or issues are linked with some karmic baggage of past lives. Even the fortune or downfall one shares in his married or career life or luck with someone, which clearly indicated that such a relationship is developing in this life because of past debts. It is also has been seen that at same times someone becomes good for the other and our astrologer can help to find our your previous life karmas and this can help an individual to clear karmic debts"
        case "6":
            self.lblNote.text = "Birth time rectification is a janambuti for many people. it’s a great concept for those people who don’t know their time of birth or are confuse about their time of birth. In this service a native can take the help of our highly knowledgeable astrologers, in this user has to provide some past events moles, birthmarks etc, by using them our astrologer rectify their birth time and help them to get future predictions."
        case "8":
            self.lblNote.text = "Graphology is a great concept where analyzing the signature and handwriting, a graphologist can tell a lot about themselves. In fact, the handwriting of the person holds amazing secrets about them. It studies a human’s behavior and explore their many details which they might be unaware too. A persons handwriting changes time to time its either because of certain changes in life and upcoming event. Signature analysis has power to tell that what small-small changes in the signature itself can bring a lot of positive changes in their life and our experts are highly knowledgeable to help you in this."
        default:
            self.lblNote.text = ""
        }
    }

    @IBAction func buttonClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
