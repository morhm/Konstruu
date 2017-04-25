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
  static let titleLabelHeightConstraint:CGFloat      = 20.0
  static let titleLabelLeftConstraint:CGFloat        = 15.0
  
  static let imageViewLeftConstraint: CGFloat        = 10.0
  static let imageViewTopConstraint:CGFloat          = 20.0
  static let imageViewHeightConstraint: CGFloat      = 80.0
  static let imageViewWidthConstraint: CGFloat       = 80.0
  
  static let nameLabelLeftConstraint:CGFloat          = 20.0
  static let nameLabelRightConstraint:CGFloat         = 8.0
  static let nameLabelHeightConstraint:CGFloat        = 25.0
  
  static let descriptionLabelTopConstraint:CGFloat    = 0.0
}

class ProfileProjectTableViewCell: UITableViewCell {
  
  // MARK: - Data
  
  var projectNameText:String = "Frog and Code" {
    didSet {
      firstProjectNameLabel.text = projectNameText
      secondProjectNameLabel.text = projectNameText
    }
  }
  
  var projectDescriptionText:String = "We are building an app to bring students together to work on challenges within their community" {
    didSet {
      firstProjectDescriptionLabel.text = projectDescriptionText
      secondProjectDescriptionLabel.text = projectDescriptionText
    }
  }
  
  private var updated = false
  
  // MARK: - Subviews
  
  private lazy var titleLabel : UILabel = { [unowned self] in
    let titleLabel = UILabel()
    titleLabel.textColor = UIColor.black
    titleLabel.text  = "Projects"
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
  
  private lazy var firstProjectImageView: UIImageView = { [unowned self] in
    let projectImageView = UIImageView()
    projectImageView.image = UIImage(named: "high_school.png")
    projectImageView.contentMode = .scaleAspectFill
    
    projectImageView.translatesAutoresizingMaskIntoConstraints = false
    return projectImageView
    }()
  
  private lazy var secondProjectImageView: UIImageView = { [unowned self] in
    let projectImageView = UIImageView()
    projectImageView.image = UIImage(named: "high_school.png")
    projectImageView.contentMode = .scaleAspectFill
    
    projectImageView.translatesAutoresizingMaskIntoConstraints = false
    return projectImageView
    }()
  
  private lazy var firstProjectNameLabel : UILabel = { [unowned self] in
    let nameLabel = UILabel()
    nameLabel.textColor = UIColor.black
    nameLabel.text  = self.projectNameText
    nameLabel.textAlignment = .left
    nameLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    return nameLabel
    }()
  
  private lazy var secondProjectNameLabel : UILabel = { [unowned self] in
    let nameLabel = UILabel()
    nameLabel.textColor = UIColor.black
    nameLabel.text  = self.projectNameText
    nameLabel.textAlignment = .left
    nameLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    return nameLabel
    }()
  
  private lazy var firstProjectDescriptionLabel : UILabel = { [unowned self] in
    let descriptionLabel = UILabel()
    descriptionLabel.textColor = UIColor.black
    descriptionLabel.text  = self.projectDescriptionText
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLabel
    }()
  
  private lazy var secondProjectDescriptionLabel : UILabel = { [unowned self] in
    let descriptionLabel = UILabel()
    descriptionLabel.textColor = UIColor.black
    descriptionLabel.text  = self.projectDescriptionText
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
    
    contentView.addSubview(firstProjectImageView)
    contentView.addSubview(firstProjectNameLabel)
    contentView.addSubview(firstProjectDescriptionLabel)

    contentView.addSubview(secondProjectImageView)
    contentView.addSubview(secondProjectNameLabel)
    contentView.addSubview(secondProjectDescriptionLabel)
    
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
    
    //firstProjectImageView
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectImageView, attribute:.top, relatedBy:.equal, toItem: titleLabel, attribute:.bottom, multiplier: 1, constant: .imageViewTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectImageView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .imageViewLeftConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectImageView, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewWidthConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectImageView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewHeightConstraint))
    
    
    //firstProjectNameLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectNameLabel, attribute:.left, relatedBy:.equal, toItem: firstProjectImageView, attribute:.right, multiplier: 1, constant: .nameLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectNameLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectNameLabel, attribute:.top, relatedBy:.equal, toItem: firstProjectImageView, attribute:.top, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    
    //firstProjectDescriptionLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: firstProjectNameLabel, attribute:.left, multiplier: 1, constant: 0))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: firstProjectNameLabel, attribute:.right, multiplier: 1, constant: 0))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: firstProjectNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:firstProjectDescriptionLabel, attribute:.bottom, relatedBy:.equal, toItem: firstProjectImageView, attribute:.bottom, multiplier: 1, constant: 0))
    
    //secondProjectImageView
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectImageView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .imageViewLeftConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectImageView, attribute:.top, relatedBy:.equal, toItem: firstProjectImageView, attribute:.bottom, multiplier: 1, constant: .imageViewTopConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectImageView, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewWidthConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectImageView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewHeightConstraint))
    
    
    //secondProjectNameLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectNameLabel, attribute:.left, relatedBy:.equal, toItem: secondProjectImageView, attribute:.right, multiplier: 1, constant: .nameLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectNameLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectNameLabel, attribute:.top, relatedBy:.equal, toItem: secondProjectImageView, attribute:.top, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    
    //secondProjectDescriptionLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: secondProjectNameLabel, attribute:.left, multiplier: 1, constant: 0))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: secondProjectNameLabel, attribute:.right, multiplier: 1, constant: 0))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: secondProjectNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:secondProjectDescriptionLabel, attribute:.bottom, relatedBy:.equal, toItem: secondProjectImageView, attribute:.bottom, multiplier: 1, constant: 0))
    
    super.updateConstraints()
  }
}
