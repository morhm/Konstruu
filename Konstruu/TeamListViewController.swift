//
//  TeamListViewController.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 5/4/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//    var teams: [Team]? {
//        didSet {
//        }
//    }

    var user: User? {
        didSet {
            
          
        }
    }
    
    @IBOutlet weak var teamListTableView: UITableView! {
      didSet {
        teamListTableView.dataSource = self
        teamListTableView.delegate = self
  //      teamListTableView.rowHeight = UITableViewAutomaticDimension
  //      teamListTableView.estimatedRowHeight = 150
      }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = KonstruuTabBarController.messagingButtonItem
        self.navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
        
        self.edgesForExtendedLayout = []
        self.title = "Your Teams"
      
        teamListTableView.register(UINib(nibName: "TeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "teams")
    }
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      self.teamListTableView.reloadData()
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.teamKeys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teams", for: indexPath)
        if let teamsCell = (cell as? TeamsTableViewCell),
            let teamKey = user?.teamKeys[indexPath.row]
                {
            API.getTeamWithKey(teamKey, completed: { team in teamsCell.team = team
            })
            return teamsCell
        }
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        let teamVC = TeamViewController(nibName: "TeamViewController", bundle: nil)
        if let teamKey = user?.teamKeys[indexPath.row]
            {
                API.getTeamWithKey(teamKey, completed: { team in
                    teamVC.team = team
                    teamVC.navigationItem.rightBarButtonItem =
                        KonstruuTabBarController.messagingButtonItem
                    teamVC.navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
                    self.navigationController?.pushViewController(teamVC, animated: true)
                })
        }
    }
}
