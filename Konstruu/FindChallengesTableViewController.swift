//
//  FindChallengesTableViewController.swift
//
//
//  Created by Al Yuen on 3/6/17.
//
//

import UIKit
import DataStructures

class FindChallengesTableViewController: UITableViewController {
    
    // MARK: - Model
    
    var challenge: DataStructures.Challenge?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "challenge")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challenge", for: indexPath)
        
        if let challengeCell = (cell as? ChallengeTableViewCell) {
            // TODO: change once we have a model so that it passes the model object
            challengeCell.challenge = challenge
        }
        
        return cell
    }
}
