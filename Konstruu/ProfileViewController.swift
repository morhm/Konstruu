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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - UI
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    private func updateUI() {
        profileImageView?.image = user?.profileImage
        usernameLabel?.text = user?.username
    }
    
    // MARK: - Navigation
    
    @IBAction func showFindChallenges(_ sender: UIButton) {
        let findChallengesVC = FindChallengesTableViewController(nibName: "FindChallengesTableViewController", bundle: nil)
        findChallengesVC.challenge = DataStructures.exampleChallenges[0]
        present(findChallengesVC, animated: false, completion: nil)
    }
}
