//
//  KonstruuTabBarController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/10/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class KonstruuTabBarController: UITabBarController, UITabBarControllerDelegate {

    // Tutorial: http://swiftdeveloperblog.com/code-examples/create-uitabbarcontroller-programmatically/
    
    // MARK: - Model
    
    var user: DataStructures.User?
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set up ProfileViewController with its UITabBarItem
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        profileVC.user = user
        let profileTabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "Contact"), tag: 0)
        profileVC.tabBarItem = profileTabBarItem
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.viewControllers = [profileVC]
        
        // Set up FindChallengesViewController with its UITabBarItem
        let findChallengesVC = FindChallengesViewController(nibName: "FindChallengesViewController", bundle: nil)
        let findChallengesTabBarItem = UITabBarItem(title: "Find Challenges", image: #imageLiteral(resourceName: "Search"), tag: 1)
        findChallengesVC.tabBarItem = findChallengesTabBarItem
        
        let findChallengesNavigationController = UINavigationController()
        findChallengesNavigationController.viewControllers = [findChallengesVC]
        
        // Set up CreateChallengeViewController with its UITabBarItem
        let createChallengeVC = CreateChallengeViewController(nibName: "CreateChallengeViewController", bundle: nil)
        let createChallengeTabBarItem = UITabBarItem(title: "Create a Challenge", image: #imageLiteral(resourceName: "New"), tag: 2)
        createChallengeVC.tabBarItem = createChallengeTabBarItem
        
        let createChallengeNavigationController = UINavigationController()
        createChallengeNavigationController.viewControllers = [createChallengeVC]
        
        self.viewControllers = [profileNavigationController, findChallengesNavigationController, createChallengeNavigationController]
    }
}
