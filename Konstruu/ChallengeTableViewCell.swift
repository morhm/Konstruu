//
//  ChallengeTableViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class ChallengeTableViewCell: UITableViewCell {
    
    // MARK: - Model
    
    var challenge: DataStructures.Challenge? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private func updateUI() {
        // TODO: get title & description from challengeID key
        titleLabel.text = challenge?.title
        descriptionLabel.text = challenge?.desc
    }
}
