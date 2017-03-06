//
//  ChallengeTableViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    var challengeID: Int? {
        didSet {
            updateUI()
        }
    }
    
    // TODO: change once we flesh this out!
    @IBOutlet weak var challengeIDLabel: UILabel!
    
    private func updateUI() {
        challengeIDLabel.text = "\(challengeID)"
    }
}
