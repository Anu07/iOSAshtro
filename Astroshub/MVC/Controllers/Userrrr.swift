//
//  Userrrr.swift
//  Astroshub
//
//  Created by Kriscent on 12/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit

class Userrrr: NSObject {

    var Astro:String?
    var ID:String?
    var devicetoken:String?
    var email:String?
    var name:String?
    var image:String?
    var thumb_image:String?

}

import FirebaseFirestore

final class User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userId == rhs.userId
    }

    static var current = User()
    var userId = String()
    var userName = String()
    var name = String()
    var phone = String()
    var image = String()
    var email = String()
    var firebaseToken: String?
    var threadIds = Set<String>()
    var isSelected = Bool()
    var notificationrange = Int()
    var totalSecondsForCall = Int()
    

    private var listner: ListenerRegistration?

    private init() {}

    convenience init(_ data: [String: Any]) {
        self.init()

        userId = data[FireBase.Person.node] as? String ?? ""
        if let range = data["notification_range"] as? Int {
            notificationrange = range
        } else if let range = data["notification_range"] as? String {
            notificationrange = Int(range) ?? 0
        }
        userName = data[FireBase.Person.name] as? String ?? ""
        image = data[FireBase.Person.image] as? String ?? ""
        email = data[FireBase.Person.email] as? String ?? data["user_email"] as? String ?? ""
        name = (data[FireBase.Person.name] as? String ?? "").capitalized
        firebaseToken = data["user_ios_token"] as? String
        if let threads = data[FireBase.Person.threads] as? [String] {
            threadIds = Set(threads)
        }
    }
    
    convenience init(data2: [String:Any]) {
        self.init()

        userId = data2[FireBase.Person.node] as? String ?? ""
        if let range = data2["notification_range"] as? Int {
            notificationrange = range
        } else if let range = data2["notification_range"] as? String {
            notificationrange = Int(range) ?? 0
        }
        userName = data2["username"] as? String ?? ""
        phone = data2["phone"] as? String ?? ""
        image = data2["customer_image_url"] as? String ?? ""
        email = data2[FireBase.Person.email] as? String ?? data2["user_email"] as? String ?? ""
        name = (data2["customer_name"] as? String ?? "").capitalized
        firebaseToken = data2["user_ios_token"] as? String
        if let threads = data2[FireBase.Person.threads] as? [String] {
            threadIds = Set(threads)
        }
    }

    static func currentProfile(from data: [String: Any]) {
//        UserDefaultsManager.loginToken = data["token"] as? String
        //current = User(data)
        current = User(data2: data)
        current.updateToFirestore()
        current.listenUserThreads()
    }

    static func destroyUser() {
        current.listner?.remove()
        current.listner = nil
        current.removeFirebaseToken()
        current = User()
    }

    private func listenUserThreads() {
        func notifyThreadUpdation() {
//            NotificationCenter.default.post(name: .threadsUpdated, object: nil)
        }

        listner = FireBase.Reference.users.document("\(User.current.userId)")
            .addSnapshotListener { [weak self] (snapshot, error) in
                guard let threadsArray = snapshot?
                    .get(FireBase.Person.threads) as? [String] else {
                        self?.threadIds = []
                        notifyThreadUpdation()
                        return
                }
                self?.threadIds = Set(threadsArray)
                notifyThreadUpdation()
        }
    }

//    static func fetchCurrent(withHiddenIndicator indicator: Bool = true, completion: @escaping ()-> Void) {
//        UserEndpoints.details.request(withHiddenIndicator: indicator) { (data) in
//            print(data)
//            User.currentProfile(from: data as? [String: Any] ?? [:])
//            completion()
//        }
//    }

    func reassign(from newUser: User) {
        name = newUser.name
        image = newUser.image
        firebaseToken = newUser.firebaseToken
    }
}

extension User {
    /**
    Enum to specify the user's role
    */
    enum Role: String {
        case customer = "subscriber", business = "customer"
    }
    
    /**
     Enum to specify if user has verified it's account
     */
    enum VerificationStatus: Int {
        case pending, verified
    }
    
    /**
     Enum to specify if user has registered
     */
    enum RegisterStatus: Int {
        case notRegistered, registered
    }
    
    /**
     Enum to specify user's relation with current user
     */
    enum Relation: String {
        case own, new, friends, requested = "pending_request_out", recieved = "pending_request_in"
    }

    struct ConnectOption: Equatable {
        static func == (lhs: User.ConnectOption, rhs: User.ConnectOption) -> Bool {
            return lhs.type == rhs.type
        }
        
        var type = String()
        var id = String()
        
        init(_ data: [String: Any]) {
            type = data["type"] as? String ?? ""
            id = data["social_ID"] as? String ?? ""
        }
    }

    private var dictionary: [String: Any] {
        return [
            FireBase.Person.email: User.current.email,
            FireBase.Person.image: User.current.image,
            FireBase.Person.name: User.current.name,
            FireBase.Person.node: User.current.userId,
            FireBase.Person.token: User.current.firebaseToken ?? ""
        ]
    }
    
    /**
     Method to update the current user's details to Firestore.
     Call it only from current user.
     */
    func updateToFirestore() {
        FireBase.Reference.users.document("\(userId)").setData(dictionary, merge: true)
    }
    
    /**
     Method to remove firebase token from current user.
     Call it only from current user.
     */
    func removeFirebaseToken() {
        FireBase.Reference.users.document("\(userId)").setData([FireBase.Person.token: ""], merge: true)
    }
}

