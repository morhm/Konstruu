//
//  ProfileViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // TODO: change after demo
    var userID: Int? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    private func updateUI() {
        usernameLabel.text = "\(userID)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
