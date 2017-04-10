//
//  Challenge.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public struct Challenge {
    public let id: String
    public let title: String
    public let desc: String
    
    public var teams: [Team]?
    
    public init(id: String, title: String, desc: String) {
        self.id = id
        self.title = title
        self.desc = desc
    }
    
    public init(id: String, title: String, desc: String, teams: [Team]?) {
        self.id = id
        self.title = title
        self.desc = desc
        self.teams = teams
    }
}
