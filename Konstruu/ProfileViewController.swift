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
        self.edgesForExtendedLayout = []
        self.title = "Profile"
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
        self.tabBarController?.selectedIndex = 1 // TODO: Maybe fix style on this
    }
}
