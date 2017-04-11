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
//        let newUser = API.createUser(name: DataStructures.exampleUsers[0].name)
//        API.getUserWithId(newUser.id, completed: { user in
//            tabBarVC.user = user
//            self.present(tabBarVC, animated: true, completion: nil)
//        })
    }
}
