//
//  Examples.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public var exampleChallenges: [Challenge] = [
    Challenge(id: 1, title: "Mobile app to help geo-tag graffiti", desc: "People can drop pins on a map to help remove grafitti. The mayor  is currently trying to help map where grafitti is to..."),
    Challenge(id: 2, title: "App to track reading over the summer", desc: "Help parents and library keep track of summer reading.  We are looking for a team to help design an app to bring..."),
    Challenge(id: 3, title: "Walk back from night parties together", desc: "An application for people to find others going back together at night from parties. Several people have reported being...")
]

public let exampleProgressPosts: [ProgressPost] = [
    ProgressPost(date: Date.init(timeIntervalSinceNow: 0), text: "We did a thing!", image: nil)
]

public var exampleTeams: [Team] = [
    Team(id: 1, name: "Frog and Code", challenge: nil, users: nil, progressPosts: exampleProgressPosts)
]

public var exampleUsers: [User] = [
    User(id: 1, username: "Jaoquin Pheonix", profileImage: #imageLiteral(resourceName: "myPicture"), teams: nil, badges: ["Challenge Guru", "Problem-Solver", "Teammate"]),
    User(id: 2, username: "Al Yuen", profileImage: #imageLiteral(resourceName: "some_douchey_guy"), teams: nil, badges: ["Problem-Solver"]),
    User(id: 3, username: "David Xue", profileImage: #imageLiteral(resourceName: "boy"), teams: nil, badges: ["Teammate"]),
    User(id: 4, username: "Anu Rajan", profileImage: #imageLiteral(resourceName: "girls"), teams: nil, badges: ["Challenge Guru"])
]
