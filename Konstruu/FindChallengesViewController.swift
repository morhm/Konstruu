//
//  FindChallengesViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/9/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class FindChallengesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var likes: [String]!
    
    // MARK: - Model
    
    var challenges: [Challenge]? {
        didSet {
            if challenges != nil, challenges!.isEmpty {
                noResultsLabel.isHidden = false
            } else {
                noResultsLabel.isHidden = true
            }
            challengeTableView?.reloadData()
            
        }
    }
    
    var user: User? {
        didSet {
            
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
            
            print (challenges.count)
            print (challenges)
            
            self?.likes = Array(repeating: "like", count: challenges.count)
            
            for i in 0...(challenges.count - 1) {
                let currKey = (challenges[i].key)!
                for key in (self?.user?.likedChallengeKeys)! {
                    if currKey == key {
                        self?.likes[i] = "unlike"
                        break
                    }
                }
            }
            print (self?.likes)
        })
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        challengeTableView.reloadData()
        API.getAllChallenges(completed: { [weak self] challenges in
          self?.challenges = challenges
          self?.challengeTableView.reloadData()
        })
    }
    
    // MARK: - UI
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            addToolbarToKeyboard()
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
    
    @IBOutlet weak var noResultsLabel: UILabel!
    
    private func addToolbarToKeyboard() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        searchBar.inputAccessoryView = toolbar
    }
    
    func doneClicked() {
        view.endEditing(true)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challenge", for: indexPath) as! ChallengeTableViewCell
        
        cell.tag = indexPath.row
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.setTitle(likes?[indexPath.row], for: .normal)
        cell.likeButton.addTarget(self, action: #selector(handleLikes), for: .touchUpInside)
        
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.addTarget(self, action: #selector(bookmark), for: .touchUpInside)
        
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        cell.challenge = challenges?[indexPath.row]
        
        return cell
    }
    
    @IBAction func handleLikes(sender: AnyObject){
        let selectedChallenge = challenges?[(sender.tag)!]
        let challengeKey = (selectedChallenge?.key)!
        
        for i in (user?.likedChallengeKeys)! {
            if i == challengeKey {
                print ("unliking")
                user?.unlikeChallenge(selectedChallenge!)
                likes?[sender.tag] = "like"
                sender.setTitle(likes?[sender.tag], for: .normal)
                challengeTableView.reloadData()
                return
            }
        }
        
        print ("liking")
        user?.likeChallenge(selectedChallenge!)
        likes?[sender.tag] = "unlike"
        sender.setTitle(likes?[sender.tag], for: .normal)
        challengeTableView.reloadData()
    }
    
    @IBAction func bookmark(sender: AnyObject) {
        
        print ("bookmarking dooooood")
        print (sender.tag)
        //sender.setTitle("bookmarked", for: UIControlState.normal)
    }
    
    @IBAction func share(sender: AnyObject) {
        print ("sharon ooh ooh")
        print (sender.tag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeVC = ChallengeViewController(nibName: "ChallengeViewController", bundle: nil)
        challengeVC.user = user
        challengeVC.challenge = challenges?[indexPath.row]
        challengeVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
        //challengeVC.navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
        self.navigationController?.pushViewController(challengeVC, animated: true)
    }
    
    // MARK: - Search bar delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let keyword = searchBar.text, !keyword.isEmpty {
            API.searchChallenges(keyword: keyword, completed: { challenges in
                self.challenges = challenges
            })
        } else {
            API.getAllChallenges(completed: { challenges in
                self.challenges = challenges
            })
        }
    }
}
