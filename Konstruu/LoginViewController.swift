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
        let tabBarVC = KonstruuTabBarController(nibName: "KonstruuTabBarController", bundle: nil)
        tabBarVC.user = DataStructures.exampleUsers[0] // REPLACE AFTER DEMO
        present(tabBarVC, animated: true, completion: nil)
     }
}
