//
//  FireBaseConstants.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 06/06/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import FirebaseFirestore
import FirebaseStorage

enum FireBase {
//    static let key = """
//AAAArtu7j-U:APA91bELA3rlFVQ8BIxeDYzf7PclLkIgXX3lL8SSLx5hLqjWauqZ
//0ubzN1ASEpr46a1Cfo2UIQ6wX2pZR4mbT2Br23d8OrGwkaIN-7PrpleVH1-VlLbrvcjDQ15x4ZfSBQ0fE8An5bYU
//""".replacingOccurrences(of: "\n", with: "")
    
    enum Style: Int {
        case single, group
    }
    
    enum MessageType {
        case text, photo, video
        
        var value: String {
            switch self {
            case .text:
                return "text"
            case .photo:
                return "photo"
            case .video:
                return "video"
            }
        }
    }
    
    enum Reference {
        private static let base = Firestore.firestore()
        static let users = base.collection("Users")
        static let threads = base.collection("Threads")
        static let storage = Storage.storage().reference().child("GroupDPs")
        static let msgImagesStorage = Storage.storage().reference().child("message_images")
    }
    
    enum Thread {
        static let name = "name"
        static let node = "node"
        static let image = "image"
        static let style = "style"
        static let lastMessage = "last_message"
        static let time = "time"
        static let members = "members"
        static let senderId = "senderId"
        static let readStatus = "read_status"
        static let ownerId = "ownerId"
        static let messages = "messages"
        static let threadLastSeen = "threadLastSeen"
        static let type = "type"
    }
    
    enum Message {
        static let content = "content"
        static let node = "node"
        static let senderId = "senderId"
        static let time = "time"
        static let type = "type"
        static let thumbnailUrl = "thumbnailUrl"
    }
    
    enum Person {
        static let name = "name"
        static let node = "user_uni_id"
        static let image = "imageUrl"
        static let token = "fcm_token"
        static let email = "email"
        static let threads = "threads"
    }
}

