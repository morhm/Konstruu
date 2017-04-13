//
//  User.swift
//  Konstruu
//
//  Created by Al Yuen on 4/11/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation
import FirebaseDatabase

class User: CustomStringConvertible {
    
    var reference: FIRDatabaseReference!
    var key: String!
    var name: String!
    var desc: String?
    var skills: [String] = []
    var badges: [String] = []
    var teamKeys: [String] = []
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let desc = dictionary["desc"] as? String {
            self.desc = desc
        }
        
        if let skillsDictionary = dictionary["skills"] as? Dictionary<String, AnyObject> {
            self.skills = self.skills + Array(skillsDictionary.keys)
        }
        
        if let badgesDictionary = dictionary["badges"] as? Dictionary<String, AnyObject> {
            self.badges = self.badges + Array(badgesDictionary.keys)
        }
        
        if let teamKeysDictionary = dictionary["teamKeys"] as? Dictionary<String, AnyObject> {
            self.teamKeys = self.teamKeys + Array(teamKeysDictionary.keys)
        }
        
        self.reference = API.usersReference.child(self.key)
    }
    
    func updateDescription(to desc: String) {
        self.desc = desc
        reference.child("desc").setValue(desc)
    }
    
    func addSkill(_ skill: String) {
        self.skills.append(skill)
        reference.child("skills").child(skill).setValue(true)
        API.skillsReference.child(skill).child(key).setValue(true)
    }
    
    func removeSkill(_ skill: String) {
        if let index = skills.index(of: skill) {
            skills.remove(at: index)
        }
        reference.child("skills").child(skill).removeValue()
        API.skillsReference.child(skill).child(key).removeValue()
    }
    
    func addBadge(_ badge: String) {
        self.badges.append(badge)
        reference.child("badges").child(badge).setValue(true)
    }
    
    var description: String { get {
        let data = [
            "key": key,
            "name": name,
            "desc": desc,
            "skills": String(describing: skills),
            "badges": String(describing: badges),
            "teamKeys": String(describing: teamKeys)
        ]
        return String(describing: data)
    } }
}
