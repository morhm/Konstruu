//
//  RequestTableViewCell.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 6/2/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {

    // MARK: - Model
    
    var user: User? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    
    
    private func updateUI() {
        nameLabel.text = user?.name
        
        nameLabel.adjustsFontSizeToFitWidth = true
        
        acceptButton.backgroundColor = UIColor.konstruuGreen()
        acceptButton.layer.cornerRadius = 10.0
        acceptButton.layer.borderColor = UIColor.konstruuLightGray().cgColor
        acceptButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        acceptButton.setTitleColor(UIColor.konstruuBlack(), for: UIControlState.highlighted)
        
        declineButton.backgroundColor = UIColor.konstruuLightGray()
        declineButton.layer.cornerRadius = 10.0
        declineButton.layer.borderColor = UIColor.konstruuBlack().cgColor
        declineButton.setTitleColor(UIColor.konstruuBlack(), for: UIControlState.highlighted)
    }
    
}
