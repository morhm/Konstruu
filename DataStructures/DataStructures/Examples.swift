//
//  Examples.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public var exampleChallenges: [Challenge] { get {
    challenge.teams = exampleTeams
    return [challenge]
} }

public let exampleProgressPosts: [ProgressPost] = [
    ProgressPost(date: NSDate.init(timeIntervalSinceNow: 0), text: "We did a thing!", image: nil)
]

public var exampleTeams: [Team] { get {
    team.challenge = challenge
    team.users = [user1, user2, user3, user4]
    return [team]
} }

public var exampleUsers: [User] { get {
    user1.teams = [team]
    user2.teams = [team]
    user3.teams = [team]
    user4.teams = [team]
    return [user1, user2, user3, user4]
} }

private var challenge = Challenge(id: 1, title: "Geotagging graffiti", desc: "Make an app to geotag graffiti")

private var team = Team(id: 1, name: "Frog and Code", challenge: nil, users: nil, progressPosts: exampleProgressPosts)

private var user1 = User(id: 1, username: "morhm", profileImage: #imageLiteral(resourceName: "myPicture"), teams: nil, badges: ["Challenge Guru"])
private var user2 = User(id: 2, username: "al", profileImage: #imageLiteral(resourceName: "slackIcon"), teams: nil, badges: ["Problem-Solver"])
private var user3 = User(id: 3, username: "david", profileImage: #imageLiteral(resourceName: "slackIcon"), teams: nil, badges: ["Teammate"])
private var user4 = User(id: 4, username: "anu", profileImage: #imageLiteral(resourceName: "slackIcon"), teams: nil, badges: ["Challenge Guru"])
