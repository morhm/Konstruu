//
//  Challenge.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public struct Challenge {
    public let id: Int
    public let title: String
    public let desc: String
    
    public var teams: [Team]?
    
    init(id: Int, title: String, desc: String) {
        self.id = id
        self.title = title
        self.desc = desc
    }
    
    init(id: Int, title: String, desc: String, teams: [Team]?) {
        self.id = id
        self.title = title
        self.desc = desc
        self.teams = teams
    }
}
