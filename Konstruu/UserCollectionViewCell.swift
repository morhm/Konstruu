//
//  UserCollectionViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    // MARK: - Model
    
    var user: User? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    private func updateUI() {
        profileImageView?.clipsToBounds = true
        profileImageView?.contentMode = UIViewContentMode.scaleAspectFill
        user?.getProfileImage(completed: { [weak self] image in
            self?.profileImageView?.image = image
        })
    }

}
