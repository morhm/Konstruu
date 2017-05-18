//
//  NewTeamViewController.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 5/16/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

private extension CGFloat {
    static let marginConstraint:CGFloat = 8.0
    static let nameTextFieldHeightConstraint:CGFloat = 35.0
    static let descriptionTextViewHeightConstraint:CGFloat = 250.0
    static let addPhotoHeightConstraint:CGFloat = 30.0
    static let addLocationHeightConstraint:CGFloat = 30.0
    static let tagFriendsHeightConstraint:CGFloat = 30.0
}

class NewTeamViewController: UIViewController {
    
    // MARK : - Constants
    
    private let titlePlaceholderText = "Team Name"
    
    private let descriptionPlaceholderText = "I am the team description: fear me! I am the team description: fear me! I am the team description: fear me! I am the team description: fear me!"
    
    private let numGroupMemPlaceholderText = "3 group members"
    
    private let lookingForMemPlaceholderText = "Looking for team member(s)"
    
    private let placeholderColor = UIColor.gray
    
    var team: Team? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        updateUI()
        
        addSubviews()
        addConstraints()
    }

    func addSubviews() {
        view.addSubview(backgroundView)
        view.sendSubview(toBack: backgroundView)
        
        view.addSubview(headerRect)
        headerRect.addSubview(teamTitleLabel)
        headerRect.addSubview(numGroupMemLabel)
        headerRect.addSubview(lookingForMemLabel)
        view.addSubview(teamDescriptionLabel)
        view.addSubview(seeMembersButton)
        view.addSubview(seeGroupButton)
        view.addSubview(requestButton)
    }
    
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
        
        // teamTitleLabel
        
        //top
        view.addConstraint(NSLayoutConstraint(item:teamTitleLabel, attribute:.top, relatedBy:.equal, toItem: headerRect, attribute:.top, multiplier: 1, constant: .marginConstraint))
//        //left
//        view.addConstraint(NSLayoutConstraint(item:teamTitleLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:teamTitleLabel, attribute: .right, relatedBy: .equal, toItem: headerRect, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
//        view.addConstraint(NSLayoutConstraint(item:teamTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30
//        ))
        
        // numGroupMemLabel
        
        //top
        view.addConstraint(NSLayoutConstraint(item:numGroupMemLabel, attribute:.top, relatedBy:.equal, toItem: teamTitleLabel, attribute:.bottom, multiplier: 1, constant: 0))
//        //left
//        view.addConstraint(NSLayoutConstraint(item:numGroupMemLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:numGroupMemLabel, attribute: .right, relatedBy: .equal, toItem: headerRect, attribute: .right, multiplier: 1, constant: .marginConstraint))
//        //height
//        view.addConstraint(NSLayoutConstraint(item:numGroupMemLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30
//        ))
        
        //lookingForMemLabel
        
        //top
        view.addConstraint(NSLayoutConstraint(item:lookingForMemLabel, attribute:.top, relatedBy:.equal, toItem: numGroupMemLabel, attribute:.bottom, multiplier: 1, constant: 0))
//        //left
//        view.addConstraint(NSLayoutConstraint(item:lookingForMemLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:lookingForMemLabel, attribute: .right, relatedBy: .equal, toItem: headerRect, attribute: .right, multiplier: 1, constant: .marginConstraint))
//        //height
//        view.addConstraint(NSLayoutConstraint(item:lookingForMemLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30
//        ))
        
        // teamDescriptionLabel
        
        //top
        view.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: headerRect, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //left
        view.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:teamDescriptionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        
        // seeMembersButton
        
        //top
        view.addConstraint(NSLayoutConstraint(item:seeMembersButton, attribute:.top, relatedBy:.equal, toItem: teamDescriptionLabel, attribute:.bottom, multiplier: 1, constant: (.marginConstraint * 6)))
        //left
        view.addConstraint(NSLayoutConstraint(item:seeMembersButton, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:seeMembersButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:seeMembersButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        
        // seeGroupButton
        
        //top
        view.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute:.top, relatedBy:.equal, toItem: seeMembersButton, attribute:.bottom, multiplier: 1, constant: 0))
        //left
        view.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:seeGroupButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        
        // requestButton
        
        //top
        view.addConstraint(NSLayoutConstraint(item:requestButton, attribute:.top, relatedBy:.equal, toItem: seeGroupButton, attribute:.bottom, multiplier: 1, constant: 0))
        //left
        view.addConstraint(NSLayoutConstraint(item:requestButton, attribute: .left, relatedBy: .equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:requestButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:requestButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        
        view.layoutIfNeeded()
    }
    
    // MARK: - UI
    
    private func updateUI() {
        print ("mr. poopoo von shnauzer")
    }
    
    private lazy var headerRect: UIView = { [unowned self] in
        let headerRect = UIView()
        headerRect.backgroundColor = UIColor.white
        return headerRect
    }()
    
    private lazy var teamTitleLabel: UILabel = { [unowned self] in
        let teamTitleLabel = UILabel()
        teamTitleLabel.text = self.titlePlaceholderText
        teamTitleLabel.textColor =  UIColor.black
        teamTitleLabel.textAlignment = .left
        teamTitleLabel.numberOfLines = 2
        
        teamTitleLabel.allowsDefaultTighteningForTruncation = true
        teamTitleLabel.adjustsFontSizeToFitWidth = true
        
        teamTitleLabel.font = UIFont.konstruuFontWithSize(28.0)
        teamTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return teamTitleLabel
    }()
    
    private lazy var numGroupMemLabel: UILabel = { [unowned self] in
        let numGroupMemLabel = UILabel()
        numGroupMemLabel.text = self.numGroupMemPlaceholderText
        numGroupMemLabel.textColor =  UIColor.black
        numGroupMemLabel.textAlignment = .left
        numGroupMemLabel.numberOfLines = 1
        
        numGroupMemLabel.allowsDefaultTighteningForTruncation = true
        numGroupMemLabel.adjustsFontSizeToFitWidth = true
        
        numGroupMemLabel.font = UIFont.konstruuFontWithSize(14.0)
        numGroupMemLabel.translatesAutoresizingMaskIntoConstraints = false
        return numGroupMemLabel
    }()
    
    private lazy var lookingForMemLabel: UILabel = { [unowned self] in
        let lookingForMemLabel = UILabel()
        lookingForMemLabel.text = self.lookingForMemPlaceholderText
        lookingForMemLabel.textColor =  UIColor.black
        lookingForMemLabel.textAlignment = .left
        lookingForMemLabel.numberOfLines = 1
        
        lookingForMemLabel.allowsDefaultTighteningForTruncation = true
        lookingForMemLabel.adjustsFontSizeToFitWidth = true
        
        lookingForMemLabel.font = UIFont.konstruuFontWithSize(14.0)
        lookingForMemLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return lookingForMemLabel
    }()
    
    private lazy var teamDescriptionLabel: UILabel = { [unowned self] in
        let teamDescriptionLabel = UILabel()
        teamDescriptionLabel.text = self.descriptionPlaceholderText
        teamDescriptionLabel.textColor =  UIColor.black
        teamDescriptionLabel.textAlignment = .left
        teamDescriptionLabel.numberOfLines = 5
        
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
    
    private lazy var seeGroupButton:
        ChallengeButton = { [unowned self] in
            let seeGroupButton = ChallengeButton(challengeButtonType: ChallengeButtonType.media)
            seeGroupButton.backgroundColor = UIColor.white
            seeGroupButton.addTarget(self, action: #selector(seeGroup), for: UIControlEvents.touchUpInside)
            
            seeGroupButton.translatesAutoresizingMaskIntoConstraints = false
            return seeGroupButton
    }()
    
    private lazy var requestButton:
        ChallengeButton = { [unowned self] in
            let requestButton = ChallengeButton(challengeButtonType: ChallengeButtonType.media)
            requestButton.backgroundColor = UIColor.white
            requestButton.addTarget(self, action: #selector(sendRequest), for: UIControlEvents.touchUpInside)
            
            requestButton.translatesAutoresizingMaskIntoConstraints = false
            return requestButton
    }()
    
    
    private lazy var backgroundView: UIImageView = { [unowned self] in
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "profileGradient.png")
        backgroundView.contentMode = UIViewContentMode.scaleAspectFill
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    
    
    // MARK: - Action
    
    func seeMembers() {
        print ("see members")
    }
    
    func seeGroup() {
        print ("see group")
    }
    
    func sendRequest() {
        
        print ("send request")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
