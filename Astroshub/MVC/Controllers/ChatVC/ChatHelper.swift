//
//  ChatHelper.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 06/06/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import FirebaseFirestore
import FirebaseStorage
import AVKit

struct ChatHelper {
    
    func add(message: String, to thread: ChatThread) {
        add(message, to: thread)
    }
    
    static func thread(with user: User, orFrom threads: [ChatThread]) -> ChatThread {
        let node = nodeForChat(with: user)
        if let thread = (threads.filter { $0.node == node }).first {
            return thread
        } else {
            let thread = ChatThread([:], node: node)
            thread.name = setCustomername
            thread.image = UserImageurl
            thread.members = [user, User.current]
            thread.memberIds = thread.members.map { "\($0.userId)" }
            thread.style = FireBase.Style.single
            thread.justCreated = true
            return thread
        }
    }
    
    private static func nodeForChat(with user: User) -> String {
        let data = [user.userId, user_id].sorted(by: <).map { "\($0)" }
        return data.joined(separator: "_")
    }
    
    func resetReadCount(for thread: ChatThread) {
        let threadDic = [FireBase.Thread.readStatus: ["\(user_id)": 0]]
        FireBase.Reference.threads.document(thread.node).setData(threadDic as [String : Any], merge: true)
        
         let updateLastSeen = [FireBase.Thread.threadLastSeen: ["\(user_id)": Int(Date().timeIntervalSince1970)]]
        FireBase.Reference.threads.document(thread.node).setData(updateLastSeen as [String : Any], merge: true)
        
    }
    
    func updateLastSeen(for thread: ChatThread) {
        
         let updateLastSeen = [FireBase.Thread.threadLastSeen: ["\(user_id)": Int(Date().timeIntervalSince1970)]]
        FireBase.Reference.threads.document(thread.node).setData(updateLastSeen as [String : Any], merge: true)
        
    }
    
    func add(_ content: String, to thread: ChatThread, isImage: Bool = false, messageType: FireBase.MessageType = .text) {
        let currentTime = Date().timeIntervalSince1970
        update(thread, from: content, at: currentTime, isImage: isImage, messageType: messageType) {
            let messageBody = self.message(for: thread, from: content, isImage: isImage, at: currentTime, messageType: messageType)
            FireBase.Reference.threads.document(thread.node).collection(FireBase.Thread.messages)
                .addDocument(data: messageBody) { (error) in
                    guard error == nil else { return }
                    // self.notify(for: messageType == .text ? content : (messageType == .photo ? "Shared Photo" : "Shared Video"), in: thread)
                    self.notify(for: content, in: thread)
            }
        }
    }
    
    func update(_ thread: ChatThread, from message: String,
                at currentTime: TimeInterval, creation: Bool = false, isImage: Bool = false, messageType: FireBase.MessageType = .text, completion: (()->Void)? = nil) {
        self.updateUsers(for: thread) {
            let threadDic = self.dictionary(for: thread, and: message, time: currentTime, creation, isImage: isImage, messageType: messageType)
            FireBase.Reference.threads.document(thread.node).setData(threadDic, merge: true) { _ in
                completion?()
            }
        }
    }
    
    func updateUsers(for thread: ChatThread, completion: @escaping ()-> Void) {
           let batch = Firestore.firestore().batch()
           thread.members.enumerated().forEach { index, user in
               let updateTask = FireBase.Reference.users.document("\(user.userId)")
               user.threadIds.insert(thread.node)
               let newNodeDic = [FireBase.Person.threads: FieldValue.arrayUnion([thread.node])]
               batch.updateData(newNodeDic, forDocument: updateTask)
               if index == thread.members.count - 1 {
                   batch.commit { error in
//                       Indicator.shared.hide()
                       print("Updated Users", error.debugDescription)
                       completion()
                   }
               }
           }
       }
    
    func message(for thread: ChatThread, from message: String, isImage: Bool = false,
                 at currentTime: TimeInterval, messageType: FireBase.MessageType, thumbnailUrl: String = "") -> [String: Any] {
        let dictionary: [String: Any] = [FireBase.Message.content: message,
                                         FireBase.Message.senderId: user_id,
                                         FireBase.Message.time: currentTime,
                                         FireBase.Message.node: thread.node,
                                         FireBase.Message.type: messageType.value]
        return dictionary
    }
    
    func dictionary(for thread: ChatThread, and message: String,
                    time: Double, _ creation: Bool, isImage: Bool = false, messageType: FireBase.MessageType = .text) -> [String: Any] {
        var dictionary: [String: Any] = [
            FireBase.Thread.lastMessage: message,
            FireBase.Thread.members: thread.memberIds.map { $0 },
            FireBase.Thread.node: thread.node,
            FireBase.Thread.time: time,
            FireBase.Thread.style: thread.style.rawValue,
            FireBase.Thread.readStatus: readStatusDic(for: thread, newMessage: creation) as Any,
            FireBase.Thread.threadLastSeen: lastSeenStatus(for: thread) as Any,
            FireBase.Thread.type: messageType.value
        ]
        if thread.style == .group {
            dictionary[FireBase.Thread.ownerId] = thread.ownerId
        }
        if let name = thread.name {
            dictionary[FireBase.Thread.name] = name
        }
        if let image = thread.image {
            dictionary[FireBase.Thread.image] = image
        }
        return dictionary
    }
    
    func readStatusDic(for thread: ChatThread, newMessage created: Bool = false) -> [String: Int]? {
        thread.readStatus = thread.members.reduce(thread.readStatus) { dic, user in
            let dicObj = dic
            let previousValue = dicObj["\(user.userId)"] as? Int ?? 0
            let intialCountForStyle = thread.style == .group ? 0 : 1
            dicObj["\(user.userId)"] = created ? intialCountForStyle : (previousValue + 1)
            dicObj["\(User.current.userId)"] = 0
            return dicObj
        }
        return thread.readStatus as? [String : Int]
    }
    
    func lastSeenStatus(for thread: ChatThread) -> [String: Int]? {
        thread.threadLastSeen = thread.members.reduce(thread.threadLastSeen) { dic, user in
            var dicObj = dic
            dicObj["\(User.current.userId)"] = Int(Date().timeIntervalSince1970)
            return dicObj
        }
        return thread.threadLastSeen
    }
    
    func notify(for message: String, in thread: ChatThread) {
        fcmTokens(for: thread) { tokens in
            guard tokens.count > 0 else { return }
            var params = self.notification(for: message, in: thread)
            params["registration_ids"] = tokens
//            FirebaseEndpoints.notifyChat(params).request(withHiddenIndicator: true) { data in
//                debugPrint(data)
//            }
        }
    }
    
    func notification(for message: String, in thread: ChatThread) -> [String: Any] {
        let notification: [String : Any] = [
            "body": message,
            "title": thread.style == .single ? "" : thread.name ?? "New Message",
            "sound": "default",
            "badge": 1,
            "content-available": 1,
            "icon": "notification_2"
        ]
        
        return [
            
            "notification": notification,
            "data": [
                "thread_id": thread.node,
                "name": ""
            ]
        ]
    }

    func fcmTokens(for thread: ChatThread, completion: @escaping ([String]) -> Void) {
        var fcmTokens = thread.members.compactMap { $0.firebaseToken }
        if let index = fcmTokens.firstIndex(of: UserDefaults.standard.string(forKey: "FcmToken") ?? "") {
            fcmTokens.remove(at: index)
        }
        guard fcmTokens.count == 0 else {
            completion(fcmTokens)
            return
        }
        FireBase.Reference.users.whereField(FireBase.Person.threads, arrayContains: thread.node)
            .addSnapshotListener { (snapshot, error) in
                guard let data = snapshot?.documents else { return }
//                let members = data.map { User( $0.data() ) }
//                completion((members.filter { $0 != User.current }).compactMap { $0.firebaseToken })
        }
    }
}
