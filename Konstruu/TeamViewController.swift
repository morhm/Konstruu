//
//  TeamViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Model
    
    var team: DataStructures.Team? {
        didSet {
            updateUI()
            usersCollectionView?.reloadData()
            progressPostsTableView?.reloadData()
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersCollectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "user")
        progressPostsTableView.register(UINib(nibName: "ProgressPostTableViewCell", bundle: nil), forCellReuseIdentifier: "progressPost")
        updateUI()
    }
    
    // MARK: - UI
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var challengeButton: UIButton!
    
    @IBOutlet weak var usersCollectionView: UICollectionView! {
        didSet {
            usersCollectionView.dataSource = self
            usersCollectionView.delegate = self
        }
    }
    
    @IBOutlet weak var progressPostsTableView: UITableView! {
        didSet {
            progressPostsTableView.dataSource = self
            progressPostsTableView.delegate = self
        }
    }
    
    private func updateUI() {
        teamNameLabel?.text = team?.name
        challengeButton?.titleLabel?.text = team?.challenge?.title
    }
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team?.users?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "user", for: indexPath)
        
        return cell
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.progressPosts?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = progressPostsTableView.dequeueReusableCell(withIdentifier: "progressPost", for: indexPath)
        
        return cell
    }
}
