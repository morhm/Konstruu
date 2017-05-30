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
    
    //    private lazy var numGroupMemLabel: UILabel = { [unowned self] in
    //        let numGroupMemLabel = UILabel()
    //        numGroupMemLabel.text = self.numGroupMemPlaceholderText
    //        numGroupMemLabel.textColor =  UIColor.black
    //        numGroupMemLabel.textAlignment = .left
    //        numGroupMemLabel.numberOfLines = 1
    //
    //        numGroupMemLabel.allowsDefaultTighteningForTruncation = true
    //        numGroupMemLabel.adjustsFontSizeToFitWidth = true
    //
    //        numGroupMemLabel.font = UIFont.konstruuFontWithSize(14.0)
    //        numGroupMemLabel.translatesAutoresizingMaskIntoConstraints = false
    //        return numGroupMemLabel
    //    }()
    //
    //    private lazy var lookingForMemLabel: UILabel = { [unowned self] in
    //        let lookingForMemLabel = UILabel()
    //        lookingForMemLabel.text = self.lookingForMemPlaceholderText
    //        lookingForMemLabel.textColor =  UIColor.black
    //        lookingForMemLabel.textAlignment = .left
    //        lookingForMemLabel.numberOfLines = 1
    //
    //        lookingForMemLabel.allowsDefaultTighteningForTruncation = true
    //        lookingForMemLabel.adjustsFontSizeToFitWidth = true
    //
    //        lookingForMemLabel.font = UIFont.konstruuFontWithSize(14.0)
    //        lookingForMemLabel.translatesAutoresizingMaskIntoConstraints = false
    //
    //        return lookingForMemLabel
    //    }()
    
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
    
    private lazy var seeMembersButton:
        ChallengeButton = { [unowned self] in
            let seeMembersButton = ChallengeButton(challengeButtonType: ChallengeButtonType.media)
            seeMembersButton.backgroundColor = UIColor.white
            seeMembersButton.addTarget(self, action: #selector(seeMembers), for: UIControlEvents.touchUpInside)
            
            seeMembersButton.translatesAutoresizingMaskIntoConstraints = false
            return seeMembersButton
            }()
    
    //    private lazy var seeGroupButton:
    //        ChallengeButton = { [unowned self] in
    //            let seeGroupButton = ChallengeButton(challengeButtonType: ChallengeButtonType.media)
    //            seeGroupButton.backgroundColor = UIColor.white
    //            seeGroupButton.addTarget(self, action: #selector(seeGroup), for: UIControlEvents.touchUpInside)
    //
    //            seeGroupButton.translatesAutoresizingMaskIntoConstraints = false
    //            return seeGroupButton
    //    }()
    
    private lazy var requestButton:
        ChallengeButton = { [unowned self] in
            let requestButton = ChallengeButton(challengeButtonType: ChallengeButtonType.media)
            requestButton.backgroundColor = UIColor.white
            requestButton.addTarget(self, action: #selector(sendRequest), for: UIControlEvents.touchUpInside)
            
            requestButton.translatesAutoresizingMaskIntoConstraints = false
            return requestButton
            }()
    
    private lazy var tableLabel: UILabel = { [unowned self] in
        let tableLabel = UILabel()
        tableLabel.textColor = UIColor.black
        tableLabel.text = "Group Members"
        tableLabel.font = UIFont.konstruuLightFontWithSize(18.0)
        
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
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.centerX, relatedBy:.equal, toItem: headerRect, attribute:.centerX, multiplier: 1, constant: -50))
        //height
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 30.0))
        //width
        headerRect.addConstraint(NSLayoutConstraint(item:joinRequestButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 80.0))
        
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
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute:.top, relatedBy:.equal, toItem: headerRect, attribute:.bottom, multiplier: 1, constant: 30.0))
        //left
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:tableLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:20.0))
        
        // usersTableView
        
        //top
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.top, relatedBy:.equal, toItem: tableLabel, attribute:.bottom, multiplier: 1, constant: 20.0))
        
        //left
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
        
        //height
        view.addConstraint(NSLayoutConstraint(item:usersTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:120.0))
        
        
        //        // numGroupMemLabel
        //
        //        //top
        //        headerRect.addConstraint(NSLayoutConstraint(item:numGroupMemLabel, attribute:.top, relatedBy:.equal, toItem: teamTitleLabel, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        ////        //left
        //        headerRect.addConstraint(NSLayoutConstraint(item:numGroupMemLabel, attribute: .left, relatedBy: .equal, toItem: teamImageView, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //        //right
        //        headerRect.addConstraint(NSLayoutConstraint(item:numGroupMemLabel, attribute: .right, relatedBy: .equal, toItem: headerRect, attribute: .right, multiplier: 1, constant: .marginConstraint))
        ////        //height
        //        headerRect.addConstraint(NSLayoutConstraint(item:numGroupMemLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30
        //        ))
        //
        //        //lookingForMemLabel
        //
        //        //top
        //        headerRect.addConstraint(NSLayoutConstraint(item:lookingForMemLabel, attribute:.top, relatedBy:.equal, toItem: numGroupMemLabel, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //        //left
        //        headerRect.addConstraint(NSLayoutConstraint(item:lookingForMemLabel, attribute: .left, relatedBy: .equal, toItem: teamImageView, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //        //right
        //        headerRect.addConstraint(NSLayoutConstraint(item:lookingForMemLabel, attribute: .right, relatedBy: .equal, toItem: headerRect, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //        //height
        //        headerRect.addConstraint(NSLayoutConstraint(item:lookingForMemLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30
        //        ))
        
        //        // descriptionRect
        //
        //        //top
        //        view.addConstraint(NSLayoutConstraint(item:descriptionRect, attribute:.top, relatedBy:.equal, toItem: headerRect, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //        //left
        //        view.addConstraint(NSLayoutConstraint(item:descriptionRect, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //        //right
        //        view.addConstraint(NSLayoutConstraint(item:descriptionRect, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //        //height
        //        view.addConstraint(NSLayoutConstraint(item:descriptionRect, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: .descriptionRectHeight
        //        ))
        //
        //
        //    }
        
        //        // teamDescriptionLabel
        //
        //        //top
        //        view.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: headerRect, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //        //left
        //        view.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //        //right
        //        view.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //        //height
        //        view.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        //
        //        // seeMembersButton
        //
        //        //top
        //        view.addConstraint(NSLayoutConstraint(item:seeMembersButton, attribute:.top, relatedBy:.equal, toItem: teamDescriptionLabel, attribute:.bottom, multiplier: 1, constant: (.marginConstraint * 6)))
        //        //left
        //        view.addConstraint(NSLayoutConstraint(item:seeMembersButton, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //        //right
        //        view.addConstraint(NSLayoutConstraint(item:seeMembersButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //        //height
        //        view.addConstraint(NSLayoutConstraint(item:seeMembersButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        //
        //        // seeGroupButton
        //
        //        //top
        //        view.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute:.top, relatedBy:.equal, toItem: seeMembersButton, attribute:.bottom, multiplier: 1, constant: 0))
        //        //left
        //        view.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //        //right
        //        view.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //        //height
        //        view.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        //
        //        // requestButton
        //
        //        //top
        //        view.addConstraint(NSLayoutConstraint(item:requestButton, attribute:.top, relatedBy:.equal, toItem: seeGroupButton, attribute:.bottom, multiplier: 1, constant: 0))
        //        //left
        //        view.addConstraint(NSLayoutConstraint(item:requestButton, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //        //right
        //        view.addConstraint(NSLayoutConstraint(item:requestButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //        //height
        //        view.addConstraint(NSLayoutConstraint(item:requestButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        //
        //        view.layoutIfNeeded()
        //    }
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
                print (user)
                //user in userCell.user = user
                //print (user!)
            })
            return userCell
        }
        return cell
    }
    
    
    // MARK: - Action
    
    func sendJoinRequest() {
        
        print ("sending join request")
    }
    
    func seeMembers() {
        print ("see members")
    }
    
    func seeGroup() {
        print ("see group")
    }
    
    func sendRequest() {
        
        print ("send request")
    }
    
}
