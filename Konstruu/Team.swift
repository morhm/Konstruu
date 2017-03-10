//
//  Team.swift
//  Konstruu
//
//  Created by Al Yuen on 3/7/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import CoreData
import DataStructures

class Team: NSManagedObject {
    class func findOrCreateTeam(matching teamInfo: DataStructures.Team, in context: NSManagedObjectContext) throws -> Team {
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", teamInfo.id)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Team.findOrCreateTeam -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let team = Team(context: context)
        team.id = Int64(teamInfo.id)
        team.name = teamInfo.name
        team.lookingForTeammates = teamInfo.lookingForTeammates
        if let challenge = teamInfo.challenge {
            team.challenge = try? Challenge.findOrCreateChallenge(matching: challenge, in: context)
        }
        return team
    }
}
