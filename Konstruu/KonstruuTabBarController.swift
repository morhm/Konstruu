//
//  KonstruuTabBarController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/10/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import Applozic

class KonstruuTabBarController: UITabBarController, UITabBarControllerDelegate {

    // Tutorial: http://swiftdeveloperblog.com/code-examples/create-uitabbarcontroller-programmatically/
    
    // MARK: - Model
    
    var user: User?
    
    static let messagingButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "message-7"), style: .plain, target: self, action: #selector(showMessaging))
    
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
        
        let teamsTabBarItem = UITabBarItem(title: "Teams", image: #imageLiteral(resourceName: "groupIcon"), tag: 2)
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
        let createChallengeTabBarItem = UITabBarItem(title: "Create a Challenge", image: #imageLiteral(resourceName: "New"), tag: 4)
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
        
        // Add messaging button to navigation bars
        profileVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
        teamsVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
        findChallengesVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
        createChallengeVC.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
      
        self.viewControllers = [profileNavigationController, teamsNavigationController, findChallengesNavigationController, createChallengeNavigationController]
    }
    
    func findChallengesWasClicked() {
        self.selectedIndex = 1
        if let navigationController = (self.viewControllers?[1] as? UINavigationController) {
            navigationController.popToRootViewController(animated: false)
        }
    }
    
    func showMessaging() {
        let chatManager = ALChatManager(applicationKey: ALChatManager.applicationId as NSString)
        chatManager.launchChat(self)
    }
}
