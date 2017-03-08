//
//  ProgressPost.swift
//  Konstruu
//
//  Created by Al Yuen on 3/7/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import CoreData

class ProgressPost: NSManagedObject {
    class func createProgressPost(date: NSDate, text: String?, image: UIImage?, for team: Team, in context: NSManagedObjectContext) -> ProgressPost {
        let progressPost = ProgressPost(context: context)
        progressPost.date = date
        progressPost.text = text
        if image != nil, let imageData = UIImageJPEGRepresentation(image!, 1) {
            progressPost.imageData = NSData(base64Encoded: imageData)
        }
        progressPost.team = team
        return progressPost
    }
}
