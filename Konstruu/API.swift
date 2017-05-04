//
//  API.swift
//  Konstruu
//
//  Created by Al Yuen on 4/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class API {
    
    /* Database Structure:
     {
         "users": {
             "1": {
                 "name": "Mark Orozco",
                 "desc": "Hi everyone!",
                 "photoURL": "blah.com",
                 "email": "blah@blah.com",
                 "skills": {
                     "iOS Development": true,
                     "git": true,
                 },
                 "likedChallengeKeys": {
                     "3": true
                 }
                 "teamKeys": {
                     "2": true
                 },
                 "badges": {
                     "Challenge Guru": true
                 }
             }
         },
         "teams": {
             "2": {
                 "name": "Frog and Code",
                 "open": true, // looking for teammates
                 "challengeKey": "3",
                 "userKeys": {
                     "1": true,
                 }
             }
         },
         "challenges": {
             "3": {
                 "title": "Mobile app to help geo-tag graffiti",
                 "desc": "People can drop pins on a map to help remove grafitti.",
                 "categories": {
                     "sponsored": true,
                     "mobile": true
                 },
                 "likesUserKeys": {
                     "1": true
                 },
                 "teamKeys": {
                     "Frog and Code": true
                 }
             }
         },
         "skills": {
             "iOS Development": {
                 "1": true
             },
             "git": {
                 "1": true
             }
         },
         "categories": {
             "sponsored": {
                 "3": true
             },
             "mobile": {
                 "3": true
             },
         }
     }
    */
    
    /* Cloud Storage Structure:
     {
        "userImages": {
            "user key": file
        },
        "teamImages": {
            "team key": file
        }
     }
    */
    
    static let databaseReference: FIRDatabaseReference = FIRDatabase.database().reference()
    static let usersReference = databaseReference.child("users")
    static let teamsReference = databaseReference.child("teams")
    static let challengesReference = databaseReference.child("challenges")
    static let skillsReference = databaseReference.child("skills")
    static let categoriesReference = databaseReference.child("categories")
    
    static let storage = FIRStorage.storage()
    static let storageReference = storage.reference()
    static let userImagesReference = storageReference.child("userImages")
    static let teamImagesReference = storageReference.child("teamImages")
    
    static let alApplicationId = "stanford2fb38fdcc41b82a674ad291ab8410ea70"
    
    // MARK: User
    
    // reference: https://firebase.google.com/docs/database/ios/read-and-write
    class func getUserWithKey(_ key: String, completed: ((User?) -> Void)?) {
        usersReference.child(key).observeSingleEvent(of: .value, with: { snapshot in
            var user: User?
            
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                user = User(key: key, dictionary: dictionary)
            }
            
            completed?(user)
        })
    }
    
    class func getCurrentUser(completed: ((User?) -> Void)?) {
        if let key = FIRAuth.auth()?.currentUser?.uid {
            getUserWithKey(key, completed: completed)
        } else {
            completed?(nil)
        }
    }
    
    // reference: https://stackoverflow.com/questions/39691818/firebase-swift-how-to-create-a-child-and-add-its-id-to-another-ref-property
    /* Dictionary Format:
     [
         "name": "",                                                REQUIRED
         "desc": "",
         "photoURL": "",
         "email": "",
         "skills": ["skill name", "skill name"],
         "likedChallengeKeys": ["challenge key", "challenge key"],
         "badges": ["badge name", "badge name"],
         "teamKeys": ["team key", "team key"]
     ]
     */
    class func createUser(userInfo: Dictionary<String, AnyObject>) -> User {
        let userReference = usersReference.childByAutoId()
        let key = userReference.key
        userReference.setValue(userInfo)
        return User(key: key, dictionary: userInfo)
    }
    
    /* Dictionary Format:
     [
         "name": "",                                REQUIRED
         "desc": "",
         "photoURL": "",
         "email": "",
         "skills": ["skill name", "skill name"],
         "badges": ["badge name", "badge name"],
         "teamKeys": ["team key", "team key"]
         ]
     */
    class func createUserWithKey(_ key: String, userInfo: Dictionary<String, AnyObject>) -> User {
        let userReference = usersReference.child(key)
        userReference.setValue(userInfo)
        return User(key: key, dictionary: userInfo)
    }
    
    // MARK: Team
    
    class func getTeamWithKey(_ key: String, completed: ((Team?) -> Void)?) {
        teamsReference.child(key).observeSingleEvent(of: .value, with: { snapshot in
            var team: Team?
            
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                team = Team(key: key, dictionary: dictionary)
            }
            
            completed?(team)
        })
    }
    
    // reference: http://www.appcoda.com/firebase/
    class func getTeamsInList(teamKeys: [String], index: Int, teams: [Team], completed: (([Team]) -> Void)?) {
        var currentTeams = teams
        if index >= teamKeys.count {
            completed?(teams)
        } else {
            let key = teamKeys[index]
            teamsReference.child(key).observeSingleEvent(of: .value, with: { snapshot in
                if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                    let team = Team(key: key, dictionary: dictionary)
                    currentTeams.append(team)
                }
                getTeamsInList(teamKeys: teamKeys, index: index + 1, teams: currentTeams, completed: completed)
            })
        }
    }
    
    /* Dictionary Format:
     [
         "name": "",                            REQUIRED
         "open": true,
         "challengeKey": "challenge key",       REQUIRED
         "userKeys": ["user key", "user key"]
     ]
     */
    class func createTeam(teamInfo: Dictionary<String, AnyObject>) -> Team {
        let teamReference = teamsReference.childByAutoId()
        let key = teamReference.key
        teamReference.setValue(teamInfo)
        return Team(key: key, dictionary: teamInfo)
    }
    
    // MARK: Challenge
    
    class func getChallengeWithKey(_ key: String, completed: ((Challenge?) -> Void)?) {
        challengesReference.child(key).observeSingleEvent(of: .value, with: { snapshot in
            var challenge: Challenge?
            
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                challenge = Challenge(key: key, dictionary: dictionary)
            }
            
            completed?(challenge)
        })
    }
    
    class func getAllChallenges(completed: (([Challenge]) -> Void)?) {
        challengesReference.observeSingleEvent(of: .value, with: { snapshot in
            var challenges: [Challenge] = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let dictionary = snap.value as? Dictionary<String, AnyObject> {
                        let challenge = Challenge(key: snap.key, dictionary: dictionary)
                        challenges.append(challenge)
                    }
                }
            }
            completed?(challenges)
        })
    }
    
    class func getChallengesInList(challengeKeys: [String] , index: Int, challenges: [Challenge], completed: (([Challenge]) -> Void)?) {
        var currentChallenges = challenges
        if index >= challengeKeys.count {
            completed?(challenges)
        } else {
            let key = challengeKeys[index]
            teamsReference.child(key).observeSingleEvent(of: .value, with: { snapshot in
                if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                    let challenge = Challenge(key: key, dictionary: dictionary)
                    currentChallenges.append(challenge)
                }
                getChallengesInList(challengeKeys: challengeKeys, index: index + 1, challenges: currentChallenges, completed: completed)
            })
        }
    }
    
    /* Dictionary Format:
     [
         "title": "",                                       REQUIRED
         "desc": "",                                        REQUIRED
         "cateogires": ["category name", "category name"],
         "likesUserKeys": ["user key", "user key"],
         "teamKeys": ["team key", "team key"]
     ]
     */
    class func createChallenge(challengeInfo: Dictionary<String, AnyObject>) -> Challenge {
        let challengeReference = challengesReference.childByAutoId()
        let key = challengeReference.key
        challengeReference.setValue(challengeInfo)
        return Challenge(key: key, dictionary: challengeInfo)
    }
    
    // MARK: Skills
    
    class func getUsersWithSkill(_ skill: String, completed: (([User]) -> Void)?) {
        skillsReference.child(skill).observeSingleEvent(of: .value, with: { snapshot in
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                let userKeys = Array(dictionary.keys)
                getUsersInList(userKeys: userKeys, index: 0, users: [], completed: completed)
            }
        })
    }
    
    private class func getUsersInList(userKeys: [String], index: Int, users: [User], completed: (([User]) -> Void)?) {
        var currentUsers = users
        if index >= userKeys.count {
            completed?(users)
        } else {
            let key = userKeys[index]
            usersReference.child(key).observeSingleEvent(of: .value, with: { snapshot in
                if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                    let user = User(key: key, dictionary: dictionary)
                    currentUsers.append(user)
                }
                getUsersInList(userKeys: userKeys, index: index + 1, users: currentUsers, completed: completed)
            })
        }
    }
    
    // MARK: Categories
    
    class func getChallengesInCategory(_ category: String, completed: (([Challenge]) -> Void)?) {
        categoriesReference.child(category).observeSingleEvent(of: .value, with: { snapshot in
            if let dictionary = snapshot.value as? Dictionary<String, AnyObject> {
                let challengeKeys = Array(dictionary.keys)
                getChallengesInList(challengeKeys: challengeKeys, index: 0, challenges: [], completed: completed)
            }
        })
    }
}
