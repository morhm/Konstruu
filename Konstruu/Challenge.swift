//
//  Challenge.swift
//  Konstruu
//
//  Created by Al Yuen on 3/7/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import CoreData

class Challenge: NSManagedObject {
    class func findOrCreateChallenge(withID id: Int, in context: NSManagedObjectContext) throws -> Challenge {
        let request: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Challenge.findOrCreateChallenge -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let challenge = Challenge(context: context)
        challenge.id = Int64(id)
        return challenge
    }
}
