//
//  TeamTableViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class TeamTableViewCell: UITableViewCell {

    // MARK: - Model
    
    var team: DataStructures.Team? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var nameLabel: UILabel!
    
    private func updateUI() {
        nameLabel.text = team?.name
    }
}
