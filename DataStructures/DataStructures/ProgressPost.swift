//
//  ProgressPost.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

public struct ProgressPost {
    public let date: NSDate
    public let text: String?
    public let image: UIImage?
    
    init(date: NSDate, text: String?, image: UIImage?) {
        self.date = date
        self.text = text
        self.image = image
    }
}
