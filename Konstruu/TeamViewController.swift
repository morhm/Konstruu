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
        
        self.edgesForExtendedLayout = []
        usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "user")
        
        addSubviews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usersTableView.reloadData()
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
        headerRect.addSubview(seeGroupButton)
        headerRect.addSubview(teamDescriptionLabel)
        
        view.addSubview(tableLabel)
        view.addSubview(usersTableView)
        
        view.addSubview(sampleRequestResponseButton)
        //        headerRect.addSubview(numGroupMemLabel)
        //        headerRect.addSubview(lookingForMemLabel)
        
        //        view.addSubview(descriptionRect)
        //        view.addSubview(teamDescriptionLabel)
        //        view.addSubview(seeMembersButton)
        //        view.addSubview(seeGroupButton)
        //        view.addSubview(requestButton)
    }
    
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
    
    private lazy var seeGroupButton: UIButton = { [unowned self] in
        let seeGroupButton = UIButton(type: .custom)
        seeGroupButton.setTitle("See Group", for: UIControlState())
        seeGroupButton.titleLabel!.font = UIFont.konstruuFontWithSize(15.0)
        seeGroupButton.backgroundColor = UIColor.konstruuDarkBlue()
        seeGroupButton.addTarget(self, action: #selector(seeGroup), for: UIControlEvents.touchUpInside)
        
        seeGroupButton.translatesAutoresizingMaskIntoConstraints = false
        return seeGroupButton
        }()
    
    private lazy var teamDescriptionLabel: UILabel = { [unowned self] in
        let teamDescriptionLabel = UILabel()
        teamDescriptionLabel.text = self.descriptionPlaceholderText
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

    private lazy var sampleRequestResponseButton: RequestResponseButton = { [unowned self] in
        let sampleRequestResponseButton = RequestResponseButton(type: .custom)
        sampleRequestResponseButton.setTitle("add user -- ", for: UIControlState())
        sampleRequestResponseButton.backgroundColor = UIColor.konstruuDarkBlue()
        sampleRequestResponseButton.addTarget(self, action: #selector(acceptUser), for: UIControlEvents.touchUpInside)
        sampleRequestResponseButton.translatesAutoresizingMaskIntoConstraints = false
        //sampleRequestResponseButton.userID =
        return sampleRequestResponseButton
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
        view.addConstraint(NSLayoutConstraint(item:headerRect, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
        
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
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.centerX, relatedBy:.equal, toItem: headerRect, attribute:.centerX, multiplier: 1, constant: -80))
        //height
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 30.0))
        //width
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 120.0))
        
        // seeGroupButton
        
        //top
        headerRect.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute:.top, relatedBy:.equal, toItem: locationLabel, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //centerX
        headerRect.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute:.centerX, relatedBy:.equal, toItem: headerRect, attribute:.centerX, multiplier: 1, constant: 50))
        //height
        headerRect.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 30.0))
        //width
        headerRect.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 80.0))
        
        // locationLabel
        
        //top
        headerRect.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: joinRequestButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //left
        headerRect.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: headerRect, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        headerRect.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: headerRect, attribute:.right, multiplier: 1, constant: .marginConstraint))
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
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:20.0))
        
        // usersTableView
        
        //top
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.top, relatedBy:.equal, toItem: tableLabel, attribute:.bottom, multiplier: 1, constant: 10.0))
        
        //left
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
        
        //height
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:120.0))
        
        // sampleRequestResponseButton 
        
        //top
        view.addConstraint(NSLayoutConstraint(item:sampleRequestResponseButton , attribute:.top, relatedBy:.equal, toItem: usersTableView, attribute:.bottom, multiplier: 1, constant: 30.0))
        
        //left
        view.addConstraint(NSLayoutConstraint(item:sampleRequestResponseButton , attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:sampleRequestResponseButton , attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
        
        //height
        view.addConstraint(NSLayoutConstraint(item:sampleRequestResponseButton , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:30.0))
    }
    
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.userKeys.count ?? 0
        //return (team?.userKeys.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)
        if let userCell = (cell as? UserTableViewCell),
            let userKey = team?.userKeys[indexPath.row] {
            API.getUserWithKey(userKey, completed: { user in
                userCell.user = user
            })
            return userCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    // MARK: - Action
    
    func sendJoinRequest() {
        API.getCurrentUser(completed: { user in
            self.team!.addRequest(from: user!)
        })
        joinRequestButton.setTitle("Request Sent", for: UIControlState())
        joinRequestButton.isEnabled = false
    }
    
    func seeMembers() {
        print ("see members")
    }
    
    func seeGroup() {
        print (team?.requestUserKeys)
        print ("see group")
    }
    
    func sendRequest() {
        
        print ("send request")
    }
    
    func acceptUser() {
        print ("accepting user")
        
        API.getCurrentUser(completed: { user in
            self.team!.acceptRequest(from: user!)
            print ((self.team!.requestUserKeys))
        })
        
        sampleRequestResponseButton.setTitle("accepted", for: UIControlState())
        
    }
    
}
