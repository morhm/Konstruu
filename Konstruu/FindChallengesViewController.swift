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
            print (user as Any)
            print (user?.key as Any)
            print (user?.teamKeys as Any)
            print (user?.description as Any)
        }
    }
    
//    private func updateUI() {
//        
//        teamNameLabel?.text = team?.name
//        if let challengeKey = team?.challengeKey {
//            API.getChallengeWithKey(challengeKey, completed: { [weak self] challenge in
//                self?.challengeButton?.setTitle(challenge?.title, for: UIControlState.normal)
//            })
//        }
//    }
    
    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.title = "Find Challenges"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(addChallenge))
      
        challengeTableView.register(UINib(nibName: "ChallengeTableViewCell", bundle: nil), forCellReuseIdentifier: "challenge")
        API.getAllChallenges(completed: { [weak self] challenges in
            self?.challenges = challenges
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
  
    func addChallenge() {
        
        print (user as Any)
        print (user?.key as Any)
        print (user?.teamKeys as Any)
        print (user?.description as Any)
        
        API.getCurrentUser(completed: { [weak self] user in self?.user = user })
        
        print ("after getCurrentUser")
        
        print (user as Any)
        print (user?.key as Any)
        print (user?.teamKeys as Any)
        print (user?.description as Any)
      
//        API.createChallenge(challengeInfo: ["title": "Test Challenge" as AnyObject, "desc": "Created for user \(user?.key)" as AnyObject])
      
        print("added challenge!!")
        //updateUI()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "challenge", for: indexPath)
        
        if let challengeCell = (cell as? ChallengeTableViewCell) {
            challengeCell.challenge = challenges?[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeVC = ChallengeViewController(nibName: "ChallengeViewController", bundle: nil)
        challengeVC.user = user
        challengeVC.challenge = challenges?[indexPath.row]
        challengeVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
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
