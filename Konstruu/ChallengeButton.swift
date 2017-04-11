//
//  ChallengeButton.swift
//  Konstruu
//
//  Created by David Xue on 4/11/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

enum ChallengeButtonType : Int {
  case media
  case location
  case friends
}

extension ChallengeButtonType {

  func getButtonImage() -> UIImage {
    switch self {
    case .media:
      return UIImage(named: "media.png")!
    case .location:
      return UIImage(named: "location-maps.png")!
    case .friends:
      return UIImage(named: "Contacts.png")!
    }
  }
  
  func getButtonText() -> String {
    switch self {
    case .media:
      return "Add Photo"
    case .location:
      return "Add Location"
    case .friends:
      return "Tag Friends"
    }
  }
  
  func getTextColor() -> UIColor {
    switch self {
    case .media, .location, .friends:
      return UIColor.gray
    }
  }
}

private extension TimeInterval {
  static let releaseAnimationDuration: TimeInterval = 0.8
  static let pressAnimationDuration: TimeInterval = 0.3
}

private extension CGFloat {
  static let defaultTransformScale: CGFloat = 0.95
  static let defaultDampingOnPress: CGFloat = 0.7
  static let defaultDampingOnRelease: CGFloat = 0.2
}

private extension CGFloat {
  static let imageViewTopConstraint: CGFloat                  = 15.0
  static let imageViewBottomConstraint: CGFloat               = 10.0
  static let imageViewWidthConstraint: CGFloat                = 85.0
  static let imageViewHeightConstraint: CGFloat               = 75.0
  static let titleLabelTopConstraint: CGFloat                 = 7.0
  static let titleLabelSideConstraint: CGFloat                = 20.0
  static let titleLabelHeightConstraint: CGFloat              = 50.0
}

class ChallengeButton: ScalableButton {
  
  // MARK: - data
  
  var challengeButtonType: ChallengeButtonType!
  
  fileprivate var image:UIImage?
  fileprivate var title:String?
  fileprivate var titleColor:UIColor?
  
  // MARK: - subviews
  
  fileprivate lazy var buttonImageView: UIImageView = { [unowned self] in
    let imageView = UIImageView()
    imageView.image = self.image
    imageView.contentMode = .scaleAspectFit
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
    }()
  
  fileprivate lazy var buttonTitleLabel: UILabel = { [unowned self] in
    let titleLabel = UILabel()
    titleLabel.text = self.title
    titleLabel.textColor = self.titleColor!
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 2
    titleLabel.adjustsFontSizeToFitWidth = true
//    titleLabel.font = SwapcardFont.OpenSansSemiBold.font(16.0)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
    }()
  
  // MARK: - layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  override func updateConstraints() {
    
    // image view
    
    //top
    addConstraint(NSLayoutConstraint(item:buttonImageView, attribute:.top, relatedBy:.equal, toItem: self, attribute:.top, multiplier: 1, constant: .imageViewTopConstraint))
    //bottom
    addConstraint(NSLayoutConstraint(item:buttonImageView, attribute:.bottom, relatedBy:.equal, toItem: buttonTitleLabel, attribute:.top, multiplier: 1, constant: -.imageViewBottomConstraint))
    //CenterX
    addConstraint(NSLayoutConstraint(item:buttonImageView, attribute:.centerX, relatedBy:.equal, toItem: self, attribute:.centerX, multiplier: 1, constant: 0))
    //width
    addConstraint(NSLayoutConstraint(item:buttonImageView, attribute:.width, relatedBy:.equal, toItem: buttonImageView, attribute:.height, multiplier: 1, constant: 0))
    
    
    // title label
    
    //centerY
    addConstraint(NSLayoutConstraint(item:buttonTitleLabel, attribute:.centerY, relatedBy:.equal, toItem: self, attribute:.centerY, multiplier: 1, constant: 0))
    //left
    addConstraint(NSLayoutConstraint(item:buttonTitleLabel, attribute:.left, relatedBy:.equal, toItem: self, attribute:.left, multiplier: 1, constant: .titleLabelSideConstraint))
    //right
    addConstraint(NSLayoutConstraint(item:buttonTitleLabel, attribute:.right, relatedBy:.equal, toItem: self, attribute:.right, multiplier: 1, constant: -.titleLabelSideConstraint))
    //height
    addConstraint(NSLayoutConstraint(item:buttonTitleLabel, attribute:.height, relatedBy:.lessThanOrEqual, toItem: nil, attribute:.notAnAttribute, multiplier: 1, constant:.titleLabelHeightConstraint))
    
    super.updateConstraints()
  }
  
  // MARK: - init
  
  convenience init(challengeButtonType: ChallengeButtonType) {
    self.init(frame: CGRect.zero, challengeButtonType: challengeButtonType)
  }
  
  init(frame: CGRect, challengeButtonType: ChallengeButtonType) {
    super.init(frame:frame)
    
    self.challengeButtonType  = challengeButtonType
    
    self.image                = self.challengeButtonType.getButtonImage()
    self.title                = self.challengeButtonType.getButtonText()
    self.titleColor           = self.challengeButtonType.getTextColor()
    
//    setupCardBackground()
    setupScalableProperties()
    
    addSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - setup
  
  func addSubviews() {
    addSubview(buttonImageView)
    addSubview(buttonTitleLabel)
  }
  
  func setupScalableProperties() {
    transformScale = .defaultTransformScale
    dampingOnPress = .defaultDampingOnPress
    dampingOnRelease = .defaultDampingOnRelease
    
    pressAnimation = .pressAnimationDuration
    releaseAnimation = .releaseAnimationDuration
  }
  
//  func setupCardBackground() {
//    self.layer.cornerRadius = 3.0                               // rounded corners
//    self.layer.shadowColor = UIColor.black.cgColor       // drop shadow
//    self.layer.shadowOpacity = 0.6
//    self.layer.shadowRadius = 1.0
//    self.layer.shadowOffset = CGSize(width: 0, height: 1.5);
//    self.backgroundColor = UIColor.white                 // white background
//  }
}
