//
//  ProfileViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        badgesTableView.register(UINib(nibName: "BadgeTableViewCell", bundle: nil), forCellReuseIdentifier: "badge")
        updateUI()
    }
    
    // MARK: - UI
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var badgesTableView: UITableView! {
        didSet {
            badgesTableView.dataSource = self
            badgesTableView.delegate = self
            badgesTableView.rowHeight = UITableViewAutomaticDimension
            badgesTableView.estimatedRowHeight = 100
        }
    }
    
    private func updateUI() {
        profileImageView?.clipsToBounds = true
        profileImageView?.contentMode = UIViewContentMode.scaleAspectFill
        profileImageView?.image = user?.profileImage
        usernameLabel?.text = user?.username
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.badges?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "badge", for: indexPath)
        
        if let badgeCell = (cell as? BadgeTableViewCell) {
            badgeCell.badgeTitle = user?.badges?[indexPath.row]
            return badgeCell
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    @IBAction func showFindChallenges(_ sender: UIButton) {
        if let tabBarController = (self.tabBarController as? KonstruuTabBarController) {
            tabBarController.findChallengesWasClicked()
        }
    }
}
