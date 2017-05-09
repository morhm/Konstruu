//
//  Team.swift
//  Konstruu
//
//  Created by Al Yuen on 4/11/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import Applozic

class Team: CustomStringConvertible {
    
    var reference: FIRDatabaseReference!
    var profileImageReference: FIRStorageReference!
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
        self.profileImageReference = API.teamImagesReference.child(self.key)
    }
    
    func getProfileImage(completed: ((UIImage?) -> Void)?) {
        profileImageReference.data(withMaxSize: 1 * 1024 * 1024, completion: { data, error in
            if error != nil || data == nil {
                print("error in downloading team profile image:\n\(String(describing:error))")
                completed?(#imageLiteral(resourceName: "groupIcon"))
            } else {
                completed?(UIImage(data: data!))
            }
        })
    }
    
    func updateProfileImage(to imageData: Data, completed: ((FIRStorageMetadata?, Error?) -> Void)?) {
        profileImageReference.put(imageData, metadata: nil, completion: completed)
    }
    
    func addUser(_ user: User) {
        userKeys.append(user.key)
        reference.child("userKeys").child(user.key).setValue(true)
        
        user.teamKeys.append(key)
        user.reference.child("teamKeys").child(key).setValue(true)
    }
    
    func removeUser(_ user: User) {
        if let index = userKeys.index(of: user.key) {
            userKeys.remove(at: index)
        }
        reference.child("userKeys").child(user.key).removeValue()
        
        if let index = user.teamKeys.index(of: key) {
            user.teamKeys.remove(at: index)
        }
        user.reference.child("teamKeys").child(key).removeValue()
    }
    
    func markAsOpen() {
        open = true
        reference.child("open").setValue(true)
    }
    
    func markAsClosed() {
        open = false
        reference.child("open").setValue(false)
    }
    
    func registerForChat() {
        let channelService = ALChannelService()
        channelService.createChannel(name, orClientChannelKey: key, andMembersList: userKeys as? NSMutableArray, andImageLink: nil, withCompletion: nil)
    }
    
    func startChatWithUser(_ user: User, from controller: UIViewController) {
        var membersList = userKeys
        membersList.append(user.key)
        
        let channelService = ALChannelService()
        channelService.createChannel("\(user.name) with \(self.name)", orClientChannelKey: "\(user.key)\(self.key)", andMembersList: membersList as? NSMutableArray, andImageLink: nil, withCompletion: { alChannel, error in
            if error != nil || alChannel == nil {
                print(error.debugDescription)
            } else {
                let chatManager = ALChatManager(applicationKey: ALChatManager.applicationId as NSString)
                chatManager.launchChatForGroup(alChannel!.key, fromController: controller)
            }
        })
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
