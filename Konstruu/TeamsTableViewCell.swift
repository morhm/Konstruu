//
//  TeamsTableViewCell.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 5/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {

    var team: Team? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var teamTitleLabel: UILabel!
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    private func updateUI() {
        teamTitleLabel.text = team?.name
    }
    
}
