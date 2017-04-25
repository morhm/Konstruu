////
////  ChallengeCategories.swift
////  Konstruu
////
////  Created by David Xue on 4/24/17.
////  Copyright © 2017 Frog and Code. All rights reserved.
////
//
//import UIKit
//
//
//private extension CGFloat {
//  static let marginConstraint:CGFloat = 8.0
//  static let nameTextFieldHeightConstraint:CGFloat = 35.0
//  static let descriptionTextViewHeightConstraint:CGFloat = 250.0
//  static let addPhotoHeightConstraint:CGFloat = 30.0
//  static let addLocationHeightConstraint:CGFloat = 30.0
//  static let tagFriendsHeightConstraint:CGFloat = 30.0
//}
//
//
//class ChallengeCategories: UIViewController {
//  
//  // MARK: - Constants
//  
//  
//  
//  // MARK: - UI
//  
//  
//  
//  private lazy var addChallengeButton: UIButton = { [unowned self] in
//    let addChallengeButton = UIButton(type: .custom)
//    addChallengeButton.backgroundColor = UIColor.white
//    addChallengeButton.addTarget(self, action: #selector(addPhoto), for: UIControlEvents.touchUpInside)
//    
//    addChallengeButton.translatesAutoresizingMaskIntoConstraints = false
//    return addChallengeButton
//    }()
//  
//  private lazy var bookmarkedButton: UIButton = { [unowned self] in
//    let bookmarkedButton = UIButton(type: .custom)
//    bookmarkedButton.backgroundColor = UIColor.white
//    bookmarkedButton.addTarget(self, action: #selector(addPhoto), for: UIControlEvents.touchUpInside)
//    
//    bookmarkedButton.translatesAutoresizingMaskIntoConstraints = false
//    return bookmarkedButton
//    }()
//  
//  private lazy var exploreButton: UIButton = { [unowned self] in
//    let exploreButton = UIButton(type: .custom)
//    exploreButton.backgroundColor = UIColor.white
//    exploreButton.addTarget(self, action: #selector(addPhoto), for: UIControlEvents.touchUpInside)
//    
//    exploreButton.translatesAutoresizingMaskIntoConstraints = false
//    return exploreButton
//    }()
//  
//  private lazy var sponsoredButton: UIButton = { [unowned self] in
//    let sponsoredButton = UIButton(type: .custom)
//    sponsoredButton.backgroundColor = UIColor.white
//    sponsoredButton.addTarget(self, action: #selector(addPhoto), for: UIControlEvents.touchUpInside)
//    
//    sponsoredButton.translatesAutoresizingMaskIntoConstraints = false
//    return sponsoredButton
//    }()
//  
//  private lazy var recommendationButton: UIButton = { [unowned self] in
//    let recommendationButton = UIButton(type: .custom)
//    recommendationButton.backgroundColor = UIColor.white
//    recommendationButton.addTarget(self, action: #selector(addPhoto), for: UIControlEvents.touchUpInside)
//    
//    recommendationButton.translatesAutoresizingMaskIntoConstraints = false
//    return recommendationButton
//    }()
//  
//  // MARK: - View controller lifecycle
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    self.title = "Challenge Categories"
//    self.edgesForExtendedLayout = []
//    
//    view.backgroundColor = UIColor.konstruuLightGray()
//    
//    addSubviews()
//    addConstraints()
//  }
//  
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//  }
//  
//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//  }
//  
//  override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//  }
//  
//  override func viewDidDisappear(_ animated: Bool) {
//    super.viewDidDisappear(animated)
//  }
//  
//  // MARK: - Layout
//  
//  func addSubviews() {
//    view.addSubview(challengeNameTextField)
//    view.addSubview(challengeDescriptionTextView)
//    view.addSubview(addPhotoButton)
//    view.addSubview(addLocationButton)
//    view.addSubview(tagFriendsButton)
//  }
//  
//  func addConstraints() {
//    //challengeNameTextField
//    
//    //top
//    view.addConstraint(NSLayoutConstraint(item:challengeNameTextField, attribute:.top, relatedBy:.equal, toItem: view, attribute:.top, multiplier: 1, constant: .marginConstraint))
//    //left
//    view.addConstraint(NSLayoutConstraint(item:challengeNameTextField, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
//    //right
//    view.addConstraint(NSLayoutConstraint(item:challengeNameTextField, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
//    //height
//    view.addConstraint(NSLayoutConstraint(item:challengeNameTextField, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .nameTextFieldHeightConstraint))
//    
//    
//    //challengeDescriptionTextView
//    
//    
//    //top
//    view.addConstraint(NSLayoutConstraint(item:challengeDescriptionTextView, attribute:.top, relatedBy:.equal, toItem: challengeNameTextField, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
//    //left
//    view.addConstraint(NSLayoutConstraint(item:challengeDescriptionTextView, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
//    //right
//    view.addConstraint(NSLayoutConstraint(item:challengeDescriptionTextView, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
//    //height
//    view.addConstraint(NSLayoutConstraint(item:challengeDescriptionTextView, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .descriptionTextViewHeightConstraint))
//    
//    
//    //addPhotoButton
//    
//    //top
//    view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.top, relatedBy:.equal, toItem: challengeDescriptionTextView, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
//    //left
//    view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
//    //right
//    view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
//    //height
//    view.addConstraint(NSLayoutConstraint(item:addPhotoButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .addPhotoHeightConstraint))
//    
//    //addLocationButton
//    
//    //top
//    view.addConstraint(NSLayoutConstraint(item:addLocationButton, attribute:.top, relatedBy:.equal, toItem: addPhotoButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
//    //left
//    view.addConstraint(NSLayoutConstraint(item:addLocationButton, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
//    //right
//    view.addConstraint(NSLayoutConstraint(item:addLocationButton, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
//    //height
//    view.addConstraint(NSLayoutConstraint(item:addLocationButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .addLocationHeightConstraint))
//    
//    //tagFriendsButton
//    
//    //top
//    view.addConstraint(NSLayoutConstraint(item:tagFriendsButton, attribute:.top, relatedBy:.equal, toItem: addLocationButton, attribute:.bottom, multiplier: 1, constant: .marginConstraint))
//    //left
//    view.addConstraint(NSLayoutConstraint(item:tagFriendsButton, attribute:.left, relatedBy:.equal, toItem: view, attribute:.left, multiplier: 1, constant: .marginConstraint))
//    //right
//    view.addConstraint(NSLayoutConstraint(item:tagFriendsButton, attribute:.right, relatedBy:.equal, toItem: view, attribute:.right, multiplier: 1, constant: -.marginConstraint))
//    //height
//    view.addConstraint(NSLayoutConstraint(item:tagFriendsButton, attribute:.height, relatedBy:.equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant: .tagFriendsHeightConstraint))
//  }
//  
//  // MARK: - Actions
//  
//  func addPhoto() {
//    
//  }
//  
//  func addLocation() {
//    
//  }
//  
//  func tagFriends() {
//    
//  }
//  
//  func postChallenge() {
//    
//  }
//  
//  func doneClicked() {
//    view.endEditing(true)
//  }
//}
//
