//
//  ChallengeTableViewCell.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    let openTeamText = "Open team(s) available"
    let closedTeamText = "No open teams"
    
    // MARK: - Model
    
    var challenge: Challenge? {
        didSet {
            likeButton.layer.cornerRadius = 5
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
    
    @IBOutlet weak var openTeamLabel: UILabel!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    //var openTeamAvailable = false
    
    
    
    private func updateUI() {
        titleLabel.text = challenge?.title
        descriptionLabel.text = challenge?.desc
        
        let likesStr = String(describing: (challenge?.numberOfLikes)!)
        likeCount.text = likesStr
        
        // todo: setting the openTeamLabel to a default value makes the UI flash to that text for an instant, which is distracting. Find a way to not need to set that defualt text
        
       // openTeamLabel.text = self.closedTeamText
        
        for key in (challenge?.teamKeys)! {
            API.getTeamWithKey(key, completed: { [weak self] team in
                if (team?.open)! {
                    self?.openTeamLabel.text = self?.openTeamText
                    return
                }
                // todo: inefficient to set the text every time like this, find another way
                self?.openTeamLabel.text = self?.closedTeamText
            })
        }
    }
}
