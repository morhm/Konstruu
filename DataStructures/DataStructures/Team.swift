//
//  Team.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public struct Team {
    public let name: String
    public var open: Bool = true
    
    public var challenge: Challenge?
    public var users: [User]?
    public var progressPosts: [ProgressPost]?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, challenge: Challenge?, users: [User]?, progressPosts: [ProgressPost]?) {
        self.name = name
        self.challenge = challenge
        self.users = users
        self.progressPosts = progressPosts
    }
}
