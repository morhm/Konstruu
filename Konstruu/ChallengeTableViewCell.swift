//
//  ChallengeTableViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    
    
    
    // MARK: - Model
    
    var challenge: Challenge? {
        didSet {
            updateUI()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // configure the view for the selected state
    }
    
    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    private func updateUI() {
        titleLabel.text = challenge?.title
        descriptionLabel.text = challenge?.desc
        
        let likesStr = String(describing: (challenge?.numberOfLikes)!)
        likeCount.text = likesStr
    }
}
