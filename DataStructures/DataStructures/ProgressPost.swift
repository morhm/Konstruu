//
//  ProgressPost.swift
//  DataStructures
//
//  Created by Al Yuen on 3/8/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation

// NOTE: NOT USING IN CURRENT VERSION

public struct ProgressPost {
    public let date: Date
    public let text: String?
    public let image: UIImage?
    
    public init(date: Date, text: String?, image: UIImage?) {
        self.date = date
        self.text = text
        self.image = image
    }
}
