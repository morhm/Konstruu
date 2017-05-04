//
//  ProfileInfoTableViewCell.swift
//  Konstruu
//
//  Created by David Xue on 4/24/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import Foundation
import UIKit

private extension CGFloat {
  static let imageViewTopConstraint : CGFloat        = 0.0
  static let imageViewHeightConstraint: CGFloat      = 100.0
  static let imageViewWidthConstraint: CGFloat       = 100.0
  
  static let cardViewTopConstraint:CGFloat          = 50.0
  
  static let nameLabelTopConstraint: CGFloat        = 10.0
  static let nameLabelHeightConstraint:CGFloat      = 20.0
  static let nameLabelWidthConstraint:CGFloat       = 200.0

  static let educationLabelTopConstraint: CGFloat     = 4.0
  static let educationLabelHeightConstraint:CGFloat   = 20.0
  static let educationLabelWidthConstraint:CGFloat    = 200.0
  
  static let locationLabelTopConstraint: CGFloat        = 0.0
  static let locationLabelHeightConstraint:CGFloat      = 20.0
  static let locationLabelWidthConstraint:CGFloat       = 200.0
  
  static let messageButtonTopConstraint:CGFloat         = 5.0
  static let messageButtonHeightConstraint:CGFloat      = 30.0
  static let messageButtonWidthConstraint:CGFloat       = 80.0
  
  static let descriptionLabelTopConstraint:CGFloat      = 5.0
  static let descriptionLabelBottomConstraint:CGFloat   = 20.0
  static let descriptionLabelLeftConstraint:CGFloat     = 20.0
  static let descriptionLabelRightConstraint:CGFloat    = 20.0
}

class ProfileInfoTableViewCell: UITableViewCell {
  
  // MARK: - Data
  
    var user: User? {
        didSet {
            usernameLabel.text = user?.name
            descriptionLabel.text = user?.desc
            user?.getProfileImage(completed: { [weak self] image in
                self?.profileImage = image
            })
            messageButton.isHidden = user?.isCurrentUser() ?? false
        }
    }
    
    var parentViewController: UIViewController!
  
  var educationText:String? = "Senior at Phoenix High School" {
    didSet {
      educationLabel.text = educationText
    }
  }
  
  var locationText:String? = "San Jose, CA" {
    didSet {
      locationLabel.text = locationText
    }
  }
  
  var profileImage:UIImage? {
    didSet {
      profileImageView.image = profileImage
    }
  }
  
  private var updated = false
  
  // MARK: - Subviews
  
  private lazy var cardView: UIView = { [unowned self] in
    let cardView = UIView()
    cardView.backgroundColor = UIColor.white
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
    }()
  
  private lazy var profileImageView: UIImageView = { [unowned self] in
    let profileImageView = UIImageView()
    profileImageView.image = self.profileImage
    profileImageView.contentMode = .scaleAspectFill
    
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    return profileImageView
    }()
  
  private lazy var usernameLabel : UILabel = { [unowned self] in
    let usernameLabel = UILabel()
    usernameLabel.textColor = UIColor.black
    usernameLabel.text  = self.user?.name
    usernameLabel.textAlignment = .center
    usernameLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    return usernameLabel
    }()
  
  private lazy var educationLabel : UILabel = { [unowned self] in
    let educationLabel = UILabel()
    educationLabel.textColor = UIColor.black
    educationLabel.text  = self.educationText
    educationLabel.textAlignment = .center
    educationLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    educationLabel.translatesAutoresizingMaskIntoConstraints = false
    return educationLabel
    }()
  
  private lazy var locationLabel : UILabel = { [unowned self] in
    let locationLabel = UILabel()
    locationLabel.textColor = UIColor.black
    locationLabel.text  = self.locationText
    locationLabel.textAlignment = .center
    locationLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    return locationLabel
    }()
  
  
  private lazy var messageButton: UIButton = { [unowned self] in
    let messageButton = UIButton(type: .custom)
    messageButton.setTitle("Message", for: UIControlState())
    messageButton.titleLabel!.font = UIFont.konstruuFontWithSize(15.0)
    messageButton.backgroundColor = UIColor.konstruuDarkBlue()
    messageButton.addTarget(self, action: #selector(startChatWithUser), for: UIControlEvents.touchUpInside)
    
    messageButton.translatesAutoresizingMaskIntoConstraints = false
    return messageButton
    }()
  
  private lazy var descriptionLabel : UILabel = { [unowned self] in
    let descriptionLabel = UILabel()
    descriptionLabel.textColor = UIColor.black
    descriptionLabel.text  = self.user?.desc
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
    accessibilityLabel = "infoCell"
    
    contentView.addSubview(cardView)
    contentView.addSubview(profileImageView)
    contentView.addSubview(usernameLabel)
    contentView.addSubview(educationLabel)
    contentView.addSubview(locationLabel)
    contentView.addSubview(messageButton)
    contentView.addSubview(descriptionLabel)
    
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
    
    
    //profileImageView
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:profileImageView, attribute:.top, relatedBy:.equal, toItem: contentView, attribute:.top, multiplier: 1, constant: .imageViewTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:profileImageView, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:profileImageView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:profileImageView, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewWidthConstraint))
    
    //usernameLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:usernameLabel, attribute:.top, relatedBy:.equal, toItem: profileImageView, attribute:.bottom, multiplier: 1, constant: .nameLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:usernameLabel, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:usernameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:usernameLabel, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    
    //educationLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:educationLabel, attribute:.top, relatedBy:.equal, toItem: usernameLabel, attribute:.bottom, multiplier: 1, constant: .educationLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:educationLabel, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:educationLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .educationLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:educationLabel, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    //locationLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.top, relatedBy:.equal, toItem: educationLabel, attribute:.bottom, multiplier: 1, constant: .locationLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .locationLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    //messageButton
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.top, relatedBy:.equal, toItem: locationLabel, attribute:.bottom, multiplier: 1, constant: .messageButtonTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .messageButtonHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .messageButtonWidthConstraint))
    
    
    //descriptionLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:descriptionLabel, attribute:.top, relatedBy:.equal, toItem: messageButton, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:descriptionLabel, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .descriptionLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:descriptionLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.descriptionLabelRightConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:descriptionLabel, attribute:.bottom, relatedBy:.equal, toItem: contentView, attribute:.bottom, multiplier: 1, constant: -.descriptionLabelBottomConstraint))
    
    super.updateConstraints()
  }
  
  func startChatWithUser() {
    user?.startChat(from: parentViewController)
  }
  
  
}
