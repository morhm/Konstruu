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
    
    var challenges: [DataStructures.Challenge]?
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "challenge")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challenge", for: indexPath)
        
        if let challengeCell = (cell as? ChallengeTableViewCell) {
            challengeCell.challenge = challenges?[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeVC = ChallengeViewController(nibName: "ChallengeViewController", bundle: nil)
        challengeVC.challenge = challenges?[indexPath.row]
        present(challengeVC, animated: false, completion: nil)
    }
}
