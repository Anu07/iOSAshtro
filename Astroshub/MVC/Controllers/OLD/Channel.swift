//
//  Channel.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 30/05/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DatabaseRepresentation {
    var representation: [String: Any] { get }
}

struct Channel {
    let id :String?
    let Chat_id: String
    let astrologer_name: String
    let user_name:String
    
    init(chatId: String, astroName: String, userName:String) {
        self.Chat_id = chatId
        self.astrologer_name = astroName
        self.user_name = userName
        self.id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let Chat_id = data["Chat_id"] as? String else {
            return nil
        }
        guard let astrologer_name = data["astrologer_name"] as? String else {
            return nil
        }
        guard let user_name = data["user_name"] as? String else {
            return nil
        }
        self.id = document.documentID
        self.Chat_id = Chat_id
        self.astrologer_name = astrologer_name
        self.user_name = user_name
    }
    
}

extension Channel: DatabaseRepresentation {
    
    var representation: [String : Any] {
        let rep = ["Chat_id": self.Chat_id,
                   "astrologer_name":self.astrologer_name,
                   "user_name":self.user_name]
        
        return rep
    }
    
}

extension Channel: Comparable {
    
    static func < (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.user_name < rhs.user_name
    }
    
}

