//
//  ChallengeViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Model
    
    var challenge: Challenge? {
        didSet {
            updateUI()
            teamsTableView?.reloadData()
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.title = challenge?.title
        teamsTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "team")
        updateUI()
    }
    
    // MARK: - UI
    
    @IBOutlet weak var challengeTitleLabel: UILabel!
    
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    
    @IBOutlet weak var teamsTableView: UITableView! {
        didSet {
            teamsTableView.dataSource = self
            teamsTableView.delegate = self
            teamsTableView.rowHeight = UITableViewAutomaticDimension
            teamsTableView.estimatedRowHeight = 100
        }
    }
    
    private func updateUI() {
        challengeTitleLabel?.text = challenge?.title
        challengeDescriptionLabel?.text = challenge?.desc
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenge?.teamKeys.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath)
        if let teamCell = (cell as? TeamTableViewCell),
            let teamKey = challenge?.teamKeys[indexPath.row] {
            API.getTeamWithKey(teamKey, completed: { team in
                teamCell.team = team
            })
            return teamCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamVC = TeamViewController(nibName: "TeamViewController", bundle: nil)
        if let teamKey = challenge?.teamKeys[indexPath.row] {
            API.getTeamWithKey(teamKey, completed: { team in
                teamVC.team = team
                self.navigationController?.pushViewController(teamVC, animated: true)
            })
        }
    }
}
