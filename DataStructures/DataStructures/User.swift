//
//  User.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public struct User {
    // TODO: add email address or FB info or whatever they use to log in
    // TODO: add authentification information
    
    public let id: String
    public let name: String
    public var desc: String?
    public var profileImage: UIImage?
    
    public var skills: [String]?
    public var teamIds: [String]?
    public var badges: [String]?
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public init(id: String, name: String, profileImage: UIImage?, teamIds: [String]?, badges: [String]?) {
        self.id = id
        self.name = name
        self.profileImage = profileImage
        self.teamIds = teamIds
        self.badges = badges
    }
}
