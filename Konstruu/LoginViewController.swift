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
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        present(profileVC, animated: false, completion: {
            profileVC.user = DataStructures.exampleUsers[0]
        })
     }
    
    @IBAction func loginWithEmail(_ sender: UIButton) {
        let findChallengeVC = FindChallengesTableViewController(nibName: "FindChallengesTableViewController", bundle: nil)
        present(findChallengeVC, animated: false, completion: {
        })
    }
}
