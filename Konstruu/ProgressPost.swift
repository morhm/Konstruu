//
//  ProgressPost.swift
//  Konstruu
//
//  Created by Al Yuen on 3/7/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import CoreData
import DataStructures

class ProgressPost: NSManagedObject {
    class func createProgressPost(matching progressPostInfo: DataStructures.ProgressPost, for teamInfo: DataStructures.Team, in context: NSManagedObjectContext) -> ProgressPost {
        let progressPost = ProgressPost(context: context)
        progressPost.date = progressPostInfo.date as NSDate?
        progressPost.text = progressPostInfo.text
        if progressPostInfo.image != nil, let imageData = UIImageJPEGRepresentation(progressPostInfo.image!, 1) {
            progressPost.imageData = NSData(base64Encoded: imageData)
        }
        progressPost.team = try? Team.findOrCreateTeam(matching: teamInfo, in: context)
        return progressPost
    }
}
