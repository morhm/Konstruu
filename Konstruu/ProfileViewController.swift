//
//  ProfileViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // TODO: change after demo
    var userID: Int? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func showFindChallenges(_ sender: UIButton) {
        let findChallengesVC = FindChallengesTableViewController(nibName: "FindChallengesTableViewController", bundle: nil)
        present(findChallengesVC, animated: false, completion: nil)
    }
    
    private func updateUI() {
        usernameLabel.text = "\(userID)"
    }
}
