//
//  ChallengeCategoriesViewController.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 4/21/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class ChallengeCategoriesViewController: UIViewController {

  // MARK: - UI
  
  @IBOutlet weak var addChallengeButton: UIButton!
  
  @IBOutlet weak var exploreChallengesButton: UIButton!
  
  // MARK: - Actions
  
  @IBAction func addChallenge(_ sender: Any) {
    let createChallengeVC = CreateChallengeViewController()
    self.navigationController?.pushViewController(createChallengeVC, animated: true)
  }
  
  @IBAction func findChallenges(_ sender: Any) {
    let findChallengesVC = FindChallengesViewController(nibName: "FindChallengesViewController", bundle: nil)
    findChallengesVC.navigationItem.rightBarButtonItems = KonstruuTabBarController.barButtonItems
    self.navigationController?.pushViewController(findChallengesVC, animated: true)
  }
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
      self.navigationItem.rightBarButtonItems = KonstruuTabBarController.barButtonItems
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  

}
