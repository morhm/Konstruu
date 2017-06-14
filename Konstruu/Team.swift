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
    var desc: String?
    var open: Bool = true
    var challengeKey: String!
    var userKeys: [String] = []
    var requestUserKeys: [String] = []
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let desc = dictionary["desc"] as? String {
            self.desc = desc
        }
        
        if let open = dictionary["open"] as? Bool {
            self.open = open
        }
        
        if let challengeKey = dictionary["challengeKey"] as? String {
            self.challengeKey = challengeKey
        }
        
        if let userKeysDictionary = dictionary["userKeys"] as? Dictionary<String, AnyObject> {
            self.userKeys = self.userKeys + Array(userKeysDictionary.keys)
        }
        
        if let requestUserKeysDictionary = dictionary["requestUserKeys"] as? Dictionary<String, AnyObject> {
            self.requestUserKeys = self.requestUserKeys + Array(requestUserKeysDictionary.keys)
        }
        
        self.reference = API.teamsReference.child(self.key)
        self.profileImageReference = API.teamImagesReference.child(self.key)
    }
    
    func getProfileImage(completed: ((UIImage?) -> Void)?) {
        profileImageReference.data(withMaxSize: 100 * 1024 * 1024, completion: { data, error in
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
    
    func updateDescription(to desc: String) {
        self.desc = desc
        reference.child("desc").setValue(desc)
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
    
    func addRequest(from user: User) {
        requestUserKeys.append(user.key)
        reference.child("requestUserKeys").child(user.key).setValue(true)
    }
    
    // removes/denies a request (does not add the user to the team)
    func removeRequest(from user: User) {
        if let index = requestUserKeys.index(of: user.key) {
            requestUserKeys.remove(at: index)
        }
        reference.child("requestUserKeys").child(user.key).removeValue()
    }
    
    // removes the request and also adds the user to the team
    func acceptRequest(from user: User) {
        removeRequest(from: user)
        addUser(user)
    }
    
    // pseudonym for removeRequest
    func denyRequest(from user: User) {
        removeRequest(from: user)
    }
    
    func markAsOpen() {
        open = true
        reference.child("open").setValue(true)
    }
    
    func markAsClosed() {
        open = false
        reference.child("open").setValue(false)
    }
    
    func startChat(from controller: UIViewController) {
        if userKeys.count > 1 {
            let channelService = ALChannelService()
            let chatManager = ALChatManager(applicationKey: ALChatManager.applicationId as NSString)
            
            channelService.getChannelInformation(nil, orClientChannelKey: key, withCompletion: { [weak self] alChannel in
                if let alChannel = alChannel {
                    chatManager.launchChatForGroup(alChannel.key, fromController: controller)
                    
                } else if self != nil {
                    let membersList = self!.userKeys as NSArray
                    let mutableMembersList = membersList.mutableCopy() as? NSMutableArray
                    
                    channelService.createChannel(self!.name, orClientChannelKey: self!.key, andMembersList: mutableMembersList, andImageLink: nil, withCompletion: { newChannel, error in
                        if error != nil || newChannel == nil {
                            print(error.debugDescription)
                        } else {
                            chatManager.launchChatForGroup(newChannel!.key, fromController: controller)
                        }
                    })
                }
            })
        } else {
            print("group has only 1 user")
        }
    }
    
    func startChatWithUser(_ user: User, from controller: UIViewController) {
        var membersList = userKeys
        if membersList.index(of: user.key) == nil {
            membersList.append(user.key)
        }
        if membersList.count > 1 {
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
    }
    
    var description: String {
        let data: Dictionary<String, AnyObject> = [
            "key": key as AnyObject,
            "name": name as AnyObject,
            "desc": desc as AnyObject,
            "open": open as AnyObject,
            "challengeKey": challengeKey as AnyObject,
            "userKeys": userKeys as AnyObject,
            "requestUserKeys": requestUserKeys as AnyObject
        ]
        return String(describing: data)
    }
    
}
