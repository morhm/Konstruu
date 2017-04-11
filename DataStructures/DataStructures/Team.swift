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
    
    public var challengeId: String?
    public var userIds: [String]?

    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public init(id: String, name: String, challengeId: String?, userIds: [String]?) {
        self.id = id
        self.name = name
        self.challengeId = challengeId
        self.userIds = userIds
    }
}
