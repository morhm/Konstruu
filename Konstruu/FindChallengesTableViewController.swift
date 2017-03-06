//
//  FindChallengesTableViewController.swift
//  
//
//  Created by Al Yuen on 3/6/17.
//
//

import UIKit

class FindChallengesTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: THIS DOESN'T WORK!!!!!!!! (I think)
        tableView.register(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "challenge")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challenge", for: indexPath)
        
        if let challengeCell = (cell as? ChallengeTableViewCell) {
            // TODO: change once we have a model so that it passes the model object
            challengeCell.challengeID = 1
        }

        return cell
    }
}
