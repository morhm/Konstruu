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
                 "location": "Hell, MI",
                 "school": "Wissahickon High School",
                 "skills": {
                     "0": "iOS Development",
                     "1": "git",
                     "2": "Javascript"
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
                 "searchText": "Mark Orozco blah@blah.com Hell, MI Wissahickon High School iOS Development git Javascript"
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
                 "searchText": "Mobile app to help geo-tag graffiti People can drop pins on a map to help remove grafitti. sponsored mobile"
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
        
    // MARK: User
    
    class func searchUsers(keyword: String, completed: ((([User]) -> Void)?)) {
        usersReference.observeSingleEvent(of: .value, with: { snapshot in
            var matches: [User] = []
            
            // get all the users
            for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                
                // get the searchText for this user
                if let dictionary = childSnapshot.value as? Dictionary<String, AnyObject> {
                    if let searchText = dictionary["searchText"] as? String {
                        
                        // check for the keyword in the searchText
                        if searchText.range(of: keyword) != nil {
                            let match = User(key: childSnapshot.key, dictionary: dictionary)
                            matches.append(match)
                        }
                    }
                }
            }
            
            completed?(matches)
        })
    }
    
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
         "location": "",
         "school": "",
         "skills": ["skill name", "skill name"],
         "likedChallengeKeys": ["challenge key": true, "challenge key": true],
         "badges": ["badge name": true, "badge name": true],
         "teamKeys": ["team key": true, "team key": true]
     ]
     */
    class func createUser(userInfo: Dictionary<String, AnyObject>) -> User {
        let userReference = usersReference.childByAutoId()
        let key = userReference.key
        userReference.setValue(userInfo)
        let user = User(key: key, dictionary: userInfo)
        user.setSearchText()
        return user
    }
    
    /* Dictionary Format:
     [
         "name": "",                                                REQUIRED
         "desc": "",
         "photoURL": "",
         "email": "",
         "location": "",
         "school": "",
         "skills": ["skill name", "skill name"],
         "likedChallengeKeys": ["challenge key": true, "challenge key": true],
         "badges": ["badge name": true, "badge name": true],
         "teamKeys": ["team key": true, "team key": true]
     ]
     */
    class func createUserWithKey(_ key: String, userInfo: Dictionary<String, AnyObject>) -> User {
        let userReference = usersReference.child(key)
        userReference.setValue(userInfo)
        let user = User(key: key, dictionary: userInfo)
        user.setSearchText()
        return user
    }
    
    // model use only
    class func getUsersInList(userKeys: [String], index: Int, users: [User], completed: (([User]) -> Void)?) {
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
    // model use only
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
         "userKeys": ["user key": true, "user key": true]
     ]
     */
    
    
    class func createTeam(teamInfo: Dictionary<String, AnyObject>) -> Team {
        let teamReference = teamsReference.childByAutoId()
        let key = teamReference.key
        teamReference.setValue(teamInfo)
        return Team(key: key, dictionary: teamInfo)
    }
    
    
    
    // MARK: Challenge
    
    class func searchChallenges(keyword: String, completed: ((([Challenge]) -> Void)?)) {
        challengesReference.observeSingleEvent(of: .value, with: { snapshot in
            var matches: [Challenge] = []
            
            // get all the users
            for childSnapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                
                // get the searchText for this user
                if let dictionary = childSnapshot.value as? Dictionary<String, AnyObject> {
                    
                    if let searchText = dictionary["searchText"] as? String {
                        // check for the keyword in the searchText
                        if searchText.range(of: keyword) != nil {
                            let match = Challenge(key: childSnapshot.key, dictionary: dictionary)
                            matches.append(match)
                        }
                    }
                    
                }
            }
            
            completed?(matches)
        })
    }
    
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
         "cateogires": ["category name": true, "category name": true],
         "likesUserKeys": ["user key": true, "user key": true],
         "teamKeys": ["team key": true, "team key": true]
     ]
     */
    class func createChallenge(challengeInfo: Dictionary<String, AnyObject>) -> Challenge {
        let challengeReference = challengesReference.childByAutoId()
        let key = challengeReference.key
        challengeReference.setValue(challengeInfo)
        let challenge = Challenge(key: key, dictionary: challengeInfo)
        challenge.setSearchText()
        return challenge
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
