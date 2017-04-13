//
//  LoginViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import DataStructures

class LoginViewController: UIViewController {
    
    // MARK: - Navigation

     @IBAction func loginWithFacebook(_ sender: UIButton) {
        skipToProfile()
     }
    
    @IBAction func loginWithEmail(_ sender: UIButton) {
        skipToProfile()
    }
    
    @IBAction func signUpWithFacebook(_ sender: UIButton) {
        skipToProfile()
    }
    
    @IBAction func signUpWithEmail(_ sender: UIButton) {
        skipToProfile()
    }
    
    //TODO: REMOVE AFTER DEMO
    private func skipToProfile() {
        let tabBarVC = KonstruuTabBarController(nibName: "KonstruuTabBarController", bundle: nil)
        tabBarVC.user = DataStructures.exampleUsers[0]
        present(tabBarVC, animated: true, completion: nil)
        
        // TESTING CODE BELOW
//        let user = API.createUser(userInfo: ["name": "Al" as AnyObject])
//        let challenge = API.createChallenge(challengeInfo: ["title": "Do a thing" as AnyObject, "description": "Really do it" as AnyObject])
//        let team = API.createTeam(teamInfo: ["name": "Frog and Code" as AnyObject, "open": true as AnyObject, "challenge": challenge.key as AnyObject])
//        team.addUser(user)
//        challenge.addTeam(team)
//        API.getTeamsForUser(user, completed: { teams in
//            print("\(teams)")
//        })
//        print("\(user)")
//        print("\(challenge)")
//        print("\(team)")
    }
}
