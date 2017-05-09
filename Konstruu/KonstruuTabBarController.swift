//
//  KonstruuTabBarController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/10/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class KonstruuTabBarController: UITabBarController, UITabBarControllerDelegate {

    // Tutorial: http://swiftdeveloperblog.com/code-examples/create-uitabbarcontroller-programmatically/
    
    // MARK: - Model
    
    var user: User?
    
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
        
        
       
        let teamsVC = TeamListViewController(nibName: "TeamListViewController", bundle: nil)
        //teamsVC.user = user
        
        let teamsTabBarItem = UITabBarItem(title: "Teams", image: #imageLiteral(resourceName: "groupIcon"), tag: 1)
        teamsVC.tabBarItem = teamsTabBarItem
        
        let teamsNavigationController = UINavigationController()
        teamsNavigationController.viewControllers = [teamsVC]
        
      
        // Set up FindChallengesViewController with its UITabBarItem
        let findChallengesVC = FindChallengesViewController(nibName: "FindChallengesViewController", bundle: nil)
        let findChallengesTabBarItem = UITabBarItem(title: "Find Challenges", image: #imageLiteral(resourceName: "Search"), tag: 3)
        findChallengesVC.tabBarItem = findChallengesTabBarItem
        
        let findChallengesNavigationController = UINavigationController()
        findChallengesNavigationController.viewControllers = [findChallengesVC]
 
 
        // Set up CreateChallengeViewController with its UITabBarItem
        let createChallengeVC = CreateChallengeViewController()
        let createChallengeTabBarItem = UITabBarItem(title: "Create a Challenge", image: #imageLiteral(resourceName: "New"), tag: 2)
        createChallengeVC.tabBarItem = createChallengeTabBarItem
        
        let createChallengeNavigationController = UINavigationController()
        createChallengeNavigationController.viewControllers = [createChallengeVC]
      
        // my new code
        /*let challengeCategoriesVC = ChallengeCategoriesViewController(nibName: "ChallengeCategoriesViewController", bundle: nil)
        let challengeCategoriesTabBarItem = UITabBarItem(title: "Find Challenges", image: #imageLiteral(resourceName: "Search"), tag: 3)
        challengeCategoriesVC.tabBarItem = challengeCategoriesTabBarItem
        
        let challengeCategoriesNavigationController = UINavigationController()
        challengeCategoriesNavigationController.viewControllers = [challengeCategoriesVC]
 */
      
        self.viewControllers = [profileNavigationController, teamsNavigationController, createChallengeNavigationController, findChallengesNavigationController]
 
    }
    
    func findChallengesWasClicked() {
        self.selectedIndex = 1
        if let navigationController = (self.viewControllers?[1] as? UINavigationController) {
            navigationController.popToRootViewController(animated: false)
        }
    }
}
