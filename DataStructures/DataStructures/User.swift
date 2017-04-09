//
//  User.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public struct User {
    public let id: Int
    // TODO: add real name
    // TODO: add description
    // TODO: add skills
    public let username: String // TODO: remove and use real name instead
    public var profileImage: UIImage?
    public var communityLevel: String? // TODO: remove?
    
    public var teams: [Team]?
    public var badges: [String]?
    
    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }
    
    init(id: Int, username: String, profileImage: UIImage?, teams: [Team]?, badges: [String]?) {
        self.id = id
        self.username = username
        self.profileImage = profileImage
        self.teams = teams
        self.badges = badges
    }
}
