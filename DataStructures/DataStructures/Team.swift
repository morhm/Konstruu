//
//  Team.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public struct Team {
    public let id: Int // TODO: remove and use name as unique
    public let name: String
    public var lookingForTeammates: Bool = true
    
    public var challenge: Challenge?
    public var users: [User]?
    public var progressPosts: [ProgressPost]?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(id: Int, name: String, challenge: Challenge?, users: [User]?, progressPosts: [ProgressPost]?) {
        self.id = id
        self.name = name
        self.challenge = challenge
        self.users = users
        self.progressPosts = progressPosts
    }
}
