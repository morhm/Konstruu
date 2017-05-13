//
//  ProfileViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    // MARK: - Model
    
    var user: User? {
        didSet {
            updateUI()
        }
    }
  
    // MARK: - UI
  
    private lazy var backgroundView: UIImageView = { [unowned self] in
      let backgroundView = UIImageView()
      backgroundView.image = UIImage(named: "profileGradient.png")
      backgroundView.contentMode = UIViewContentMode.scaleAspectFill
      
      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      return backgroundView
      }()
  
    @IBOutlet weak var badgesTableView: UITableView! {
        didSet {
            badgesTableView.dataSource = self
            badgesTableView.delegate = self
            badgesTableView.backgroundColor = .clear
            badgesTableView.rowHeight = 290.0
            badgesTableView.estimatedRowHeight = 100
        }
    }
  
    var infoCell: ProfileInfoTableViewCell = ProfileInfoTableViewCell(style: .default, reuseIdentifier: "infoCell")
    var specialtyCell: ProfileSpecialtyTableViewCell = ProfileSpecialtyTableViewCell(style: .default, reuseIdentifier: "specialtyCell")
    var projectCell: ProfileProjectTableViewCell = ProfileProjectTableViewCell(style: .default, reuseIdentifier: "projectCell")
  
    private func updateUI() {
      infoCell.user = user
      infoCell.parentViewController = self
      
      badgesTableView?.reloadData()
    }
    
  
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      self.edgesForExtendedLayout = []
      self.title = "Profile"
      
      addSubviews()
      addConstraints()
      
      updateUI()
    }
    
    func addSubviews() {
      view.addSubview(backgroundView)
      view.sendSubview(toBack: backgroundView)
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
      
      view.layoutIfNeeded()
    }
  
    // MARK: - Table view data source
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath.section == 0 {
        switch indexPath.row {
        case 0:
          return 290.0
        case 1:
          return 170.0
        case 2:
          return 300.0
        default:
          break
        }
      }
      return 70.0
    }
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 20.0
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if indexPath.section == 0 {
        switch indexPath.row {
        case 0:
          return infoCell
        case 1:
          return specialtyCell
        case 2:
          return projectCell
        default:
          break
        }
      }
      
      //tableView.dequeueReusableCell(withIdentifier: "badge", for: indexPath)
//        if let badgeCell = (cell as? BadgeTableViewCell) {
//            badgeCell.badgeTitle = user?.badges[indexPath.row]
//            return badgeCell
//        }
        let cell =  UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
    
    // MARK: - Navigation
    
    @IBAction func showFindChallenges(_ sender: UIButton) {
        if let tabBarController = (self.tabBarController as? KonstruuTabBarController) {
            tabBarController.findChallengesWasClicked()
        }
    }
}
