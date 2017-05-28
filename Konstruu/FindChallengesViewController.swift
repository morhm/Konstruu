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
    var whiteRoundedView: UIView!
    
    // count to ensure that whiteRoundedView isn't added excessively
    var numLoaded = 0
    
    // MARK: - Constants
    
    /*  [unused]
        spacing for header and footer of cells
    */
    let cellSpacingHeight = CGFloat(7.0)
    
    
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
            
            // todo: account for when a challenge is added
            self?.challenges = challenges
            
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
            
        })
        //addSubviews()
        //addConstraints()
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
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        challengeTableView.reloadData()
        API.getAllChallenges(completed: { [weak self] challenges in
          self?.challenges = challenges
          self?.challengeTableView.reloadData()
        })
    }
    
    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = { [unowned self] in
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "profileGradient.png")
        backgroundView.contentMode = UIViewContentMode.scaleAspectFill
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
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
            challengeTableView.separatorStyle = .none
            //challengeTableView.rowHeight = UITableViewAutomaticDimension
            //challengeTableView.estimatedRowHeight = 150
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
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return challenges?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
/*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
*/
    
/*
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
*/
    
/*    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.clear
        whiteRoundedView.frame = CGRect(x: 10, y: 10, width: (self.view.frame.size.width - 10), height: 120)
    }
*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challenge", for: indexPath) as! ChallengeTableViewCell
        
        cell.tag = indexPath.section
        
        if (numLoaded < (challenges?.count)! ) {
            numLoaded = numLoaded + 1
            whiteRoundedView = UIView(frame: CGRect(x: 10, y: 10, width: (self.view.frame.size.width - 10), height: 120))
        
            whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
            whiteRoundedView.layer.masksToBounds = false
            whiteRoundedView.layer.cornerRadius = 10.0
            whiteRoundedView.layer.shadowOffset = CGSize(width: -0, height: 1.0)
            whiteRoundedView.layer.shadowOpacity = 0.2
        
            cell.contentView.addSubview(whiteRoundedView)
            cell.contentView.sendSubview(toBack: whiteRoundedView)
        }

        cell.likeButton.tag = indexPath.section
        cell.likeButton.setTitle(likes?[indexPath.section], for: .normal)
        cell.likeButton.addTarget(self, action: #selector(handleLikes), for: .touchUpInside)
        
        cell.bookmarkButton.tag = indexPath.section
        cell.bookmarkButton.addTarget(self, action: #selector(bookmark), for: .touchUpInside)
        
        cell.shareButton.tag = indexPath.section
        cell.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        cell.challenge = challenges?[indexPath.section]
        
        return cell
    }
    
    // MARK: - Actions
    
    @IBAction func handleLikes(sender: AnyObject) {
        let selectedChallenge = challenges?[(sender.tag)!]
        let challengeKey = (selectedChallenge?.key)!
        
        for i in (user?.likedChallengeKeys)! {
            if i == challengeKey {
                //print ("unliking")
                user?.unlikeChallenge(selectedChallenge!)
                likes?[sender.tag] = "like"
                sender.setTitle(likes?[sender.tag], for: .normal)
                challengeTableView.reloadData()
                return
            }
        }
        //print ("liking")
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
        challengeVC.challenge = challenges?[indexPath.section]
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
