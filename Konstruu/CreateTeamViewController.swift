//
//  CreateTeamViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit


private extension CGFloat {
    static let marginConstraint:CGFloat = 8.0
    static let nameTextFieldHeightConstraint:CGFloat = 35.0
    static let descriptionTextViewHeightConstraint:CGFloat = 250.0
    static let addPhotoHeightConstraint:CGFloat = 30.0
}

class CreateTeamViewController: UIViewController, UITextViewDelegate {
  
    // MARK: - Data
  
    var user: User? {
      didSet {
        
      }
    }
  
    var challenge: Challenge? {
      didSet {
//        updateUI()
//        teamsTableView?.reloadData()
      }
    }
  
  
    // MARK: - Constants
  
    private let namePlaceholderText = "What is your team name?"
    
    private let descriptionPlaceholderText = "Describe your team's mission and how they will solve the challenge"
    
    static let openTeamLabelText = "Is this team open to other users?"
    
    private let placeholderColor = UIColor.gray
  
    // MARK: - UI
  
    private lazy var teamNameTextField: UITextView = { [unowned self] in
      let teamNameTextField = UITextView()
      teamNameTextField.text = self.namePlaceholderText
      teamNameTextField.textColor =  self.placeholderColor
      teamNameTextField.backgroundColor = UIColor.white
      teamNameTextField.delegate = self
      teamNameTextField.textAlignment = .left
      teamNameTextField.font = UIFont.konstruuFontWithSize(14.0)
      teamNameTextField.autocorrectionType = UITextAutocorrectionType.yes
      teamNameTextField.autocapitalizationType = UITextAutocapitalizationType.words
      
      teamNameTextField.translatesAutoresizingMaskIntoConstraints = false
      return teamNameTextField
      } ()
  
  
    private lazy var teamDescriptionTextView: UITextView = { [unowned self] in
        let teamDescriptionTextView = UITextView()
        teamDescriptionTextView.text = self.descriptionPlaceholderText
        teamDescriptionTextView.textColor =  self.placeholderColor
        teamDescriptionTextView.backgroundColor = UIColor.white
        //      challengeDescriptionTextView.alpha = 0.5
        teamDescriptionTextView.delegate = self
        teamDescriptionTextView.textAlignment = .left
        teamDescriptionTextView.font = UIFont.konstruuFontWithSize(14.0)
        teamDescriptionTextView.autocorrectionType = UITextAutocorrectionType.no
        teamDescriptionTextView.autocapitalizationType = UITextAutocapitalizationType.none
        
        teamDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        return teamDescriptionTextView
        } ()
    
    private lazy var openTeamToggle: UISwitch = { [unowned self] in
        let openTeamToggle = UISwitch()
        openTeamToggle.isOn = true
        openTeamToggle.translatesAutoresizingMaskIntoConstraints = false
        return openTeamToggle
    }()
    
    private lazy var openTeamLabel: UILabel = { [unowned self] in
        let openTeamLabel = UILabel()
        openTeamLabel.text = openTeamLabelText
        openTeamLabel.textColor =  UIColor.black
        openTeamLabel.textAlignment = .left
        openTeamLabel.numberOfLines = 1
        
        openTeamLabel.font = UIFont.konstruuFontWithSize(14.0)
        openTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        return openTeamLabel
        } ()
    
    
    private lazy var addPhotoButton: ChallengeButton = { [unowned self] in
        let addPhotoButton = ChallengeButton(challengeButtonType: ChallengeButtonType.media)
        addPhotoButton.backgroundColor = UIColor.white
        addPhotoButton.addTarget(self, action: #selector(addPhoto), for: UIControlEvents.touchUpInside)
        
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        return addPhotoButton
        }()

    // Tutorial: https://www.youtube.com/watch?v=RuzHai2RVZU
    private func addToolbarToKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        teamDescriptionTextView.inputAccessoryView = toolbar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Team"
        self.edgesForExtendedLayout = []
        
        view.backgroundColor = UIColor.konstruuLightGray()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createTeam))
        
        addToolbarToKeyboard()
        
        addSubviews()
        addConstraints()

    }
    
    func addSubviews() {
        view.addSubview(teamNameTextField)
        view.addSubview(teamDescriptionTextView)
        view.addSubview(openTeamToggle)
        view.addSubview(openTeamLabel)
        view.addSubview(addPhotoButton)
    }
    
    func addConstraints() {
      
        //teamNameTextField
      
        //top
        view.addConstraint(NSLayoutConstraint(item:teamNameTextField, attribute:.top, relatedBy:.equal, toItem: view, attribute:.top, multiplier: 1, constant: .marginConstraint))
        //left
        view.addConstraint(NSLayoutConstraint(item:teamNameTextField, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:teamNameTextField, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:teamNameTextField, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameTextFieldHeightConstraint))
        
      
        //teamDescriptionTextView
        
        //top
        view.addConstraint(NSLayoutConstraint(item:teamDescriptionTextView, attribute:.top, relatedBy:.equal, toItem: teamNameTextField, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //left
        view.addConstraint(NSLayoutConstraint(item:teamDescriptionTextView, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:teamDescriptionTextView, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:teamDescriptionTextView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .descriptionTextViewHeightConstraint))
        
        //addPhotoButton
        
        //top
        view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.top, relatedBy:.equal, toItem: teamDescriptionTextView, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //left
        view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //right
        view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .addPhotoHeightConstraint))
        
        //openTeamToggle
        
        //top
        view.addConstraint(NSLayoutConstraint(item:openTeamToggle, attribute:.top, relatedBy:.equal, toItem: addPhotoButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        
        //right
        view.addConstraint(NSLayoutConstraint(item:openTeamToggle, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
        
        //height
        view.addConstraint(NSLayoutConstraint(item:openTeamToggle, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 31))
        
        //width
        view.addConstraint(NSLayoutConstraint(item:openTeamToggle, attribute:.width, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: 49))
        
        //right
        //view.addConstraint(NSLayoutConstraint(item:openTeamToggle, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: .marginConstraint))
        //height
        //        view.addConstraint(NSLayoutConstraint(item:openTeamToggle, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .addPhotoHeightConstraint))
        
        //openTeamLabel
        
        //top
        view.addConstraint(NSLayoutConstraint(item:openTeamLabel, attribute:.top, relatedBy:.equal, toItem: addPhotoButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
        //left
        view.addConstraint(NSLayoutConstraint(item:openTeamLabel, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
        //height
        view.addConstraint(NSLayoutConstraint(item:openTeamLabel, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .addPhotoHeightConstraint))

    }
    
    // MARK: - Actions
    
    func addPhoto() {
        
    }
    
    func createTeam() {
      //TODO: add description information for the team!
      
      var nameText = teamNameTextField.text
      var descText = teamDescriptionTextView.text
      if (teamNameTextField.textColor == placeholderColor) {
        nameText = ""
      }
      if (teamDescriptionTextView.textColor == placeholderColor) {
        descText = ""
      }
      
      let teamInfo: Dictionary<String, AnyObject> = ["name": nameText as AnyObject, "open": openTeamToggle.isOn as AnyObject, "challengeKey": challenge!.key as AnyObject]
      let team = API.createTeam(teamInfo: teamInfo)
      team.addUser(user!)
      
      self.navigationController?.popViewController(animated: true)
    }
    
    func doneClicked() {
        view.endEditing(true)
    }
    
    // MARK: - Delegates
  
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.isEqual(teamNameTextField) {
          if teamNameTextField.textColor == placeholderColor {
            teamNameTextField.text = ""
            teamNameTextField.textColor = UIColor.black
          }
        }
        if textView.isEqual(teamDescriptionTextView) {
          if teamDescriptionTextView.textColor == placeholderColor {
              teamDescriptionTextView.text = ""
              teamDescriptionTextView.textColor = UIColor.black
          }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.isEqual(teamNameTextField) {
          if teamNameTextField.text.isEmpty {
            teamNameTextField.text = namePlaceholderText
            teamNameTextField.textColor = placeholderColor
          }
        }
        if textView.isEqual(teamDescriptionTextView) {
          if teamDescriptionTextView.text.isEmpty {
              teamDescriptionTextView.text = descriptionPlaceholderText
              teamDescriptionTextView.textColor = placeholderColor
          }
        }
    }
}
