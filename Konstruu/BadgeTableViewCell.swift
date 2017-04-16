//
//  BadgeTableViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/13/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class BadgeTableViewCell: UITableViewCell {

    // MARK: - Model
    
    var badgeTitle: String? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private func updateUI() {
        titleLabel?.text = badgeTitle
        if badgeTitle != nil {
            descriptionLabel?.text = badges[badgeTitle!]
        }
    }
}
