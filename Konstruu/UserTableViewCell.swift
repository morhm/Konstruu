//
//  UserTableViewCell.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 5/29/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - Model
    
    var user: User? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var nameLabel: UILabel!
    
    private func updateUI() {
        nameLabel.text = user?.name
    }
    
}
