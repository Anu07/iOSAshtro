//
//  ChatThread.swift
//  Astroshub
//
//  Created by PAWAN KUMAR on 06/06/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//


protocol ChatThreadDelegate: class {
    func membersUpdated(of thread: ChatThread)
}

final class ChatThread: Equatable, Comparable {
    static func < (lhs: ChatThread, rhs: ChatThread) -> Bool {
        return lhs.time < rhs.time
    }
    
    static func == (lhs: ChatThread, rhs: ChatThread) -> Bool {
        return lhs.node == rhs.node
    }
    
    var owned: Bool {
        get {
            return String(ownerId) == User.current.userId
        }
    }
    
    var node = String()
    var time = Double()
    var senderId = Int()
    var name: String?
    var image: String?
    var lastMessage = String()
    var memberIds = [String]()
    var style = FireBase.Style.single
    var readStatus = NSMutableDictionary()
    var members = [User]()
    var ownerId = Int()
    var justCreated = Bool()
    var threadLastSeen = [String: Int]()
    var type = String()
    
    weak var delegate: ChatThreadDelegate?
    
    init(_ data: [String: Any], node: String? = nil) {
        self.node = data[FireBase.Thread.node] as? String ?? node ?? ""
        lastMessage = data[FireBase.Thread.lastMessage] as? String ?? ""
        time = data[FireBase.Thread.time] as? Double ?? 0
        senderId = data[FireBase.Thread.senderId] as? Int ?? 0
        name = data[FireBase.Thread.name] as? String
        image = data[FireBase.Thread.image] as? String
        memberIds = data[FireBase.Thread.members] as? [String] ?? []
        threadLastSeen = data[FireBase.Thread.threadLastSeen] as? [String: Int] ?? [:]
        if let readDic = data[FireBase.Thread.readStatus] as? NSDictionary,
            let mutableDic = readDic.mutableCopy() as? NSMutableDictionary {
            readStatus = mutableDic
        }
        ownerId = data[FireBase.Thread.ownerId] as? Int ?? 0
        if let styleValue = data[FireBase.Thread.style] as? Int,
            let styleObj = FireBase.Style(rawValue: styleValue) {
            style = styleObj
        }
        type = data[FireBase.Thread.type] as? String ?? ""
        fetchMembers()
    }
    
    private func fetchMembers() {
        guard memberIds.count > 0 else { return }
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0) { FireBase.Reference.users.whereField(FireBase.Person.threads, arrayContains: self.node)
            .addSnapshotListener { (snapshot, error) in
                guard let data = snapshot?.documents else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) { self.adjust(users: data.map { User($0.data()) }) }
        } }
            
    }
    
    private func adjust(users: [User]) {
        users.forEach {
            if let index = members.firstIndex(of: $0) {
                members[index].reassign(from: $0)
            } else {
                members.append($0)
            }
        }
        delegate?.membersUpdated(of: self)
    }
    
    func reassign(from newThread: ChatThread) {
        name = newThread.name
        lastMessage = newThread.lastMessage
        time = newThread.time
        senderId = newThread.senderId
        readStatus = newThread.readStatus
        threadLastSeen = newThread.threadLastSeen
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SingleThreadUpdation"), object: nil, userInfo: ["id": newThread.node])
    }
}



