//
//  API.swift
//  Konstruu
//
//  Created by Al Yuen on 4/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation
import DataStructures
import FirebaseDatabase

class API {
    
    static let databaseReference: FIRDatabaseReference = FIRDatabase.database().reference()
    
    // MARK: User
    
    // reference: https://firebase.google.com/docs/database/ios/read-and-write
    class func getUserWithId(_ id: String, completed: ((DataStructures.User?) -> Void)?) {
        databaseReference.child("users").child(id).observeSingleEvent(of: .value, with: { snapshot in
            let userInfo = snapshot.value as? NSDictionary
            if let name = userInfo?["name"] as? String {
//                let teamIds = userInfo?["teams"]
//                let badges = userInfo?["badges"]
                // TODO: figure out how to turn teamIds and badges into arrays
                completed?(DataStructures.User(id: id, name: name, profileImage: nil, teamIds: nil, badges: nil))
            } else {
                completed?(nil)
            }
        })
    }
    
    class func getTeamsForUser(_ user: DataStructures.User, completed: (([DataStructures.Team?]?) -> Void)?) {
        // TODO
    }
    
    class func getSkillsForUser(_ user: DataStructures.User, completed: (([String]?) -> Void)?) {
        // TODO
    }
    
    class func getBadgesForUser(_ user: DataStructures.User, completed: (([String]?) -> Void)?) {
        // TODO
    }
    
    // reference: https://stackoverflow.com/questions/39691818/firebase-swift-how-to-create-a-child-and-add-its-id-to-another-ref-property
    class func createUser(name: String) -> DataStructures.User {
        print("createUser")
        let newUserReference = databaseReference.child("users").childByAutoId()
        let id = newUserReference.key
        newUserReference.setValue([
            "id": id,
            "name": name
        ])
        return DataStructures.User(id: id, name: name)
    }
    
    class func updateUserDescription(description: String, userID: String) {
        // TODO
    }
    
    class func addSkillToUser(skill: String, user: DataStructures.User) {
        // TODO
    }
    
    class func addBadgeToUser(badgeName: String, user: DataStructures.User) {
        // TODO
    }
    
    // MARK: Team
    
    class func getTeamWithId(_ id: String, completed: ((DataStructures.Team?) -> Void)?) {
        databaseReference.child("teams").child(id).observeSingleEvent(of: .value, with: { snapshot in
            let teamInfo = snapshot.value as? NSDictionary
            if let name = teamInfo?["name"] as? String {
                completed?(DataStructures.Team(id: id, name: name))
            } else {
                completed?(nil)
            }
        })
    }
    
    class func getUsersForTeam(_ team: DataStructures.Team, completed: (([DataStructures.User?]?) -> Void)?) {
        // TODO
    }
    
    class func getChallengeForTeam(_ team: DataStructures.Team, completed: ((DataStructures.Team?) -> Void)?) {
        // TODO
    }
    
    class func createTeam(name: String, challengeID: String) -> DataStructures.Team {
        let newTeamReference = databaseReference.child("teams").childByAutoId()
        let id = newTeamReference.key
        newTeamReference.setValue([
            "id": id,
            "name": name,
            "challenge": challengeID,
            "open": true
        ])
        return DataStructures.Team(id: id, name: name)
    }
    
    class func updateStatusForTeam(status open: Bool, team: DataStructures.Team) {
        // TODO
    }
    
    class func addUserToTeam(user: DataStructures.User, team: DataStructures.Team) {
        // TODO
    }
    
    // MARK: Challenge
    
    class func getChallengeWithId(_ id: String, completed: ((DataStructures.Challenge?) -> Void)?) {
        databaseReference.child("challenges").child(id).observeSingleEvent(of: .value, with: { snapshot in
            let challengeInfo = snapshot.value as? NSDictionary
            if let title = challengeInfo?["title"] as? String,
                let desc = challengeInfo?["description"] as? String {
                completed?(DataStructures.Challenge(id: id, title: title, desc: desc))
            } else {
                completed?(nil)
            }
        })
    }
    
    class func getTeamsForChallenge(_ challenge: DataStructures.Challenge, completed: (([DataStructures.Team?]?) -> Void)?) {
        // TODO
    }
    
    class func createChallenge(title: String, desc: String) -> DataStructures.Challenge {
        let newChallengeReference = databaseReference.child("challenges").childByAutoId()
        let id = newChallengeReference.key
        newChallengeReference.setValue([
            "id": id,
            "title": title,
            "description": desc
        ])
        return DataStructures.Challenge(id: id, title: title, desc: desc)
    }
    
    class func addTeamToChallenge(team: DataStructures.Team, challenge: DataStructures.Challenge) {
        // TODO
    }
}
