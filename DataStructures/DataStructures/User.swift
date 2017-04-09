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
    public let name: String
    public var desc: String?
    public var profileImage: UIImage?
    
    public var skills: [String]?
    public var teams: [Team]?
    public var badges: [String]?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(id: Int, name: String, profileImage: UIImage?, teams: [Team]?, badges: [String]?) {
        self.id = id
        self.name = name
        self.profileImage = profileImage
        self.teams = teams
        self.badges = badges
    }
}
