//
//  Challenge.swift
//  Konstruu
//
//  Created by Al Yuen on 3/7/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import CoreData
import DataStructures

// NOTE: NOT IN USE RIGHT NOW

class Challenge: NSManagedObject {
//    class func findOrCreateChallenge(matching challengeInfo: DataStructures.Challenge, in context: NSManagedObjectContext) throws -> Challenge {
//        let request: NSFetchRequest<Challenge> = Challenge.fetchRequest()
//        request.predicate = NSPredicate(format: "id = %@", challengeInfo.id)
//        
//        do {
//            let matches = try context.fetch(request)
//            if matches.count > 0 {
//                assert(matches.count == 1, "Challenge.findOrCreateChallenge -- database inconsistency")
//                return matches[0]
//            }
//        } catch {
//            throw error
//        }
//        
//        let challenge = Challenge(context: context)
//        challenge.id = Int64(challengeInfo.id)
//        challenge.title = challengeInfo.title
//        challenge.desc = challengeInfo.desc
//        return challenge
//    }
}
