//
//  Team.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public struct Team {
    public let id: String
    public let name: String
    public var open: Bool = true
    
    public var challenge: Challenge?
    public var users: [User]?
    public var progressPosts: [ProgressPost]?
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public init(id: String, name: String, challenge: Challenge?, users: [User]?, progressPosts: [ProgressPost]?) {
        self.id = id
        self.name = name
        self.challenge = challenge
        self.users = users
        self.progressPosts = progressPosts
    }
}
