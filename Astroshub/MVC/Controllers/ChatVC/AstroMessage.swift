//
//  Message.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 30/05/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

final class AstroMessage {
    var content = String()
    var node = String()
    var time = Double()
    var groupingTime = String()
    var senderId = String()
    var type = String()
    var thumbnailUrl = String()
    var wasSent: Bool {
        get {
            return senderId == user_id
        }
    }
    
    init(_ data: [String: Any]) {
//        self.node = node
        print("message data \(data)")
        content = data[FireBase.Message.content] as? String ?? ""
        time = data[FireBase.Message.time] as? Double ?? 0
        groupingTime = ""
        senderId = data[FireBase.Message.senderId] as? String ?? ""
        type = data[FireBase.Message.type] as? String ?? ""
        thumbnailUrl = data[FireBase.Message.thumbnailUrl] as? String ?? ""
    }
}
