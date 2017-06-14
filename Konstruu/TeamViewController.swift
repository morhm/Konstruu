//
//  TeamViewController.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 5/16/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

private extension CGFloat {
    static let marginConstraint:CGFloat = 8.0
    static let headerRectHeight:CGFloat = 240.0
    static let descriptionRectHeight:CGFloat = 60.0
    static let nameTextFieldHeightConstraint:CGFloat = 35.0
    static let descriptionTextViewHeightConstraint:CGFloat = 250.0
    static let addPhotoHeightConstraint:CGFloat = 30.0
    static let addLocationHeightConstraint:CGFloat = 30.0
    static let tagFriendsHeightConstraint:CGFloat = 30.0
}

class RequestResponseButton : UIButton {
    var userID : String = "coolness"
}

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Data
    
    var team: Team? {
        didSet {
            
            self.teamTitleLabel.text = self.team?.name
            self.locationLabel.text = self.placeholderLocationText
            self.teamDescriptionLabel.text = (self.team?.desc ?? self.descriptionPlaceholderText)
            
            // if no requests, don't show requestsTableView
            if team != nil, team?.requestUserKeys.count == 0 {
                self.requestsTableView.isHidden = true
            }
            
            /* if user is part of team, dont show message button or join request button, otherwise show them both */
            API.getCurrentUser(completed: { [weak self] user in
                if user != nil, self?.team != nil, self != nil, self?.team!.userKeys.index(of: user!.key) != nil {
                    self?.messageButton.isHidden = self!.team!.userKeys.count <= 1
                    self?.joinRequestButton.isHidden = true
                } else {
                    self?.messageButton.isHidden = true
                    self?.joinRequestButton.isHidden = false
                    self?.requestsTableView.isHidden = true
                }
            })
        }
    }
    
    // MARK : - Constants
    
    private let titlePlaceholderText = "Team Name"
    private let descriptionPlaceholderText = "I am the team description: fear me! I am the team description: fear me! I am the team description: fear me! I am the team description: fear me!"
    private let placeholderLocationText = "San Jose, CA"
    private let numGroupMemPlaceholderText = "3 group members"
    private let lookingForMemPlaceholderText = "Looking for team member(s)"
    private let placeholderColor = UIColor.gray
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItems = KonstruuTabBarController.barButtonItems
        
        self.edgesForExtendedLayout = []
        usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "user")
       
        requestsTableView.register(UINib(nibName: "RequestTableViewCell", bundle: nil), forCellReuseIdentifier: "request")
        
        addSubviews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usersTableView.reloadData()
        requestsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI
    
    func addSubviews() {
        view.addSubview(backgroundView)
        view.sendSubview(toBack: backgroundView)
        
        view.addSubview(headerRect)
        headerRect.addSubview(teamImageView)
        headerRect.addSubview(teamTitleLabel)
        headerRect.addSubview(locationLabel)
        
        headerRect.addSubview(joinRequestButton)
        headerRect.addSubview(messageButton)
        headerRect.addSubview(teamDescriptionLabel)
        
        view.addSubview(tableLabel)
        view.addSubview(usersTableView)
        
        view.addSubview(requestsTableView)
        
        //view.addSubview(sampleRequestResponseButton)
        //        headerRect.addSubview(numGroupMemLabel)
        //        headerRect.addSubview(lookingForMemLabel)
        
        //        view.addSubview(descriptionRect)
        //        view.addSubview(teamDescriptionLabel)
        //        view.addSubview(seeMembersButton)
        //        view.addSubview(seeGroupButton)
        //        view.addSubview(requestButton)
    }
    
    private lazy var tableHeaderRect: UIView = { [unowned self] in
        let headerRect = UIView()
        headerRect.backgroundColor = UIColor.white
        
        headerRect.translatesAutoresizingMaskIntoConstraints = false
        return headerRect
    }()
    
    
    private lazy var headerRect: UIView = { [unowned self] in
        let headerRect = UIView()
        headerRect.backgroundColor = UIColor.white
        
        headerRect.translatesAutoresizingMaskIntoConstraints = false
        return headerRect
    }()
    
    private lazy var descriptionRect: UIView = { [unowned self] in
        let descriptionRect = UIView()
        descriptionRect.backgroundColor = UIColor.white
        descriptionRect.translatesAutoresizingMaskIntoConstraints = false
        return descriptionRect
        }()
    
    
    private lazy var teamImageView: UIImageView = { [unowned self] in
        let teamImageView = UIImageView()
        teamImageView.image = #imageLiteral(resourceName: "slackIcon")
        teamImageView.contentMode  = .scaleAspectFill
        
        teamImageView.translatesAutoresizingMaskIntoConstraints = false
        return teamImageView
        }()
    
    private lazy var teamTitleLabel: UILabel = { [unowned self] in
        let teamTitleLabel = UILabel()
        teamTitleLabel.text = self.titlePlaceholderText
        teamTitleLabel.textColor =  UIColor.black
        teamTitleLabel.textAlignment = .center
        teamTitleLabel.numberOfLines = 2
        
        teamTitleLabel.allowsDefaultTighteningForTruncation = true
        teamTitleLabel.adjustsFontSizeToFitWidth = true
        
        teamTitleLabel.font = UIFont.konstruuFontWithSize(28.0)
        teamTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return teamTitleLabel
        }()
    
    private lazy var locationLabel: UILabel = { [unowned self] in
        let locationLabel = UILabel()
        locationLabel.textColor = UIColor.black
        locationLabel.text = self.placeholderLocationText
        locationLabel.textAlignment = .center
        locationLabel.font = UIFont.konstruuLightFontWithSize(13.0)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationLabel
        }()
    
    private lazy var joinRequestButton: UIButton = { [unowned self] in
        let joinRequestButton = UIButton(type: .custom)
        joinRequestButton.setTitle("Send Request", for: UIControlState())
        joinRequestButton.titleLabel!.font = UIFont.konstruuFontWithSize(15.0)
        joinRequestButton.backgroundColor = UIColor.konstruuDarkBlue()
        joinRequestButton.addTarget(self, action: #selector(sendJoinRequest), for: UIControlEvents.touchUpInside)
        
        joinRequestButton.translatesAutoresizingMaskIntoConstraints = false
        return joinRequestButton
        }()
    
    private lazy var messageButton: UIButton = { [unowned self] in
        let messageButton = UIButton(type: .custom)
        messageButton.setTitle("Message", for: UIControlState())
        messageButton.titleLabel!.font = UIFont.konstruuFontWithSize(15.0)
        messageButton.backgroundColor = UIColor.konstruuDarkBlue()
        messageButton.addTarget(self, action: #selector(messageGroup), for: UIControlEvents.touchUpInside)
        
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        return messageButton
        }()
    
    private lazy var teamDescriptionLabel: UILabel = { [unowned self] in
        let teamDescriptionLabel = UILabel()
        teamDescriptionLabel.text = self.team?.desc
        teamDescriptionLabel.textColor =  UIColor.black
        teamDescriptionLabel.textAlignment = .left
        teamDescriptionLabel.numberOfLines = 6
        
        teamDescriptionLabel.allowsDefaultTighteningForTruncation = true
        teamDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        teamDescriptionLabel.font = UIFont.konstruuFontWithSize(14.0)
        teamDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamDescriptionLabel
        }()
    
    private lazy var tableLabel: UILabel = { [unowned self] in
        let tableLabel = UILabel()
        tableLabel.textColor = UIColor.black
        tableLabel.text = "Group Members"
        tableLabel.font = UIFont.konstruuLightFontWithSize(16.0)
        
        tableLabel.translatesAutoresizingMaskIntoConstraints = false
        return tableLabel
        }()
    
    private lazy var usersTableView: UITableView = { [unowned self] in
        let usersTableView = UITableView()
        usersTableView.backgroundColor = UIColor.white
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        return usersTableView
        }()
    
    private lazy var backgroundView: UIImageView = { [unowned self] in
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "profileGradient.png")
        backgroundView.contentMode = UIViewContentMode.scaleAspectFill
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
        }()
    
    private lazy var requestsTableView: UITableView = { [unowned self] in
        let requestsTableView = UITableView()
        requestsTableView.backgroundColor = UIColor.white
        
        requestsTableView.delegate = self
        requestsTableView.dataSource = self
        
        requestsTableView.translatesAutoresizingMaskIntoConstraints = false
        return requestsTableView
    }()

    // MARK - Constraints
    
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
        
        //headerRect
        
        //top
        view.addConstraint(NSLayoutConstraint(item:headerRect, attribute:.top, relatedBy:.equal, toItem: view, attribute:.top, multiplier: 1, constant: 50.0))
        
        //left
        view.addConstraint(NSLayoutConstraint(item:headerRect, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:headerRect, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
        
        //height
        view.addConstraint(NSLayoutConstraint(item:headerRect, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .headerRectHeight))
        
        // teamImageView
        
        //top
        view.addConstraint(NSLayoutConstraint(item:teamImageView, attribute:.top, relatedBy:.equal, toItem: view, attribute:.top, multiplier: 1, constant: .marginConstraint))
        //centerX
        view.addConstraint(NSLayoutConstraint(item:teamImageView, attribute: .centerX, relatedBy: .equal, toItem: headerRect, attribute: .centerX, multiplier: 1, constant: 0))
        //height
        view.addConstraint(NSLayoutConstraint(item:teamImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100.0))
        //width
        view.addConstraint(NSLayoutConstraint(item:teamImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100.0))
        
        // teamTitleLabel
        
        //top
        headerRect.addConstraint(NSLayoutConstraint(item:teamTitleLabel, attribute:.top, relatedBy:.equal, toItem: teamImageView, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //centerX
        headerRect.addConstraint(NSLayoutConstraint(item:teamTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: headerRect, attribute:.centerX, multiplier: 1, constant: 0))
        //height
        headerRect.addConstraint(NSLayoutConstraint(item:teamTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20.0))
        //width
        headerRect.addConstraint(NSLayoutConstraint(item:teamTitleLabel, attribute: .width, relatedBy: .equal, toItem: headerRect, attribute: .width, multiplier: 1, constant: 0))
        
        // locationLabel
        
        //top
        headerRect.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.top, relatedBy:.equal, toItem: teamTitleLabel, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //centerX
        headerRect.addConstraint(NSLayoutConstraint(item:locationLabel, attribute: .centerX, relatedBy: .equal, toItem: headerRect, attribute:.centerX, multiplier: 1, constant: 0))
        //height
        headerRect.addConstraint(NSLayoutConstraint(item:locationLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20.0))
        //width
        headerRect.addConstraint(NSLayoutConstraint(item:locationLabel, attribute: .width, relatedBy: .equal, toItem: headerRect, attribute: .width, multiplier: 1, constant: 0))
        
        // joinRequestButton
        
        //top
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.top, relatedBy:.equal, toItem: locationLabel, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //centerX
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.centerX, relatedBy:.equal, toItem: headerRect, attribute:.centerX, multiplier: 1, constant: 0))
        //height
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 30.0))
        //width
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 120.0))
        
        // messageButton
        
        //top
        headerRect.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.top, relatedBy:.equal, toItem: locationLabel, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //centerX
        headerRect.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.centerX, relatedBy:.equal, toItem: headerRect, attribute:.centerX, multiplier: 1, constant: 0))
        //height
        headerRect.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 30.0))
        //width
        headerRect.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 80.0))
        
        // locationLabel
        
        //top
        headerRect.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: joinRequestButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //left
        headerRect.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: headerRect, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        headerRect.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: headerRect, attribute:.right, multiplier: 1, constant: -.marginConstraint))
        //height
        headerRect.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80.0))
        //width
        //headerRect.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute: .width, relatedBy: .equal, toItem: headerRect, attribute: .width, multiplier: 1, constant: 0))
        
        // tableLabel
        //top
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute:.top, relatedBy:.equal, toItem: headerRect, attribute:.bottom, multiplier: 1, constant: 20.0))
        //left
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:20.0))
        
        // usersTableView
        
        //top
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.top, relatedBy:.equal, toItem: tableLabel, attribute:.bottom, multiplier: 1, constant: 10.0))
        
        //left
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
        
        //height
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:120.0))
        
//        // sampleRequestResponseButton 
//        
//        //top
//        view.addConstraint(NSLayoutConstraint(item:sampleRequestResponseButton , attribute:.top, relatedBy:.equal, toItem: usersTableView, attribute:.bottom, multiplier: 1, constant: 30.0))
//        
//        //left
//        view.addConstraint(NSLayoutConstraint(item:sampleRequestResponseButton , attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
//        //right
//        view.addConstraint(NSLayoutConstraint(item:sampleRequestResponseButton , attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
//        
//        //height
//        view.addConstraint(NSLayoutConstraint(item:sampleRequestResponseButton , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:30.0))
        
        // requestsTableView
        
        //top
        view.addConstraint(NSLayoutConstraint(item:requestsTableView, attribute:.top, relatedBy:.equal, toItem: usersTableView, attribute:.bottom, multiplier: 1, constant: 20.0))
        
        //left
        view.addConstraint(NSLayoutConstraint(item:requestsTableView, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:requestsTableView, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
        
        //height
        view.addConstraint(NSLayoutConstraint(item:requestsTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:120.0))
    }
    
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == usersTableView {
            return team?.userKeys.count ?? 0
        } else {
            return team?.requestUserKeys.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 15
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Group Members"
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 15))
//        headerView.backgroundColor = UIColor.konstruuRed()
////        headerView.backgroundColor = UIColor.clear
//        print ("whate")
//        return headerView
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Poopoo"
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == usersTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
            if let userCell = (cell as? UserTableViewCell),
                let userKey = team?.userKeys[indexPath.row] {
                API.getUserWithKey(userKey, completed: { user in
                    userCell.user = user
                })
                return userCell
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "request", for: indexPath) as! RequestTableViewCell
            cell.acceptButton.tag = indexPath.row
            cell.acceptButton.addTarget(self, action:#selector(acceptRequest), for: .touchUpInside)
            cell.declineButton.tag = indexPath.row
            cell.declineButton.addTarget(self, action: #selector(declineRequest), for: .touchUpInside)
            if let requestCell = (cell as? RequestTableViewCell),
                let requestKey = team?.requestUserKeys[indexPath.row] {
                API.getUserWithKey(requestKey, completed: { user in
                    requestCell.user = user
                })
                return requestCell
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == usersTableView {
            let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            if let userKey = team?.userKeys[indexPath.row] {
                API.getUserWithKey(userKey, completed: { user in
                    profileVC.user = user
                    profileVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
                    //teamVC.navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
                    self.navigationController?.pushViewController(profileVC, animated: true)
                })
            }
        }
    }
    
    // MARK: - Action
    
    func sendJoinRequest() {
        API.getCurrentUser(completed: { [weak self] user in
            self?.team?.addRequest(from: user!)
        })
        joinRequestButton.setTitle("Request Sent", for: UIControlState())
        joinRequestButton.isEnabled = false
        
    }
    
    func seeMembers() {
        print ("see members")
    }
    
    func messageGroup() {
        print("messageGroup")
        if let parent = parent {
            team?.startChat(from: parent)
        }
    }
    
    @IBAction func acceptRequest(sender: UIButton) {
        let userKey = team?.requestUserKeys[sender.tag]
        API.getUserWithKey(userKey!, completed: { user in
            self.team!.acceptRequest(from: user!)
            self.requestsTableView.reloadData()
        })
    }
    
    @IBAction func declineRequest(sender: UIButton) {
        let userKey = team?.requestUserKeys[sender.tag]
        API.getUserWithKey(userKey!, completed: { user in
            self.team!.denyRequest(from: user!)
            self.requestsTableView.reloadData()
        })
    }
    
}
