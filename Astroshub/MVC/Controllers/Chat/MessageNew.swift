//
//  MessageNew.swift
//  Astroshub
//
//  Created by Kriscent on 19/02/20.
//  Copyright © 2020 Bhunesh Kahar. All rights reserved.
//

import UIKit
import Firebase
class MessageNew: NSObject {
    
    var fromId: String!
    var text: String!
    var seen: String!
   // var toID: String!
    var timestamp:Float?
    var type: String!
    init(fromDictionary dictionary: [String:Any]){
        
        fromId = dictionary["from"] as? String
        text = dictionary["message"] as? String
        seen = dictionary["seen"] as? String
        timestamp = Float(truncating: (dictionary["time"] as? NSNumber)!)
        type = dictionary["type"] as? String
       // toID = dictionary["toId"] as? String
        
        
        
    }
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if fromId != nil{
            dictionary["from"] = fromId
        }
        if text != nil{
            dictionary["message"] = text
        }
        if seen != nil{
            dictionary["seen"] = seen
        }
        if timestamp != nil{
            dictionary["time"] = timestamp
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }
    @objc required init(coder aDecoder: NSCoder)
    {
        fromId = aDecoder.decodeObject(forKey: "from") as? String
        text = aDecoder.decodeObject(forKey: "message") as? String
        seen = aDecoder.decodeObject(forKey: "seen") as? String
        timestamp = aDecoder.decodeObject(forKey: "time") as? Float
        type = aDecoder.decodeObject(forKey: "type") as? String
    }
    @objc func encode(with aCoder: NSCoder)
    {
        if fromId != nil{
            aCoder.encode(fromId, forKey: "from")
        }
        if text != nil{
            aCoder.encode(text, forKey: "message")
        }
        if seen != nil{
            aCoder.encode(seen, forKey: "seen")
        }
        if timestamp != nil{
            aCoder.encode(timestamp, forKey: "time")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
    }
    
    //    init(seen: String, fromId: String, toID: String, text: String, timestamp: Int) {
    //      self.seen = seen
    //      self.fromId = fromId
    //      self.toID = toID
    //      self.text = text
    //      self.timestamp = timestamp
    //    }
//    func chatPartnerId() -> String?
//    {
//        return fromId == Auth.auth().currentUser?.uid ? toID : fromId
//
//    }
    
}
