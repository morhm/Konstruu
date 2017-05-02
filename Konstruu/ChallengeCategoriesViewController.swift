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
  
  // MARK: - Actions
  
  @IBAction func addChallenge(_ sender: Any) {
    let createChallengeVC = CreateChallengeViewController()
    self.navigationController?.pushViewController(createChallengeVC, animated: true)
  }
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  

}
