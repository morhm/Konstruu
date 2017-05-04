//
//  TeamsTableViewCell.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 5/4/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {
    
    var Team: Team? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var memberCount: UILabel!
    
    @IBOutlet weak var lastActivity: UILabel!
    
    @IBOutlet weak var notificationIcon: UIImageView!
    
    private func updateUI() {
        
        
        
       // titleLabel.text = team?.title
       // memberCount.text = team?.desc
    }
    
}
