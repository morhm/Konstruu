//
//  Badge.swift
//  Konstruu
//
//  Created by Al Yuen on 3/7/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import CoreData

class Badge: NSManagedObject {
    class func findBadge(named title: String, in context: NSManagedObjectContext) throws -> Badge? {
        let request: NSFetchRequest<Badge> = Badge.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Badge.findBadge -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        return nil
    }
}
