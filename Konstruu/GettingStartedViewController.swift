//
//  GettingStartedViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 6/10/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class GettingStartedViewController: UIViewController {
    
    // MARK: - Model
    
    private var stepNumber = 0
    
    private var numberOfSteps = 3
    
    var user: User?

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView?.image = #imageLiteral(resourceName: "Getting Started Guide 1 Welcome")
    }
    
    // MARK: - UI
    
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func nextButton(_ sender: UIButton) {
        stepNumber += 1
        
        switch(stepNumber) {
        case 1:
            imageView?.image = #imageLiteral(resourceName: "Getting Started Guide 2 Profile")
        case 2:
            imageView?.image = #imageLiteral(resourceName: "Getting Started Guide 3 Finding Challenges")
        case 3:
            imageView?.image = #imageLiteral(resourceName: "Getting Started Guide 4 Challenge")
        case 4:
            let tabBarVC = KonstruuTabBarController(nibName: "KonstruuTabBarController", bundle: nil)
            tabBarVC.user = user
            present(tabBarVC, animated: true, completion: nil)
        default:
            break
        }
    }

}
