//
//  User.swift
//  Konstruu
//
//  Created by Al Yuen on 4/11/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import Applozic

class User: CustomStringConvertible {
    
    var reference: FIRDatabaseReference!
    var profileImageReference: FIRStorageReference!
    var key: String!
    var name: String!
    var desc: String?
    var photoURL: URL?
    var email: String?
    var location: String?
    var school: String?
    var skills: [String] = []
    var likedChallengeKeys: [String] = []
    var badges: [String] = []
    var teamKeys: [String] = []
    var searchText: String?
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let desc = dictionary["desc"] as? String {
            self.desc = desc
        }
        
        if let photoURL = dictionary["photoURL"] as? String {
            self.photoURL = URL(string: photoURL)
        }
        
        if let email = dictionary["email"] as? String {
            self.email = email
        }
        
        if let location = dictionary["location"] as? String {
            self.location = location
        }
        
        if let school = dictionary["school"] as? String {
            self.school = school
        }
        
        if let skills = dictionary["skills"] as? Array<String> {
            self.skills = self.skills + skills
        }
        
        if let likedChallengeKeysDictionary = dictionary["likedChallengeKeys"] as? Dictionary<String, AnyObject> {
            self.likedChallengeKeys = self.likedChallengeKeys + Array(likedChallengeKeysDictionary.keys)
        }
        
        if let badgesDictionary = dictionary["badges"] as? Dictionary<String, AnyObject> {
            self.badges = self.badges + Array(badgesDictionary.keys)
        }
        
        if let teamKeysDictionary = dictionary["teamKeys"] as? Dictionary<String, AnyObject> {
            self.teamKeys = self.teamKeys + Array(teamKeysDictionary.keys)
        }
        
        if let searchText = dictionary["searchText"] as? String {
            self.searchText = searchText
        }
        
        self.reference = API.usersReference.child(self.key)
        self.profileImageReference = API.userImagesReference.child(self.key)
    }
    
    func isCurrentUser() -> Bool {
        if FIRAuth.auth()?.currentUser != nil {
            let currentUserKey = FIRAuth.auth()!.currentUser!.uid
            return currentUserKey == key
        } else {
            return false
        }
    }
    
    // reference: https://firebase.google.com/docs/storage/ios/download-files
    func getProfileImage(completed: ((UIImage?) -> Void)?) {
        profileImageReference.data(withMaxSize: 1 * 1024 * 1024, completion: { data, error in
            if error != nil || data == nil {
                print("error in downloading user profile image:\n\(String(describing:error))")
                completed?(#imageLiteral(resourceName: "Happy_Face"))
            } else {
                completed?(UIImage(data: data!))
            }
        })
    }
    
    func getTeams(completed: (([Team]) -> Void)?) {
        API.getTeamsInList(teamKeys: teamKeys, index: 0, teams: [], completed: completed)
    }
    
    func getLikedChallenges(completed: (([Challenge]) -> Void)?) {
        API.getChallengesInList(challengeKeys: likedChallengeKeys, index: 0, challenges: [], completed: completed)
    }
  
    func updateName(to name: String) {
        self.name = name
        reference.child("name").setValue(name)
    }
  
    func updateDescription(to desc: String) {
        self.desc = desc
        reference.child("desc").setValue(desc)
        
        setSearchText()
    }
    
    func updateLocation(to location: String) {
        self.location = location
        reference.child("location").setValue(location)
        
        setSearchText()
    }
    
    func updateSchool(to school: String) {
        self.school = school
        reference.child("school").setValue(school)
        
        setSearchText()
    }
    
    // reference: https://firebase.google.com/docs/storage/ios/upload-files
    func updateProfileImage(to imageData: Data, completed: ((FIRStorageMetadata?, Error?) -> Void)?) -> FIRStorageUploadTask {
        let uploadTask = profileImageReference.put(imageData, metadata: nil, completion: completed)
        return uploadTask
    }
    
    func updateSkill(at index: Int, to skill: String) {
        if index >= 0, index < skills.count {
            skills[index] = skill
            reference.child("skills").setValue(skills)
        } else if index == skills.count {
            skills.append(skill)
            reference.child("skills").setValue(skills)
        }
    }
    
    func likeChallenge(_ challenge: Challenge) {
        self.likedChallengeKeys.append(challenge.key)
        reference.child("likedChallengeKeys").child(challenge.key).setValue(true)
        
        challenge.likesUserKeys.append(key)
        challenge.reference.child("likesUserKeys").child(key).setValue(true)
    }
    
    func unlikeChallenge(_ challenge: Challenge) {
        if let index = likedChallengeKeys.index(of: challenge.key) {
            likedChallengeKeys.remove(at: index)
        }
        reference.child("likedChallengeKeys").child(challenge.key).removeValue()
        
        if let index = challenge.likesUserKeys.index(of: key) {
            challenge.likesUserKeys.remove(at: index)
        }
        challenge.reference.child("likesUserKeys").child(key).removeValue()
    }
    
    func addBadge(_ badge: String) {
        self.badges.append(badge)
        reference.child("badges").child(badge).setValue(true)
    }
    
    func registerForChat() {
        let alUser = ALUser()
        alUser.applicationId = ALChatManager.applicationId
        alUser.userId = key
        alUser.email = email
        alUser.displayName = name
        
        let chatManager = ALChatManager(applicationKey: ALChatManager.applicationId as NSString)
        chatManager.registerUser(alUser)
        
        ALUserDefaultsHandler.setApplicationKey(ALChatManager.applicationId)
        ALUserDefaultsHandler.setUserId(key)
        ALUserDefaultsHandler.setEmailId(email)
        ALUserDefaultsHandler.setDisplayName(name)
    }
    
    func startChat(from controller: UIViewController) {
        let chatManager = ALChatManager(applicationKey: ALChatManager.applicationId as NSString)
        chatManager.launchChatForUser(key, fromViewController: controller)
    }
    
    func setSearchText() {
        var searchText = ""
        if let name = name {
            searchText += "\(name) "
        }
        if let email = email {
            searchText += "\(email) "
        }
        if let location = location {
            searchText += "\(location) "
        }
        if let school = school {
            searchText += "\(school) "
        }
        for skill in skills {
            searchText += "\(skill) "
        }
        searchText = searchText.lowercased()
        
        self.searchText = searchText
        reference.child("searchText").setValue(searchText)
    }
    
    var description: String { get {
        let data: Dictionary<String, AnyObject> = [
            "key": key as AnyObject,
            "name": name as AnyObject,
            "desc": desc as AnyObject,
            "photoURL": photoURL as AnyObject,
            "email": email as AnyObject,
            "location": location as AnyObject,
            "school": school as AnyObject,
            "skills": skills as AnyObject,
            "likedChallengeKeys": likedChallengeKeys as AnyObject,
            "badges": badges as AnyObject,
            "teamKeys": teamKeys as AnyObject,
            "searchText": searchText as AnyObject
        ]
        return String(describing: data)
    } }
}
