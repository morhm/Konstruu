//
//  LoginViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Navigation

     @IBAction func loginWithFacebook(_ sender: UIButton) {
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        present(profileVC, animated: false, completion: {
            profileVC.userID = 1
        })
     }
    
    @IBAction func loginWithEmail(_ sender: UIButton) {
        let findChallengeVC = FindChallengesTableViewController(nibName: "FindChallengesTableViewController", bundle: nil)
        present(findChallengeVC, animated: false, completion: {
        })
    }
}
