//
//  ProfileViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class ProfileViewController: UIViewController {
    // MARK: - Model
    
    var user: DataStructures.User? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    private func updateUI() {
        // set @IBOutlet elements to show the user's stuff
    }
    
    // MARK: - Navigation
    
    @IBAction func showFindChallenges(_ sender: UIButton) {
        let findChallengesVC = FindChallengesTableViewController(nibName: "FindChallengesTableViewController", bundle: nil)
        present(findChallengesVC, animated: false, completion: nil)
    }
}
