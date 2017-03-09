//
//  User.swift
//  Konstruu
//
//  Created by Al Yuen on 3/7/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import CoreData
import DataStructures

class User: NSManagedObject {
    class func findOrCreateUser(matching userInfo: DataStructures.User, in context: NSManagedObjectContext) throws -> User {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", userInfo.id)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "User.findOrCreateUser -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let user = User(context: context)
        user.id = Int64(userInfo.id)
        if userInfo.profileImage != nil, let imageData = UIImageJPEGRepresentation(userInfo.profileImage!, 1) {
            user.profileImageData = NSData(base64Encoded: imageData)
        }
        return user
    }
}
