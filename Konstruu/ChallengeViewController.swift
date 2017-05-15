//
//  ChallengeViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

private extension CGFloat {
    static let marginConstraint:CGFloat = 8.0
    static let titleHeightConstraint:CGFloat = 45.0
    static let challengeDescriptionHeightConstraint:CGFloat = 140.0
    static let customButtonHeightConstraint:CGFloat = 30.0
    static let teamsTableViewHeightConstraint:CGFloat = 150.0
}

class ChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Model
    
    var challenge: Challenge? {
        didSet {
            updateUI()
            teamsTableView?.reloadData()
        }
    }
    
    
    // MARK: - Constants
    
    private let titlePlaceholderText = "I am a challenge I am a challenge I am a challenge I am a challenge"
    private let descriptionPlaceholderText = "I am a description I am a description I am a description I am a description I am a description I am a description I am a description I am a descriptionI am a description I am a description I am a description I am a description I am a description I am a description I am a description I am a description"
    private let teamTableLabelText = "Teams working on this challenge"
    private let placeholderColor = UIColor.gray
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.konstruuLightGray()
        self.edgesForExtendedLayout = []
        teamsTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "team")
        
        addSubviews()
        addConstraints()
    }
    
    // MARK: - UI
    
    private lazy var challengeTitleLabel: UILabel = { [unowned self] in
        let challengeTitleLabel = UILabel()
        challengeTitleLabel.text = self.titlePlaceholderText
        challengeTitleLabel.textColor =  UIColor.black
        challengeTitleLabel.textAlignment = .left
        challengeTitleLabel.numberOfLines = 3
        
        challengeTitleLabel.allowsDefaultTighteningForTruncation = true
        challengeTitleLabel.adjustsFontSizeToFitWidth = true
        
        challengeTitleLabel.font = UIFont.konstruuFontWithSize(24.0)
        challengeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return challengeTitleLabel
        } ()
    
    private lazy var challengeDescriptionLabel: UILabel = { [unowned self] in
        let challengeDescriptionLabel = UILabel()
        challengeDescriptionLabel.backgroundColor = UIColor.white
        challengeDescriptionLabel.text = self.descriptionPlaceholderText
        challengeDescriptionLabel.textColor = self.placeholderColor
        challengeDescriptionLabel.textAlignment = .left
        challengeDescriptionLabel.font = UIFont.konstruuFontWithSize(14.0)
        challengeDescriptionLabel.numberOfLines = 12
        
        challengeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return challengeDescriptionLabel
    } ()
    
    private lazy var createTeamButton:
        ChallengeButton = { [unowned self] in
      let createTeamButton = ChallengeButton(challengeButtonType: ChallengeButtonType.create_team)
      createTeamButton.backgroundColor = UIColor.white
            createTeamButton.addTarget(self, action: #selector(createTeam), for: UIControlEvents.touchUpInside)
            
      createTeamButton.translatesAutoresizingMaskIntoConstraints = false
      return createTeamButton
    }()
    
    func createTeam() {
        let createTeamVC = CreateTeamViewController()
        self.navigationController?.pushViewController(createTeamVC, animated: true)
        createTeamVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
    }
    
    private lazy var bookmarkButton:
        ChallengeButton = { [unowned self] in
            let bookmarkButton = ChallengeButton(challengeButtonType: ChallengeButtonType.bookmark_challenge)
            bookmarkButton.backgroundColor = UIColor.white
            bookmarkButton.addTarget(self, action: #selector(bookmarkChallenge), for: UIControlEvents.touchUpInside)
            
            bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
            return bookmarkButton
    }()
    
    private lazy var teamsTableLabel: UILabel = { [unowned self] in
        let teamsTableLabel = UILabel()
        teamsTableLabel.text = self.teamTableLabelText
        teamsTableLabel.textColor =  UIColor.gray
        teamsTableLabel.textAlignment = .left
        teamsTableLabel.font = UIFont.konstruuFontWithSize(14.0)
        
        teamsTableLabel.translatesAutoresizingMaskIntoConstraints = false
        return teamsTableLabel
    }()
    
    
    @IBOutlet weak var teamsTableView: UITableView! {
        didSet {
            teamsTableView.dataSource = self
            teamsTableView.delegate = self
            teamsTableView.rowHeight = UITableViewAutomaticDimension
            teamsTableView.estimatedRowHeight = 100
        }
    }
    
    func addConstraints() {
        
      // challengeTitleLabel
        
      //top
      view.addConstraint(NSLayoutConstraint(item:challengeTitleLabel, attribute:.top, relatedBy:.equal, toItem: view, attribute:.top, multiplier: 1, constant: .marginConstraint))
      //left
      view.addConstraint(NSLayoutConstraint(item:challengeTitleLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
      //right
      view.addConstraint(NSLayoutConstraint(item:challengeTitleLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
      //height
      view.addConstraint(NSLayoutConstraint(item:challengeTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .titleHeightConstraint))
        
      // challengeDescriptionLabel
        
      //top
      view.addConstraint(NSLayoutConstraint(item:challengeDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: challengeTitleLabel, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
      //left
      view.addConstraint(NSLayoutConstraint(item:challengeDescriptionLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
      //right
      view.addConstraint(NSLayoutConstraint(item:challengeDescriptionLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
      //height
      view.addConstraint(NSLayoutConstraint(item:challengeDescriptionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .challengeDescriptionHeightConstraint))
        
        // createTeamButton
        
        //top
        view.addConstraint(NSLayoutConstraint(item:createTeamButton, attribute:.top, relatedBy:.equal, toItem: challengeDescriptionLabel, attribute:.bottom, multiplier: 1, constant: (.marginConstraint * 6)))
        //left
        view.addConstraint(NSLayoutConstraint(item:createTeamButton, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:createTeamButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:createTeamButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .customButtonHeightConstraint))
        
        // bookmarkButton
        
        //top
        view.addConstraint(NSLayoutConstraint(item:bookmarkButton, attribute:.top, relatedBy:.equal, toItem: createTeamButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //left
        view.addConstraint(NSLayoutConstraint(item:bookmarkButton, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:bookmarkButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:bookmarkButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .customButtonHeightConstraint))
        
        // teamsTableLabel
        
        //top
        view.addConstraint(NSLayoutConstraint(item:teamsTableLabel, attribute:.top, relatedBy:.equal, toItem: bookmarkButton, attribute:.bottom, multiplier: 1, constant: (2 * .marginConstraint)))
        //left
        view.addConstraint(NSLayoutConstraint(item:teamsTableLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:teamsTableLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:teamsTableLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .customButtonHeightConstraint))

        
        // teamsTableView
        
        //top
        view.addConstraint(NSLayoutConstraint(item:teamsTableView, attribute:.top, relatedBy:.equal, toItem: teamsTableLabel, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //left
        view.addConstraint(NSLayoutConstraint(item:teamsTableView, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:teamsTableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:teamsTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .teamsTableViewHeightConstraint))
    }
    
    
    
    // MARK: - Actions
    
    /*func createTeam() {
        //let team = API.createTeam(teamInfo: ["name": "Mark-made Team" as AnyObject, "open": true as AnyObject, "challengeKey": "not-a-key" as AnyObject])
        
        API.getCurrentUser(completed: { user in
            if user != nil {
                let team = API.createTeam(teamInfo: ["name": "Mark-made Team" as AnyObject, "open": true as AnyObject, "challengeKey": self.challenge?.key as AnyObject])
                
                team.addUser(user!)
                
                print ("user not nil")
            }
            else {
                print ("user nil")
            }
        })
        
        print (challenge?.key ?? 0)
        
        print ("added user to new team")
    } */
    
    func bookmarkChallenge() {
        print("bookmark challenge")
    }
    
    
    private func updateUI() {
    }
    
    func addSubviews() {
        view.addSubview(challengeTitleLabel)
        view.addSubview(challengeDescriptionLabel)
        view.addSubview(createTeamButton)
        view.addSubview(bookmarkButton)
        view.addSubview(teamsTableLabel)
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
                teamVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
                self.navigationController?.pushViewController(teamVC, animated: true)
            })
        }
    }
}
