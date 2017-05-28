//
//  Challenge.swift
//  Konstruu
//
//  Created by Al Yuen on 4/11/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Challenge: CustomStringConvertible {
    
    var reference: FIRDatabaseReference!
    var key: String!
    var title: String!
    var desc: String!
    var categories: [String] = []
    var likesUserKeys: [String] = []
    var teamKeys: [String] = []
    var searchText: String?
    
    var numberOfLikes: Int {
        return likesUserKeys.count
    }
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        
        if let desc = dictionary["desc"] as? String {
            self.desc = desc
        }
        
        if let categoriesDictionary = dictionary["categories"] as? Dictionary<String, AnyObject> {
            self.categories = self.categories + Array(categoriesDictionary.keys)
        }
        
        if let likesUserKeysDictionary = dictionary["likesUserKeys"] as? Dictionary<String, AnyObject> {
            self.likesUserKeys = self.likesUserKeys + Array(likesUserKeysDictionary.keys)
        }
        
        if let teamKeysDictionary = dictionary["teamKeys"] as? Dictionary<String, AnyObject> {
            self.teamKeys = self.teamKeys + Array(teamKeysDictionary.keys)
        }
        
        if let searchText = dictionary["searchText"] as? String {
            self.searchText = searchText
        }
        
        self.reference = API.challengesReference.child(self.key)
    }
    
    func getTeams(completed: (([Team]) -> Void)?) {
        API.getTeamsInList(teamKeys: teamKeys, index: 0, teams: [], completed: completed)
    }
    
    func updateDescription(to desc: String) {
        self.desc = desc
        reference.child("desc").setValue(desc)
        
        setSearchText()
    }
    
    func addTeam(_ team: Team) {
        teamKeys.append(team.key)
        reference.child("teamKeys").child(team.key).setValue(true)
        
        team.challengeKey = key
        team.reference.child("challengeKey").setValue(key)
    }
    
    func addToCategory(_ category: String) {
        categories.append(category)
        reference.child("categories").child(category).setValue(true)
        
        API.categoriesReference.child(category).child(key).setValue(true)
        
        setSearchText()
    }
    
    func removeFromCategory(_ category: String) {
        if let index = categories.index(of: category) {
            categories.remove(at: index)
        }
        reference.child("categories").child(category).removeValue()
        
        API.categoriesReference.child(category).child(key).removeValue()
        
        setSearchText()
    }
    
    func setSearchText() {
        var searchText = ""
        if let title = title {
            searchText += "\(title) "
        }
        if let desc = desc {
            searchText += "\(desc) "
        }
        for category in categories {
            searchText += "\(category) "
        }
        searchText = searchText.lowercased()
        
        self.searchText = searchText
        reference.child("searchText").setValue(searchText)
    }
    
    var description: String {
        let data: Dictionary<String, AnyObject> = [
            "key": key as AnyObject,
            "title": title as AnyObject,
            "desc": desc as AnyObject,
            "categories": categories as AnyObject,
            "likesUserKeys": likesUserKeys as AnyObject,
            "teamKeys": teamKeys as AnyObject,
            "searchText": searchText as AnyObject
        ]
        return String(describing: data)
    }
}
