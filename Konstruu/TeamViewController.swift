//
//  TeamViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
//    let itemsPerRow: CGFloat = 4
  
    // MARK: - Model
    
    var team: Team? {
        didSet {
            updateUI()
            usersCollectionView?.reloadData()
            progressPostsTableView?.reloadData()
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.title = team?.name
        usersCollectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "user")
        progressPostsTableView.register(UINib(nibName: "ProgressPostTableViewCell", bundle: nil), forCellReuseIdentifier: "progressPost")
        updateUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "new team page", style: .plain, target: self, action: #selector(seeNewTeamPage))
        navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
      
        addSubviews()
        addConstraints()
    }
    
    func seeNewTeamPage() {
        let newTeamVC = NewTeamViewController()
        self.navigationController?.pushViewController(newTeamVC, animated: true)
    }
    
    func addSubviews() {
      view.addSubview(backgroundView)
      view.sendSubview(toBack: backgroundView)
    }
    
    func addConstraints() {
      //backgroundView
      
      //top
      view.addConstraint(NSLayoutConstraint(item:backgroundView, attribute:.top, relatedBy:.equal, toItem: view, attribute:.top, multiplier: 1, constant: 0))
      //bottom
      view.addConstraint(NSLayoutConstraint(item:backgroundView, attribute:.bottom, relatedBy:.equal, toItem: view, attribute:.bottom, multiplier: 1, constant: 0))
      //left
      view.addConstraint(NSLayoutConstraint(item:backgroundView, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: 0))
      //right
      view.addConstraint(NSLayoutConstraint(item:backgroundView, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: 0))
      
      view.layoutIfNeeded()
    }
  
    // MARK: - UI
  
    private lazy var backgroundView: UIImageView = { [unowned self] in
      let backgroundView = UIImageView()
      backgroundView.image = UIImage(named: "profileGradient.png")
      backgroundView.contentMode = UIViewContentMode.scaleAspectFill
      
      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      return backgroundView
    }()
  
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
            progressPostsTableView.rowHeight = UITableViewAutomaticDimension
            progressPostsTableView.estimatedRowHeight = 100
        }
    }
    
    private func updateUI() {
        teamNameLabel?.text = team?.name
        if let challengeKey = team?.challengeKey {
            API.getChallengeWithKey(challengeKey, completed: { [weak self] challenge in
                self?.challengeButton?.setTitle(challenge?.title, for: UIControlState.normal)
            })
        }
    }
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team?.userKeys.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "user", for: indexPath)
        
        if let userCell = (cell as? UserCollectionViewCell),
            let userKey = team?.userKeys[indexPath.row] {
            API.getUserWithKey(userKey, completed: { user in
                userCell.user = user
            })
            return userCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        if let userKey = team?.userKeys[indexPath.row] {
            API.getUserWithKey(userKey, completed: { [weak self] user in
                profileVC.user = user
                profileVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
                profileVC.navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
                self?.navigationController?.pushViewController(profileVC, animated: true)
            })
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func showChallenge(_ sender: UIButton) {
        let challengeVC = ChallengeViewController(nibName: "ChallengeViewController", bundle: nil)
        if let challengeKey = team?.challengeKey {
            API.getChallengeWithKey(challengeKey, completed: { [weak self] challenge in
                challengeVC.challenge = challenge
                challengeVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
                challengeVC.navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
                self?.navigationController?.pushViewController(challengeVC, animated: true)
            })
        }
    }
}

extension TeamViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//    let availableWidth = view.frame.width - paddingSpace
//    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: 64.0, height: 64.0)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

