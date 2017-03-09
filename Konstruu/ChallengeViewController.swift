//
//  ChallengeViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class ChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Model
    
    var challenge: DataStructures.Challenge? {
        didSet {
            updateUI()
            teamsTableView?.reloadData()
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamsTableView?.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "team")
        updateUI()
    }
    
    // MARK: - UI
    
    @IBOutlet weak var challengeTitleLabel: UILabel!
    
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    
    @IBOutlet weak var teamsTableView: UITableView! {
        didSet {
            teamsTableView.dataSource = self
            teamsTableView.delegate = self
        }
    }
    
    private func updateUI() {
        challengeTitleLabel?.text = challenge?.title
        challengeDescriptionLabel?.text = challenge?.desc
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // transition to team page
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath)
        if let teamCell = (cell as? TeamTableViewCell) {
            teamCell.team = challenge?.teams?[indexPath.row]
            return teamCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenge?.teams?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
