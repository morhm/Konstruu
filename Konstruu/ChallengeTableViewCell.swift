//
//  ChallengeTableViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    
    // MARK: - subviews
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - data
    
    var challengeID: Int? {
        didSet {
            updateUI()
        }
    }
    
    //TODO: remove placeholder text...
    private var challengeTitle: String! = "Mobile app to help geo-tag graffitti"
    private var challengeDescription: String! = "People can drop pins on a map to help remove grafitti. The mayor  is currently trying to help map where grafitti is to"
    
    // MARK: - relevant functions
    
    private func updateUI() {
        // TODO: get title & description from challengeID key
        titleLabel.text = challengeTitle
        descriptionLabel.text = challengeDescription
    }
}
