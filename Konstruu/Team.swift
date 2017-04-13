//
//  Team.swift
//  Konstruu
//
//  Created by Al Yuen on 4/11/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Team: CustomStringConvertible {
    
    var reference: FIRDatabaseReference!
    var key: String!
    var name: String!
    var open: Bool = true
    var challengeKey: String!
    var userKeys: [String] = []
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let open = dictionary["open"] as? Bool {
            self.open = open
        }
        
        if let challengeKey = dictionary["challengeKey"] as? String {
            self.challengeKey = challengeKey
        }
        
        if let userKeysDictionary = dictionary["userKeys"] as? Dictionary<String, AnyObject> {
            self.userKeys = Array(userKeysDictionary.keys)
        }
        
        self.reference = API.teamsReference.child(self.key)
    }
    
    func addUser(_ user: User) {
        userKeys.append(user.key)
        reference.child("userKeys").child(user.key).setValue(true)
        
        user.teamKeys.append(key)
        user.reference.child("teamKeys").child(key).setValue(true)
    }
    
    func markAsOpen() {
        open = true
        reference.child("open").setValue(true)
    }
    
    func markAsClosed() {
        open = false
        reference.child("open").setValue(false)
    }
    
    var description: String {
        let data = [
            "key": key,
            "name": name,
            "open": String(describing: open),
            "challengeKey": challengeKey,
            "userKeys": String(describing: userKeys)
        ]
        return String(describing: data)
    }
}
