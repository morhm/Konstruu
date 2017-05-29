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
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
