//
//  ProfileSpecialityTableViewCell.swift
//  Konstruu
//
//  Created by David Xue on 4/24/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

private extension CGFloat {
  static let cardViewTopConstraint:CGFloat          = 10.0

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

class ProfileSpecialtyTableViewCell: UITableViewCell {
  
  // MARK: - Data
  
  var specialtyNameText:String = "Javascript" {
    didSet {
      firstSpecialtyNameLabel.text = specialtyNameText
      secondSpecialtyNameLabel.text = specialtyNameText
      thirdSpecialtyNameLabel.text = specialtyNameText
    }
  }
  
  var specialtyDescriptionText:String = "I am in my school’s web development club and I am good at Javascript" {
    didSet {
      firstSpecialtyDescriptionLabel.text = specialtyDescriptionText
      secondSpecialtyDescriptionLabel.text = specialtyDescriptionText
      thirdSpecialtyDescriptionLabel.text = specialtyDescriptionText
    }
  }
  
  private var updated = false
  
  // MARK: - Subviews
  
  private lazy var titleLabel : UILabel = { [unowned self] in
    let titleLabel = UILabel()
    titleLabel.textColor = UIColor.black
    titleLabel.text  = "Specialties"
    titleLabel.textAlignment = .left
    titleLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
    }()
  
  private  lazy var cardView: UIView = { [unowned self] in
    let cardView = UIView()
    cardView.backgroundColor = UIColor.white
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
    }()
  
  private lazy var firstSpecialtyImageView: UIImageView = { [unowned self] in
    let specialtyImageView = UIImageView()
    specialtyImageView.image = UIImage(named: "shield.png")
    specialtyImageView.contentMode = .scaleAspectFill
    
    specialtyImageView.translatesAutoresizingMaskIntoConstraints = false
    return specialtyImageView
    }()
  
  private lazy var secondSpecialtyImageView: UIImageView = { [unowned self] in
    let specialtyImageView = UIImageView()
    specialtyImageView.image = UIImage(named: "shield.png")
    specialtyImageView.contentMode = .scaleAspectFill
    
    specialtyImageView.translatesAutoresizingMaskIntoConstraints = false
    return specialtyImageView
    }()
  
  private lazy var thirdSpecialtyImageView: UIImageView = { [unowned self] in
    let specialtyImageView = UIImageView()
    specialtyImageView.image = UIImage(named: "shield.png")
    specialtyImageView.contentMode = .scaleAspectFill
    
    specialtyImageView.translatesAutoresizingMaskIntoConstraints = false
    return specialtyImageView
    }()
  
  private lazy var firstSpecialtyNameLabel : UILabel = { [unowned self] in
    let specialtyLabel = UILabel()
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.specialtyNameText
    specialtyLabel.textAlignment = .left
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  private lazy var secondSpecialtyNameLabel : UILabel = { [unowned self] in
    let specialtyLabel = UILabel()
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.specialtyNameText
    specialtyLabel.textAlignment = .left
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  private lazy var thirdSpecialtyNameLabel : UILabel = { [unowned self] in
    let specialtyLabel = UILabel()
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.specialtyNameText
    specialtyLabel.textAlignment = .left
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  private lazy var firstSpecialtyDescriptionLabel : UILabel = { [unowned self] in
    let specialtyLabel = UILabel()
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.specialtyDescriptionText
    specialtyLabel.textAlignment = .left
    specialtyLabel.numberOfLines = 0
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  private lazy var secondSpecialtyDescriptionLabel : UILabel = { [unowned self] in
    let specialtyLabel = UILabel()
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.specialtyDescriptionText
    specialtyLabel.textAlignment = .left
    specialtyLabel.numberOfLines = 0
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  private lazy var thirdSpecialtyDescriptionLabel : UILabel = { [unowned self] in
    let specialtyLabel = UILabel()
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.specialtyDescriptionText
    specialtyLabel.textAlignment = .left
    specialtyLabel.numberOfLines = 0
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  // MARK: - Init
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = UIColor.clear
    
    selectionStyle = .none
    accessibilityLabel = "specialtyCell"
    
    contentView.addSubview(cardView)
    
    contentView.addSubview(titleLabel)
    
    contentView.addSubview(firstSpecialtyImageView)
    contentView.addSubview(secondSpecialtyImageView)
    contentView.addSubview(thirdSpecialtyImageView)
    
    contentView.addSubview(firstSpecialtyNameLabel)
    contentView.addSubview(secondSpecialtyNameLabel)
    contentView.addSubview(thirdSpecialtyNameLabel)
    
    contentView.addSubview(firstSpecialtyDescriptionLabel)
    contentView.addSubview(secondSpecialtyDescriptionLabel)
    contentView.addSubview(thirdSpecialtyDescriptionLabel)
    
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
    
    
    //firstSpecialtyImageView
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyImageView, attribute:.top, relatedBy:.equal, toItem: titleLabel, attribute:.bottom, multiplier: 1, constant: .imageViewTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyImageView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .imageViewLeftConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyImageView, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewWidthConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyImageView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewHeightConstraint))
    
    
    //firstSpecialtyNameLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyNameLabel, attribute:.left, relatedBy:.equal, toItem: firstSpecialtyImageView, attribute:.right, multiplier: 1, constant: .nameLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyNameLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyNameLabel, attribute:.top, relatedBy:.equal, toItem: firstSpecialtyImageView, attribute:.top, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    
    //firstSpecialtyDescriptionLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: firstSpecialtyNameLabel, attribute:.left, multiplier: 1, constant: 0))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: firstSpecialtyNameLabel, attribute:.right, multiplier: 1, constant: 0))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: firstSpecialtyNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyDescriptionLabel, attribute:.bottom, relatedBy:.equal, toItem: firstSpecialtyImageView, attribute:.bottom, multiplier: 1, constant: 0))
    
    //secondSpecialtyImageView
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyImageView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .imageViewLeftConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyImageView, attribute:.top, relatedBy:.equal, toItem: firstSpecialtyImageView, attribute:.bottom, multiplier: 1, constant: .imageViewTopConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyImageView, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewWidthConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyImageView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewHeightConstraint))
    
    
    //secondSpecialtyNameLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyNameLabel, attribute:.left, relatedBy:.equal, toItem: secondSpecialtyImageView, attribute:.right, multiplier: 1, constant: .nameLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyNameLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyNameLabel, attribute:.top, relatedBy:.equal, toItem: secondSpecialtyImageView, attribute:.top, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    
    //secondSpecialtyDescriptionLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: secondSpecialtyNameLabel, attribute:.left, multiplier: 1, constant: 0))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: secondSpecialtyNameLabel, attribute:.right, multiplier: 1, constant: 0))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: secondSpecialtyNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyDescriptionLabel, attribute:.bottom, relatedBy:.equal, toItem: secondSpecialtyImageView, attribute:.bottom, multiplier: 1, constant: 0))
    
    //thirdSpecialtyImageView
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyImageView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .imageViewLeftConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyImageView, attribute:.top, relatedBy:.equal, toItem: secondSpecialtyImageView, attribute:. bottom, multiplier: 1, constant: .imageViewTopConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyImageView, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewWidthConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyImageView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewHeightConstraint))
    
    //thirdSpecialtyNameLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyNameLabel, attribute:.left, relatedBy:.equal, toItem: thirdSpecialtyImageView, attribute:.right, multiplier: 1, constant: .nameLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyNameLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyNameLabel, attribute:.top, relatedBy:.equal, toItem: thirdSpecialtyImageView, attribute:.top, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    
    //thirdSpecialtyDescriptionLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: thirdSpecialtyNameLabel, attribute:.left, multiplier: 1, constant: 0))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: thirdSpecialtyNameLabel, attribute:.right, multiplier: 1, constant: 0))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: thirdSpecialtyNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyDescriptionLabel, attribute:.bottom, relatedBy:.equal, toItem: thirdSpecialtyImageView, attribute:.bottom, multiplier: 1, constant: 0))
    
    super.updateConstraints()
  }
}

