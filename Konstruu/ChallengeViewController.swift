//
//  ChallengeViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class ChallengeViewController: UITableViewController {
    
    // MARK: - Model
    
    var challenge: DataStructures.Challenge? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - UI
    
    @IBOutlet weak var challengeTitleLabel: UILabel!
    
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    
    @IBOutlet weak var teamsTableView: UITableView! {
        didSet {
            self.tableView = teamsTableView
            teamsTableView.dataSource = self
        }
    }
    
    private func updateUI() {
        challengeTitleLabel?.text = challenge?.title
        challengeDescriptionLabel?.text = challenge?.desc
    }
    
    // MARK: - Table view data source
    
    // THIS DOES NOT WORK RIGHT NOW. THE APP CRASHES BECAUSE THE UITABLEVIEW IS NOT PROPERLY CONNECTED
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // transition to team page
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath)
        cell.textLabel?.text = challenge?.teams?[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenge?.teams?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
