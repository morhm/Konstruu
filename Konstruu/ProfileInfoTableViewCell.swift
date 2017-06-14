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
  static let marginConstant : CGFloat               = 10.0

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

class ProfileInfoTableViewCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  let defaultEducationText = "Enter your school"
  let defaultLocationText = "Enter your location"
  let defaultDescriptionText = "Tell us more about who you are"

    // MARK: - Data
  
  var user: User? {
      didSet {
          usernameLabel.text = user?.name
          usernameTextField.text = user?.name
          educationLabel.text = (user?.school ?? "").isEmpty ? defaultEducationText : user?.school!
          educationTextField.text = (user?.school ?? "").isEmpty ? defaultEducationText : user?.school!
          locationLabel.text = (user?.location ?? "").isEmpty ? defaultLocationText : user?.location!
          locationTextField.text = (user?.location ?? "").isEmpty ? defaultLocationText : user?.location!
          descriptionLabel.text = (user?.desc ?? "").isEmpty ? defaultDescriptionText : user?.desc!
          descriptionTextView.text = (user?.desc ?? "").isEmpty ? defaultDescriptionText : user?.desc!
          user?.getProfileImage(completed: { [weak self] image in
              self?.profileImage = image
          })
          messageButton.isHidden = user?.isCurrentUser() ?? false
          editButton.isHidden = !(user?.isCurrentUser() ?? false)
      }
  }
    
  var parentViewController: UIViewController!
  
//  var educationText:String? = "Senior at Phoenix High School" {
//    didSet {
//      educationLabel.text = educationText
//    }
//  }
//  
//  var locationText:String? = "Enter H" {
//    didSet {
//      locationLabel.text = locationText
//    }
//  }
  
//  var descriptionText:String? = "" {
//    didSet {
//      descriptionLabel.text = descriptionText
//    }
//  }
  
  var profileImage:UIImage? {
    didSet {
      profileImageButton.setImage(profileImage, for: .normal)
    }
  }
  
  var editingMode:Bool = false {
    didSet {
      if editingMode {
        profileImageButton.isEnabled = true
        
        usernameLabel.isHidden = true
        educationLabel.isHidden = true
        locationLabel.isHidden = true
        descriptionLabel.isHidden = true
        
        usernameTextField.isHidden = false
        educationTextField.isHidden = false
        locationTextField.isHidden = false
        descriptionTextView.isHidden = false
      } else {
        profileImageButton.isEnabled = false

        usernameLabel.isHidden = false
        educationLabel.isHidden = false
        locationLabel.isHidden = false
        descriptionLabel.isHidden = false
        
        usernameTextField.isHidden = true
        educationTextField.isHidden = true
        locationTextField.isHidden = true
        descriptionTextView.isHidden = true
      }
    }
  }
  
  private var updated = false
  
  // MARK: - Subviews
  
  let imagePicker: UIImagePickerController = UIImagePickerController()
  
  private lazy var cardView: UIView = { [unowned self] in
    let cardView = UIView()
    cardView.backgroundColor = UIColor.white
    cardView.layer.cornerRadius = 5
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
    }()
  
  private lazy var profileImageButton: UIButton = { [unowned self] in
    let profileImageButton = UIButton()
    profileImageButton.setImage(self.profileImage, for: .normal)
    profileImageButton.imageView?.contentMode = .scaleAspectFill
    profileImageButton.contentMode = .scaleAspectFill
    profileImageButton.contentHorizontalAlignment = .fill
    profileImageButton.contentVerticalAlignment = .fill
    profileImageButton.adjustsImageWhenDisabled = false
    profileImageButton.isEnabled = false
    profileImageButton.addTarget(self, action: #selector(updateImage), for: UIControlEvents.touchUpInside)

    profileImageButton.translatesAutoresizingMaskIntoConstraints = false
    return profileImageButton
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
  
  private lazy var usernameTextField : UITextField = { [unowned self] in
    let usernameTextField = UITextField()
    usernameTextField.textColor = UIColor.black
    usernameTextField.text = self.user?.name
    usernameTextField.textAlignment = .center
    usernameTextField.font = UIFont.konstruuLightFontWithSize(18.0)
    usernameTextField.delegate = self
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    return usernameTextField
    }()
  
  private lazy var educationLabel : UILabel = { [unowned self] in
    let educationLabel = UILabel()
    educationLabel.textColor = UIColor.black
    educationLabel.text  = self.defaultEducationText
    educationLabel.textAlignment = .center
    educationLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    educationLabel.translatesAutoresizingMaskIntoConstraints = false
    return educationLabel
    }()
  
  private lazy var educationTextField : UITextField = { [unowned self] in
    let educationTextField = UITextField()
    educationTextField.textColor = UIColor.black
    educationTextField.text  = self.defaultEducationText
    educationTextField.textAlignment = .center
    educationTextField.font = UIFont.konstruuLightFontWithSize(13.0)
    educationTextField.delegate = self
    
    educationTextField.translatesAutoresizingMaskIntoConstraints = false
    return educationTextField
    }()
  
  private lazy var locationLabel : UILabel = { [unowned self] in
    let locationLabel = UILabel()
    locationLabel.textColor = UIColor.black
    locationLabel.text  = self.defaultLocationText
    locationLabel.textAlignment = .center
    locationLabel.font = UIFont.konstruuLightFontWithSize(13.0)
    
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    return locationLabel
  }()
  
  private lazy var locationTextField : UITextField = { [unowned self] in
    let locationTextField = UITextField()
    locationTextField.textColor = UIColor.black
    locationTextField.text  = self.defaultLocationText
    locationTextField.textAlignment = .center
    locationTextField.font = UIFont.konstruuLightFontWithSize(13.0)
    locationTextField.delegate = self
    
    locationTextField.translatesAutoresizingMaskIntoConstraints = false
    return locationTextField
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
  
  private lazy var editButton: UIButton = { [unowned self] in
    let editButton = UIButton(type: .custom)
    editButton.setImage(#imageLiteral(resourceName: "pencil-6"), for: UIControlState())
    editButton.addTarget(self, action: #selector(toggleEditMode), for: UIControlEvents.touchUpInside)
    
    editButton.translatesAutoresizingMaskIntoConstraints = false
    return editButton
  }()
  
  private lazy var descriptionLabel : UILabel = { [unowned self] in
    let descriptionLabel = UILabel()
    descriptionLabel.textColor = UIColor.black
    descriptionLabel.text  = self.defaultDescriptionText
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont.konstruuLightFontWithSize(13.0)

    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLabel
  }()
  
  private lazy var descriptionTextView : UITextView = { [unowned self] in
    let descriptionTextView = UITextView()
    descriptionTextView.textColor = UIColor.black
    descriptionTextView.text  = self.defaultDescriptionText
    descriptionTextView.font = UIFont.konstruuLightFontWithSize(13.0)
    descriptionTextView.delegate = self
    
    descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    return descriptionTextView
  }()
  
  // MARK: - Init
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    imagePicker.delegate = self
    
    backgroundColor = UIColor.clear
    
    selectionStyle = .none
    accessibilityLabel = "infoCell"
    
    contentView.addSubview(cardView)
    contentView.addSubview(profileImageButton)
    
    contentView.addSubview(usernameLabel)
    contentView.addSubview(usernameTextField)
    
    contentView.addSubview(educationLabel)
    contentView.addSubview(educationTextField)
    
    contentView.addSubview(locationLabel)
    contentView.addSubview(locationTextField)
    
    contentView.addSubview(messageButton)
    contentView.addSubview(editButton)
    
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(descriptionTextView)
    
    usernameLabel.isHidden = false
    educationLabel.isHidden = false
    locationLabel.isHidden = false
    descriptionLabel.isHidden = false
    
    usernameTextField.isHidden = true
    educationTextField.isHidden = true
    locationTextField.isHidden = true
    descriptionTextView.isHidden = true
    
    addToolbarToKeyboard()
    
    updateConstraints()
  }
  
  private func addToolbarToKeyboard() {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    
    toolbar.setItems([flexibleSpace, doneButton], animated: false)
    
    usernameTextField.inputAccessoryView = toolbar
    educationTextField.inputAccessoryView = toolbar
    locationTextField.inputAccessoryView = toolbar
    descriptionTextView.inputAccessoryView = toolbar
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
    
    
    //profileImageButton
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:profileImageButton, attribute:.top, relatedBy:.equal, toItem: contentView, attribute:.top, multiplier: 1, constant: .imageViewTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:profileImageButton, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:profileImageButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:profileImageButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .imageViewWidthConstraint))
    
    //usernameLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:usernameLabel, attribute:.top, relatedBy:.equal, toItem: profileImageButton, attribute:.bottom, multiplier: 1, constant: .nameLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:usernameLabel, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:usernameLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:usernameLabel, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    //usernameTextField
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:usernameTextField, attribute:.top, relatedBy:.equal, toItem: profileImageButton, attribute:.bottom, multiplier: 1, constant: .nameLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:usernameTextField, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:usernameTextField, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:usernameTextField, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    //educationLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:educationLabel, attribute:.top, relatedBy:.equal, toItem: usernameLabel, attribute:.bottom, multiplier: 1, constant: .educationLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:educationLabel, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:educationLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .educationLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:educationLabel, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    //educationTextField
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:educationTextField, attribute:.top, relatedBy:.equal, toItem: usernameLabel, attribute:.bottom, multiplier: 1, constant: .educationLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:educationTextField, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:educationTextField, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .educationLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:educationTextField, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    //locationLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.top, relatedBy:.equal, toItem: educationLabel, attribute:.bottom, multiplier: 1, constant: .locationLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .locationLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:locationLabel, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    //locationTextField
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:locationTextField, attribute:.top, relatedBy:.equal, toItem: educationLabel, attribute:.bottom, multiplier: 1, constant: .locationLabelTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:locationTextField, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:locationTextField, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .locationLabelHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:locationTextField, attribute:.width, relatedBy:.equal, toItem: contentView, attribute:.width, multiplier: 1, constant: 0))
    
    //messageButton
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.top, relatedBy:.equal, toItem: locationLabel, attribute:.bottom, multiplier: 1, constant: .messageButtonTopConstraint))
    //centerX
    contentView.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.centerX, relatedBy:.equal, toItem: contentView, attribute:.centerX, multiplier: 1, constant: 0))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .messageButtonHeightConstraint))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:messageButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .messageButtonWidthConstraint))
    
//    //editButton

    //top
    contentView.addConstraint(NSLayoutConstraint(item:editButton, attribute:.top, relatedBy:.equal, toItem: cardView, attribute:.top, multiplier: 1, constant: 8))
    // right
    contentView.addConstraint(NSLayoutConstraint(item:editButton, attribute: .right, relatedBy:.equal, toItem: cardView, attribute:.right, multiplier: 1, constant: -8))
    //height
    contentView.addConstraint(NSLayoutConstraint(item:editButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 35))
    //width
    contentView.addConstraint(NSLayoutConstraint(item:editButton, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 55))
    
    //descriptionLabel
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:descriptionLabel, attribute:.top, relatedBy:.equal, toItem: messageButton, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:descriptionLabel, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .descriptionLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:descriptionLabel, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.descriptionLabelRightConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:descriptionLabel, attribute:.bottom, relatedBy:.equal, toItem: contentView, attribute:.bottom, multiplier: 1, constant: -.descriptionLabelBottomConstraint))
    
    //descriptionTextView
    
    //top
    contentView.addConstraint(NSLayoutConstraint(item:descriptionTextView, attribute:.top, relatedBy:.equal, toItem: messageButton, attribute:.bottom, multiplier: 1, constant: .descriptionLabelTopConstraint))
    //left
    contentView.addConstraint(NSLayoutConstraint(item:descriptionTextView, attribute:.left, relatedBy:.equal, toItem: contentView, attribute:.left, multiplier: 1, constant: .descriptionLabelLeftConstraint))
    //right
    contentView.addConstraint(NSLayoutConstraint(item:descriptionTextView, attribute:.right, relatedBy:.equal, toItem: contentView, attribute:.right, multiplier: 1, constant: -.descriptionLabelRightConstraint))
    //bottom
    contentView.addConstraint(NSLayoutConstraint(item:descriptionTextView, attribute:.bottom, relatedBy:.equal, toItem: contentView, attribute:.bottom, multiplier: 1, constant: -.descriptionLabelBottomConstraint))
    
    super.updateConstraints()
  }
  
  // MARK: - Actions
  
  func startChatWithUser() {
    user?.startChat(from: parentViewController)
  }
  
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
    user?.updateName(to: usernameTextField.text!)
    user?.updateSchool(to: educationTextField.text!)
    user?.updateLocation(to: locationTextField.text!)
    user?.updateDescription(to: descriptionTextView.text)
    
    usernameLabel.text = usernameTextField.text!
    educationLabel.text = educationTextField.text!
    locationLabel.text = locationTextField.text!
    descriptionLabel.text = descriptionTextView.text
    
    contentView.endEditing(true)
  }
  
  func updateImage() {
    if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
      imagePicker.sourceType = .savedPhotosAlbum
      imagePicker.allowsEditing = false
      
      parentViewController.present(imagePicker, animated: true, completion: nil)
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      //profileImage = pickedImage
      user?.imageUploadTask = user?.updateProfileImage(to: pickedImage.jpeg!, completed: nil)
      profileImage = pickedImage
    }
    parentViewController.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    parentViewController.dismiss(animated:true, completion: nil)
  }
  
  // MARK: - Delegates
  
//  func textViewDidBeginEditing(_ textView: UITextView) {
//    if textView.isEqual(challengeNameTextField) {
//      if challengeNameTextField.textColor == placeholderColor {
//        challengeNameTextField.text = ""
//        challengeNameTextField.textColor = UIColor.black
//        return
//      }
//    }
//    
//    if textView.isEqual(challengeDescriptionTextView) {
//      if challengeDescriptionTextView.textColor == placeholderColor {
//        challengeDescriptionTextView.text = ""
//        challengeDescriptionTextView.textColor = UIColor.black
//      }
//    }
//  }
//  
//  func textViewDidEndEditing(_ textView: UITextView) {
//    if textView.isEqual(challengeNameTextField) {
//      if challengeNameTextField.text.isEmpty {
//        challengeNameTextField.text = namePlaceholderText
//        challengeNameTextField.textColor = placeholderColor
//        return
//      }
//    }
//    
//    if textView.isEqual(challengeDescriptionTextView) {
//      if challengeDescriptionTextView.text.isEmpty {
//        challengeDescriptionTextView.text = descriptionPlaceholderText
//        challengeDescriptionTextView.textColor = placeholderColor
//      }
//    }
//  }
  
  
}
