//
//  FindChallengesViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class FindChallengesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: - Model
    
    var challenges: [Challenge]? {
        didSet {
            challengeTableView?.reloadData()
        }
    }
    
    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.title = "Find Challenges"
        challengeTableView.register(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "challenge")
        API.getAllChallenges(completed: { [weak self] challenges in
            self?.challenges = challenges
        })
    }
    
    // MARK: - UI
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet weak var challengeTableView: UITableView! {
        didSet {
            challengeTableView.dataSource = self
            challengeTableView.delegate = self
            challengeTableView.rowHeight = UITableViewAutomaticDimension
            challengeTableView.estimatedRowHeight = 150
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challenge", for: indexPath)
        
        if let challengeCell = (cell as? ChallengeTableViewCell) {
            challengeCell.challenge = challenges?[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeVC = ChallengeViewController(nibName: "ChallengeViewController", bundle: nil)
        challengeVC.challenge = challenges?[indexPath.row]
        challengeVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
        self.navigationController?.pushViewController(challengeVC, animated: true)
    }
}
