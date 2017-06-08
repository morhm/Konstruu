//
//  ProfileSpecialityTableViewCell.swift
//  Konstruu
//
//  Created by David Xue on 4/24/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

private extension CGFloat {
    
  static let marginConstant:CGFloat               = 10.0
  static let cardViewTopConstraint:CGFloat          = 10.0

  static let titleLabelTopConstraint:CGFloat         = 10.0
  static let titleLabelHeightConstraint:CGFloat      = 30.0
  static let titleLabelLeftConstraint:CGFloat        = 15.0
  
//  static let imageViewTopConstraint:CGFloat          = 20.0
//  static let imageViewLeftConstraint: CGFloat        = 10.0
//  static let imageViewHeightConstraint: CGFloat      = 80.0
//  static let imageViewWidthConstraint: CGFloat       = 80.0
  
  static let editButtonTopConstraint:CGFloat         = 8.0
  static let editButtonRightConstraint:CGFloat       = 8.0
  static let editButtonHeightConstraint:CGFloat      = 35.0
  static let editButtonWidthConstraint:CGFloat       = 55.0
  
  static let nameLabelTopConstraint:CGFloat           = 8.0
  static let nameLabelLeftConstraint:CGFloat          = 20.0
  static let nameLabelRightConstraint:CGFloat         = 8.0
  static let nameLabelHeightConstraint:CGFloat        = 25.0
  
  static let descriptionLabelTopConstraint:CGFloat    = 0.0
  static let descriptionLabelHeightConstraint:CGFloat = 55.0
}

class ProfileSpecialtyTableViewCell: UITableViewCell, UITextFieldDelegate {
  
  // MARK: - Data
  
  var user: User? {
    didSet {
      skills = user?.skills
      editButton.isHidden = !(user?.isCurrentUser() ?? false)
    }
  }
  
  var skills: [String]? = ["None", "None", "None"] {
    didSet {
      if skills?.count == 3 {
        firstSpecialtyNameLabel.text = skills?[0] ?? "None"
        secondSpecialtyNameLabel.text = skills?[1] ?? "None"
        thirdSpecialtyNameLabel.text = skills?[2] ?? "None"
      }
    }
  }
  
  private var updated = false
  
  // MARK: - Subviews
  
  private lazy var titleLabel : UILabel = { [unowned self] in
    let titleLabel = UILabel()
    titleLabel.textColor = UIColor.black
    titleLabel.text  = "Specialties"
    titleLabel.font = UIFont.konstruuSemiboldFontWithSize(18.0)
    titleLabel.textAlignment = .left
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
    }()
  
  private  lazy var cardView: UIView = { [unowned self] in
    let cardView = UIView()
    cardView.backgroundColor = UIColor.white
    cardView.layer.cornerRadius = 5.0
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
    }()
  
  private lazy var editButton: UIButton = { [unowned self] in
    let editButton = UIButton(type: .custom)
    editButton.setImage(#imageLiteral(resourceName: "pencil-6"), for: UIControlState())
    editButton.addTarget(self, action: #selector(toggleEditMode), for: UIControlEvents.touchUpInside)
        
    editButton.translatesAutoresizingMaskIntoConstraints = false
    return editButton
  }()
    
  private lazy var firstSpecialtyNameLabel : UITextField = { [unowned self] in
    let specialtyLabel = UITextField()
    specialtyLabel.isUserInteractionEnabled = false
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.skills?[0] ?? ""
    specialtyLabel.textAlignment = .left
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  private lazy var secondSpecialtyNameLabel : UITextField = { [unowned self] in
    let specialtyLabel = UITextField()
    specialtyLabel.isUserInteractionEnabled = false
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.skills?[1] ?? ""
    specialtyLabel.textAlignment = .left
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  private lazy var thirdSpecialtyNameLabel : UITextField = { [unowned self] in
    let specialtyLabel = UITextField()
    specialtyLabel.isUserInteractionEnabled = false
    specialtyLabel.textColor = UIColor.black
    specialtyLabel.text  = self.skills?[2] ?? ""
    specialtyLabel.textAlignment = .left
    specialtyLabel.font = UIFont.konstruuLightFontWithSize(18.0)
    
    specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
    return specialtyLabel
    }()
  
  var editingMode:Bool = false {
    didSet {
      if editingMode {
        firstSpecialtyNameLabel.isUserInteractionEnabled = true
        secondSpecialtyNameLabel.isUserInteractionEnabled = true
        thirdSpecialtyNameLabel.isUserInteractionEnabled = true
        
//        usernameTextField.isHidden = false
      } else {
        firstSpecialtyNameLabel.isUserInteractionEnabled = false
        secondSpecialtyNameLabel.isUserInteractionEnabled = false
        thirdSpecialtyNameLabel.isUserInteractionEnabled = false
        
//        usernameTextField.isHidden = true
      }
    }
  }
  
  // MARK: - Init
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = UIColor.clear
    
    selectionStyle = .none
    accessibilityLabel = "specialtyCell"
    
    contentView.addSubview(cardView)
    
    cardView.addSubview(titleLabel)
    cardView.addSubview(editButton)
    
    cardView.addSubview(firstSpecialtyNameLabel)
    cardView.addSubview(secondSpecialtyNameLabel)
    cardView.addSubview(thirdSpecialtyNameLabel)
    
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
    contentView.addConstraint(NSLayoutConstraint(item:cardView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .marginConstant))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:cardView, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.marginConstant))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:cardView, attribute:.bottom, relatedBy:.equal, toItem: contentView, attribute:.bottom, multiplier: 1, constant: 0))
    
    //titleLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:titleLabel, attribute:.top, relatedBy:.equal, toItem: cardView, attribute:.top, multiplier: 1, constant: .titleLabelTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:titleLabel, attribute:.left, relatedBy:.equal, toItem: cardView, attribute:.left, multiplier: 1, constant: .titleLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:titleLabel, attribute:.right, relatedBy:.equal, toItem: cardView, attribute:.right, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:titleLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .titleLabelHeightConstraint))
    
    //editButton
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:editButton, attribute:.top, relatedBy:.equal, toItem: cardView, attribute:.top, multiplier: 1, constant: .editButtonTopConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:editButton, attribute:.right, relatedBy:.equal, toItem: cardView, attribute:.right, multiplier: 1, constant: -.editButtonRightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:editButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .editButtonWidthConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:editButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .editButtonHeightConstraint))
    
    //firstSpecialtyNameLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyNameLabel, attribute:.left, relatedBy:.equal, toItem: cardView, attribute:.left, multiplier: 1, constant: .nameLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyNameLabel, attribute:.right, relatedBy:.equal, toItem: cardView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyNameLabel, attribute:.top, relatedBy:.equal, toItem: titleLabel, attribute:.bottom, multiplier: 1, constant: .nameLabelTopConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    
    //firstSpecialtyDescriptionLabel
    
//    //left
//    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: firstSpecialtyNameLabel, attribute:.left, multiplier: 1, constant: 0))
//    //right
//    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: firstSpecialtyNameLabel, attribute:.right, multiplier: 1, constant: 0))
//    //top
//    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: firstSpecialtyNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
//    //height
//    contentView.addConstraint(NSLayoutConstraint(item:firstSpecialtyDescriptionLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .descriptionLabelHeightConstraint))

    //secondSpecialtyNameLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyNameLabel, attribute:.left, relatedBy:.equal, toItem: cardView, attribute:.left, multiplier: 1, constant: .nameLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyNameLabel, attribute:.right, relatedBy:.equal, toItem: cardView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyNameLabel, attribute:.top, relatedBy:.equal, toItem: firstSpecialtyNameLabel, attribute:.bottom, multiplier: 1, constant: .nameLabelTopConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    
    //secondSpecialtyDescriptionLabel
    
//    //left
//    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: secondSpecialtyNameLabel, attribute:.left, multiplier: 1, constant: 0))
//    //right
//    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: secondSpecialtyNameLabel, attribute:.right, multiplier: 1, constant: 0))
//    //top
//    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: secondSpecialtyNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
//    //height
//    contentView.addConstraint(NSLayoutConstraint(item:secondSpecialtyDescriptionLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .descriptionLabelHeightConstraint))
    
    //thirdSpecialtyNameLabel
    
    //left
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyNameLabel, attribute:.left, relatedBy:.equal, toItem: cardView, attribute:.left, multiplier: 1, constant: .nameLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyNameLabel, attribute:.right, relatedBy:.equal, toItem: cardView, attribute:.right, multiplier: 1, constant: -.nameLabelRightConstraint))
    //top
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyNameLabel, attribute:.top, relatedBy:.equal, toItem: secondSpecialtyNameLabel, attribute:.bottom, multiplier: 1, constant: .nameLabelTopConstraint))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyNameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    
    //thirdSpecialtyDescriptionLabel
    
//    //left
//    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyDescriptionLabel, attribute:.left, relatedBy:.equal, toItem: thirdSpecialtyNameLabel, attribute:.left, multiplier: 1, constant: 0))
//    //right
//    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyDescriptionLabel, attribute:.right, relatedBy:.equal, toItem: thirdSpecialtyNameLabel, attribute:.right, multiplier: 1, constant: 0))
//    //top
//    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyDescriptionLabel, attribute:.top, relatedBy:.equal, toItem: thirdSpecialtyNameLabel, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
//    //height
//    contentView.addConstraint(NSLayoutConstraint(item:thirdSpecialtyDescriptionLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .descriptionLabelHeightConstraint))
    
    super.updateConstraints()
  }
  
  //func textViewDidBeginEditing(_ textView: UITextView) {
    
  //}
  
  // MARK: - Actions
  
  func toggleEditMode() {
    if editingMode {
      editingMode = false
      editButton.setImage(#imageLiteral(resourceName: "pencil-6"), for: UIControlState())
    } else {
      editingMode = true
      editButton.setImage(nil, for: UIControlState())
      editButton.setTitle("Save", for: UIControlState())
      editButton.setTitleColor(UIColor.konstruuYellow(), for: UIControlState())
    }
    doneClicked()
  }
  
  func doneClicked() {
    user?.updateSkill(at: 0, to: firstSpecialtyNameLabel.text!)
    user?.updateSkill(at: 1, to: secondSpecialtyNameLabel.text!)
    user?.updateSkill(at: 2, to: thirdSpecialtyNameLabel.text!)
    
    contentView.endEditing(true)
  }
}

