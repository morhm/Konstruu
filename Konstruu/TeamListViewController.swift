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
    
    
    
    @IBOutlet weak var teamListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.title = "Your Teams"
        
        // todo - how do i get current user into new team??
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Team", style: .plain, target: self, action: #selector(addTeam))
        
        teamListTableView.register(UINib(nibName: "TeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "teams")
    }
    
    func addTeam() {
        print ("yayy adding team!")
      
        let team = API.createTeam(teamInfo: ["name": "Mark-made Team" as AnyObject, "open": true as AnyObject, "challengeKey": "not-a-key" as AnyObject])
      
        print (user)
        
        let currUser = API.getCurrentUser(completed: {currUser in self.user})
        
        print (currUser)
      
        self.teamListTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    /* Probably wrongo! */
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
  

}
