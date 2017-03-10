//
//  Examples.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public var exampleChallenges: [Challenge] = [
    Challenge(id: 1, title: "Geotagging graffiti", desc: "Make an app to geotag graffiti")
]

public let exampleProgressPosts: [ProgressPost] = [
    ProgressPost(date: NSDate.init(timeIntervalSinceNow: 0), text: "We did a thing!", image: nil)
]

public var exampleTeams: [Team] = [
    Team(id: 1, name: "Frog and Code", challenge: nil, users: nil, progressPosts: exampleProgressPosts)
]

public var exampleUsers: [User] = [
    User(id: 1, username: "morhm", profileImage: #imageLiteral(resourceName: "myPicture"), teams: nil, badges: ["Challenge Guru"]),
    User(id: 2, username: "al", profileImage: #imageLiteral(resourceName: "slackIcon"), teams: nil, badges: ["Problem-Solver"]),
    User(id: 3, username: "david", profileImage: #imageLiteral(resourceName: "slackIcon"), teams: nil, badges: ["Teammate"]),
    User(id: 4, username: "anu", profileImage: #imageLiteral(resourceName: "slackIcon"), teams: nil, badges: ["Challenge Guru"])
]
