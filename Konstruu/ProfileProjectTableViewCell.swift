//
//  ProfileProjectTableViewCell.swift
//  Konstruu
//
//  Created by David Xue on 4/25/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

private extension CGFloat {
  static let cardViewTopConstraint:CGFloat           = 10.0
  
  static let titleLabelTopConstraint:CGFloat         = 10.0
  static let titleLabelHeightConstraint:CGFloat      = 30.0
  static let titleLabelLeftConstraint:CGFloat        = 15.0
  
  static let imageViewLeftConstraint: CGFloat        = 10.0
  static let imageViewTopConstraint:CGFloat          = 20.0
  static let imageViewHeightConstraint: CGFloat      = 80.0
  static let imageViewWidthConstraint: CGFloat       = 80.0
  
  static let tableViewTopConstraint:CGFloat           = 8.0
  static let tableViewBottomConstraint:CGFloat        = 8.0
  static let tableViewLeftConstraint:CGFloat          = 8.0
  static let tableViewRightConstraint:CGFloat         = 8.0
  
  static let descriptionLabelTopConstraint:CGFloat    = 0.0
  static let descriptionLabelHeightConstraint:CGFloat = 60.0
}

class ProfileProjectTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - Data
  
  var user: User? {
    didSet {
      user?.getTeams(completed: { [weak self] teams in
        self?.teams = teams
      })
    }
  }
  
  var teams: [Team]? {
    didSet {
      firstProjectNameLabel.text = teams?[0].name
      secondProjectNameLabel.text = teams?[1].name
    }
  }
  
  var navController: UINavigationController?
  
  private var updated = false
  
  // MARK: - Subviews
  
  private lazy var titleLabel : UILabel = { [unowned self] in
    let titleLabel = UILabel()
    titleLabel.textColor = UIColor.black
    titleLabel.text  = "Teams"
    titleLabel.textAlignment = .left
    titleLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
    }()
  
  private lazy var cardView: UIView = { [unowned self] in
    let cardView = UIView()
    cardView.backgroundColor = UIColor.white
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
    }()
  
  private lazy var teamsTableView: UITableView = { [unowned self] in
    let teamsTableView = UITableView()
    teamsTableView.backgroundColor = UIColor.clear
    
    teamsTableView.delegate = self
    teamsTableView.dataSource = self
  
    teamsTableView.translatesAutoresizingMaskIntoConstraints = false
    return teamsTableView
  }()

  
  private lazy var firstProjectNameLabel : UILabel = { [unowned self] in
    let nameLabel = UILabel()
    nameLabel.textColor = UIColor.black
    nameLabel.text  = self.teams?[0].name
    nameLabel.textAlignment = .left
    nameLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    return nameLabel
    }()
  
  private lazy var secondProjectNameLabel : UILabel = { [unowned self] in
    let nameLabel = UILabel()
    nameLabel.textColor = UIColor.black
    nameLabel.text  = self.teams?[1].name
    nameLabel.textAlignment = .left
    nameLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    return nameLabel
    }()
  
  private lazy var firstProjectDescriptionLabel : UILabel = { [unowned self] in
    let descriptionLabel = UILabel()
    descriptionLabel.textColor = UIColor.black
    descriptionLabel.text  = "Test"
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLabel
    }()
  
  private lazy var secondProjectDescriptionLabel : UILabel = { [unowned self] in
    let descriptionLabel = UILabel()
    descriptionLabel.textColor = UIColor.black
    descriptionLabel.text  = "Test"
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLabel
    }()
  
  // MARK: - Init
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = UIColor.clear
    
    selectionStyle = .none
    accessibilityLabel = "projectCell"
    
    contentView.addSubview(cardView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(teamsTableView)
    
//    contentView.addSubview(firstProjectNameLabel)
//    contentView.addSubview(firstProjectDescriptionLabel)
//    contentView.addSubview(secondProjectNameLabel)
//    contentView.addSubview(secondProjectDescriptionLabel)
    
    updateConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    guard !updated else {
      super.updateConstraints()
      return
    }
    updated = true
    
    //cardView
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:cardView, attribute:.top, relatedBy:.equal, toItem: contentView, attribute:.top, multiplier: 1, constant: .cardViewTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:cardView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: 0))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:cardView, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: 0))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:cardView, attribute:.bottom, relatedBy:.equal, toItem: contentView, attribute:.bottom, multiplier: 1, constant: 0))
    

    //titleLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:titleLabel, attribute:.top, relatedBy:.equal, toItem: cardView, attribute:.top, multiplier: 1, constant: .titleLabelTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:titleLabel, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .titleLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:titleLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:titleLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .titleLabelHeightConstraint))
    
    
    //tableView
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:teamsTableView, attribute:.top, relatedBy:.equal, toItem: titleLabel, attribute:.bottom, multiplier: 1, constant: .tableViewTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:teamsTableView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .tableViewLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:teamsTableView, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.tableViewRightConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:teamsTableView, attribute:.bottom, relatedBy:.equal, toItem: contentView, attribute:.bottom, multiplier: 1, constant: -.tableViewBottomConstraint))
    
//    //firstProjectNameLabel
//    
//    //left
//    contentView.addConstraint(NSLayoutConstraint(item:firstProjectNameLabel, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .nameLabelLeftConstraint))
//    //right
//    contentView.addConstraint(NSLayoutConstraint(item:firstProjectNameLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
//    //top
//    contentView.addConstraint(NSLayoutConstraint(item:firstProjectNameLabel, attribute:.top, relatedBy:.equal, toItem: titleLabel, attribute:.bottom, multiplier: 1, constant: .nameLabelTopConstraint))
//    //height
//    contentView.addConstraint(NSLayoutConstraint(item:firstProjectNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
//    
//    //firstProjectDescriptionLabel
//    
//    //left
//    contentView.addConstraint(NSLayoutConstraint(item:firstProjectDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: firstProjectNameLabel, attribute:.left, multiplier: 1, constant: 0))
//    //right
//    contentView.addConstraint(NSLayoutConstraint(item:firstProjectDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: firstProjectNameLabel, attribute:.right, multiplier: 1, constant: 0))
//    //top
//    contentView.addConstraint(NSLayoutConstraint(item:firstProjectDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: firstProjectNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
//    //height
//    contentView.addConstraint(NSLayoutConstraint(item:firstProjectDescriptionLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .descriptionLabelHeightConstraint))
//    
//    //secondProjectNameLabel
//    
//    //left
//    contentView.addConstraint(NSLayoutConstraint(item:secondProjectNameLabel, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .nameLabelLeftConstraint))
//    //right
//    contentView.addConstraint(NSLayoutConstraint(item:secondProjectNameLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
//    //top
//    contentView.addConstraint(NSLayoutConstraint(item:secondProjectNameLabel, attribute:.top, relatedBy:.equal, toItem: firstProjectDescriptionLabel, attribute:.bottom, multiplier: 1, constant: .nameLabelTopConstraint))
//    //height
//    contentView.addConstraint(NSLayoutConstraint(item:secondProjectNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
//    
//    //secondProjectDescriptionLabel
//    
//    //left
//    contentView.addConstraint(NSLayoutConstraint(item:secondProjectDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: secondProjectNameLabel, attribute:.left, multiplier: 1, constant: 0))
//    //right
//    contentView.addConstraint(NSLayoutConstraint(item:secondProjectDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: secondProjectNameLabel, attribute:.right, multiplier: 1, constant: 0))
//    //top
//    contentView.addConstraint(NSLayoutConstraint(item:secondProjectDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: secondProjectNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
//    //height
//    contentView.addConstraint(NSLayoutConstraint(item:secondProjectDescriptionLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .descriptionLabelHeightConstraint))
//    
    super.updateConstraints()
  }
  
  // MARK: - Table view data source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return user?.teamKeys.count ?? 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath)
    if let teamCell = (cell as? TeamTableViewCell),
      let teamKey = user?.teamKeys[indexPath.row] {
      API.getTeamWithKey(teamKey, completed: { team in
        teamCell.team = team
      })
      return teamCell
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let teamVC = TeamViewController(nibName: "TeamViewController", bundle: nil)
    if let teamKey = user?.teamKeys[indexPath.row] {
      API.getTeamWithKey(teamKey, completed: { team in
        teamVC.team = team
        teamVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
        teamVC.navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
        self.navController?.pushViewController(teamVC, animated: true)
      })
    }
  }
}
