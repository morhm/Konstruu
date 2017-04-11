//
//  TeamViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class TeamViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
//    let itemsPerRow: CGFloat = 4
  
    // MARK: - Model
    
    var team: DataStructures.Team? {
        didSet {
            team?.challengeId = DataStructures.exampleChallenges[0].id // REMOVE AFTER DEMO
            team?.userIds = DataStructures.exampleUsers.map({ $0.id }) // REMOVE AFTER DEMO
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
      
        addSubviews()
        addConstraints()
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
        //challengeButton?.setTitle(team?.challenge?.title, for: .normal) // TODO: use firebase
    }
    
    // MARK: - Collection view data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team?.userIds?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "user", for: indexPath)
        
        if let userCell = (cell as? UserCollectionViewCell) {
            //userCell.user = team?.userIds?[indexPath.row] // TODO: use firebase
            return userCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        //profileVC.user = team?.userIds?[indexPath.row] // TODO: use firebase
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    // MARK: - Table view data source
    
    // NOTE: NOT IN USE
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return team?.progressPosts?.count ?? 0
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = progressPostsTableView.dequeueReusableCell(withIdentifier: "progressPost", for: indexPath)
//        
//        if let progressPostCell = (cell as? ProgressPostTableViewCell) {
//            progressPostCell.progressPost = team?.progressPosts?[indexPath.row]
//            return progressPostCell
//        }
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    // MARK: - Navigation
    
    @IBAction func showChallenge(_ sender: UIButton) {
        let challengeVC = ChallengeViewController(nibName: "ChallengeViewController", bundle: nil)
        //challengeVC.challenge = team?.challenge // TODO: use firebase
        self.navigationController?.pushViewController(challengeVC, animated: true)
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

