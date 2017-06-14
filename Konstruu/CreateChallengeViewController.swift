//
//  CreateChallengeViewController.swift
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
  static let addLocationHeightConstraint:CGFloat = 30.0
  static let tagFriendsHeightConstraint:CGFloat = 30.0
}


class CreateChallengeViewController: UIViewController, UITextViewDelegate {
  
    // MARK: - Constants
  
    private let namePlaceholderText = "What needs to be solved?"
    private let descriptionPlaceholderText = "Enter challenge description here"
    
    private let placeholderColor = UIColor.gray
  
  
    // MARK: - UI
    
//    @IBOutlet weak var challengeNameTextField: UITextField!
    
    private lazy var backgroundView: UIImageView = { [unowned self] in
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "profileGradient.png")
        backgroundView.contentMode = UIViewContentMode.scaleAspectFill
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
  
    private lazy var challengeNameTextField: UITextView = { [unowned self] in
      let challengeNameTextField = UITextView()
      challengeNameTextField.text = self.namePlaceholderText
      challengeNameTextField.textColor =  self.placeholderColor
      challengeNameTextField.backgroundColor = UIColor.white
//      challengeNameTextField.alpha = 0.5
      challengeNameTextField.delegate = self
      challengeNameTextField.textAlignment = .left
      challengeNameTextField.font = UIFont.konstruuFontWithSize(14.0)
      challengeNameTextField.autocorrectionType = UITextAutocorrectionType.no
      challengeNameTextField.autocapitalizationType = UITextAutocapitalizationType.none
      
      challengeNameTextField.translatesAutoresizingMaskIntoConstraints = false
      return challengeNameTextField
      } ()
  
  
    private lazy var challengeDescriptionTextView: UITextView = { [unowned self] in
      let challengeDescriptionTextView = UITextView()
      challengeDescriptionTextView.text = self.descriptionPlaceholderText
      challengeDescriptionTextView.textColor =  self.placeholderColor
      challengeDescriptionTextView.backgroundColor = UIColor.white
//      challengeDescriptionTextView.alpha = 0.5
      challengeDescriptionTextView.delegate = self
      challengeDescriptionTextView.textAlignment = .left
      challengeDescriptionTextView.font = UIFont.konstruuFontWithSize(14.0)
      challengeDescriptionTextView.autocorrectionType = UITextAutocorrectionType.no
      challengeDescriptionTextView.autocapitalizationType = UITextAutocapitalizationType.none
      
      challengeDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
      return challengeDescriptionTextView
      } ()
  
//    @IBOutlet weak var challengeDescriptionTextView: UITextView! {
//        didSet {
//            challengeDescriptionTextView.delegate = self
//            
//            // Set placeholder text
//            challengeDescriptionTextView.text = placeholderText
//            challengeDescriptionTextView.textColor = placeholderColor
//        }
//    }
  
    private lazy var addPhotoButton: ChallengeButton = { [unowned self] in
      let addPhotoButton = ChallengeButton(challengeButtonType: ChallengeButtonType.media)
      addPhotoButton.backgroundColor = UIColor.white
      addPhotoButton.addTarget(self, action: #selector(addPhoto), for: UIControlEvents.touchUpInside)
      
      addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
      return addPhotoButton
      }()
  
    private lazy var addLocationButton: ChallengeButton = { [unowned self] in
      let addLocationButton = ChallengeButton(challengeButtonType: ChallengeButtonType.location)
      addLocationButton.backgroundColor = UIColor.white
      addLocationButton.addTarget(self, action: #selector(addLocation), for: UIControlEvents.touchUpInside)
      
      addLocationButton.translatesAutoresizingMaskIntoConstraints = false
      return addLocationButton
      }()
    
    private lazy var tagFriendsButton: ChallengeButton = { [unowned self] in
      let tagFriendsButton = ChallengeButton(challengeButtonType: ChallengeButtonType.friends)
      tagFriendsButton.backgroundColor = UIColor.white
      tagFriendsButton.addTarget(self, action: #selector(tagFriends), for: UIControlEvents.touchUpInside)
      
      tagFriendsButton.translatesAutoresizingMaskIntoConstraints = false
      return tagFriendsButton
      }()
  
    // Tutorial: https://www.youtube.com/watch?v=RuzHai2RVZU
    private func addToolbarToKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        challengeNameTextField.inputAccessoryView = toolbar
        challengeDescriptionTextView.inputAccessoryView = toolbar
    }
  
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      self.title = "Create a Challenge"
      self.edgesForExtendedLayout = []
      
      view.backgroundColor = UIColor.konstruuLightGray()
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postChallenge))
      
      addToolbarToKeyboard()
      
      addSubviews()
      addConstraints()
    }
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
    }
  
    // MARK: - Layout
  
    func addSubviews() {
      view.addSubview(backgroundView)
        view.sendSubview(toBack: backgroundView)
      view.addSubview(challengeNameTextField)
      view.addSubview(challengeDescriptionTextView)
      //view.addSubview(addPhotoButton)
      //view.addSubview(addLocationButton)
      //view.addSubview(tagFriendsButton)
    }
  
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
        
      //challengeNameTextField
      
      //top
      view.addConstraint(NSLayoutConstraint(item:challengeNameTextField, attribute:.top, relatedBy:.equal, toItem: view, attribute:.top, multiplier: 1, constant: .marginConstraint))
      //left
      view.addConstraint(NSLayoutConstraint(item:challengeNameTextField, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
      //right
      view.addConstraint(NSLayoutConstraint(item:challengeNameTextField, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
      //height
      view.addConstraint(NSLayoutConstraint(item:challengeNameTextField, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameTextFieldHeightConstraint))
      
      //challengeDescriptionTextView
      
      //top
      view.addConstraint(NSLayoutConstraint(item:challengeDescriptionTextView, attribute:.top, relatedBy:.equal, toItem: challengeNameTextField, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
      //left
      view.addConstraint(NSLayoutConstraint(item:challengeDescriptionTextView, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
      //right
      view.addConstraint(NSLayoutConstraint(item:challengeDescriptionTextView, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
      //height
      view.addConstraint(NSLayoutConstraint(item:challengeDescriptionTextView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .descriptionTextViewHeightConstraint))
      
/*      //addPhotoButton
      
      //top
      view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.top, relatedBy:.equal, toItem: challengeDescriptionTextView, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
      //left
      view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
      //right
      view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
      //height
      view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .addPhotoHeightConstraint))
      
      //addLocationButton
      
      //top
      view.addConstraint(NSLayoutConstraint(item:addLocationButton, attribute:.top, relatedBy:.equal, toItem: addPhotoButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
      //left
      view.addConstraint(NSLayoutConstraint(item:addLocationButton, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
      //right
      view.addConstraint(NSLayoutConstraint(item:addLocationButton, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
      //height
      view.addConstraint(NSLayoutConstraint(item:addLocationButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .addLocationHeightConstraint))
      
      //tagFriendsButton
      
      //top
      view.addConstraint(NSLayoutConstraint(item:tagFriendsButton, attribute:.top, relatedBy:.equal, toItem: addLocationButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
      //left
      view.addConstraint(NSLayoutConstraint(item:tagFriendsButton, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
      //right
      view.addConstraint(NSLayoutConstraint(item:tagFriendsButton, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
      //height
      view.addConstraint(NSLayoutConstraint(item:tagFriendsButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .tagFriendsHeightConstraint))*/
    }
  
    // MARK: - Actions
  
    func addPhoto() {
      
    }
    
    func addLocation() {
      
    }
    
    func tagFriends() {
      
    }
  
    func postChallenge() {
      // post challenge to backend
      let challengeTitle = challengeNameTextField.text
      let challengeDesc = challengeDescriptionTextView.text
      let challenge:Challenge = API.createChallenge(challengeInfo: ["title": challengeTitle as AnyObject, "desc": challengeDesc as AnyObject])
      print(challenge.description)
      
      // clear fields!
      challengeNameTextField.text = ""
      challengeDescriptionTextView.text = ""
      
      // show alert
      let alertController = UIAlertController(title: "Challenge Posted!", message:
        challengeTitle! + " was posted", preferredStyle: UIAlertControllerStyle.alert)
      alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
      
      self.present(alertController, animated: true, completion: nil)
  }
  
    func doneClicked() {
      view.endEditing(true)
    }
  
    // MARK: - Delegates
  
    func textViewDidBeginEditing(_ textView: UITextView) {
      if textView.isEqual(challengeNameTextField) {
        if challengeNameTextField.textColor == placeholderColor {
          challengeNameTextField.text = ""
          challengeNameTextField.textColor = UIColor.black
          return
        }
      }

      if textView.isEqual(challengeDescriptionTextView) {
        if challengeDescriptionTextView.textColor == placeholderColor {
            challengeDescriptionTextView.text = ""
            challengeDescriptionTextView.textColor = UIColor.black
        }
      }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
      if textView.isEqual(challengeNameTextField) {
        if challengeNameTextField.text.isEmpty {
            challengeNameTextField.text = namePlaceholderText
            challengeNameTextField.textColor = placeholderColor
            return
        }
      }
      
      if textView.isEqual(challengeDescriptionTextView) {
        if challengeDescriptionTextView.text.isEmpty {
            challengeDescriptionTextView.text = descriptionPlaceholderText
            challengeDescriptionTextView.textColor = placeholderColor
        }
      }
    }
    
}
