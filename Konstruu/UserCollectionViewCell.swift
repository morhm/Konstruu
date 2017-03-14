//
//  UserCollectionViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class UserCollectionViewCell: UICollectionViewCell {

    // MARK: - Model
    
    var user: DataStructures.User? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    private func updateUI() {
        profileImageView?.clipsToBounds = true
        profileImageView?.contentMode = UIViewContentMode.scaleAspectFill
        profileImageView?.image = user?.profileImage
    }

}
