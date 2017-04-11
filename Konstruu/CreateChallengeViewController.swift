//
//  CreateChallengeViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class CreateChallengeViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Constants
    
    private let placeholderText = "Enter challenge description here"
    
    private let placeholderColor = UIColor.lightGray
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create a Challenge"
        self.edgesForExtendedLayout = []
      
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(postChallenge))

        addToolbarToKeyboard()
    }
  
    // MARK: - UI
    
    @IBOutlet weak var challengeNameTextField: UITextField!
    
    @IBOutlet weak var challengeDescriptionTextView: UITextView! {
        didSet {
            challengeDescriptionTextView.delegate = self
            
            // Set placeholder text
            challengeDescriptionTextView.text = placeholderText
            challengeDescriptionTextView.textColor = placeholderColor
        }
    }
  
    private lazy var addPhotoButton: ChallengeButton = { [unowned self] in
      let addPhotoButton = ChallengeButton(challengeButtonType: ChallengeButtonType.media)
      addPhotoButton.addTarget(self, action: #selector(addPhoto), for: UIControlEvents.touchUpInside)
      
      addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
      return addPhotoButton
      }()
  
    private lazy var addLocationButton: ChallengeButton = { [unowned self] in
      let addLocationButton = ChallengeButton(challengeButtonType: ChallengeButtonType.location)
      addLocationButton.addTarget(self, action: #selector(addLocation), for: UIControlEvents.touchUpInside)
      
      addLocationButton.translatesAutoresizingMaskIntoConstraints = false
      return addLocationButton
      }()
    
    private lazy var tagFriendsButton: ChallengeButton = { [unowned self] in
      let tagFriendsButton = ChallengeButton(challengeButtonType: ChallengeButtonType.friends)
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
  
    // MARK: - Actions
  
  
    func addPhoto() {
      
    }
    
    func addLocation() {
      
    }
    
    func tagFriends() {
      
    }
  
    func postChallenge() {
      
    }
  
    func doneClicked() {
        view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if challengeDescriptionTextView.textColor == placeholderColor {
            challengeDescriptionTextView.text = ""
            challengeDescriptionTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if challengeDescriptionTextView.text.isEmpty {
            challengeDescriptionTextView.text = placeholderText
            challengeDescriptionTextView.textColor = placeholderColor
        }
    }
    
}
