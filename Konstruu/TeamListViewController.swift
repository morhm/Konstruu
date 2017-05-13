//
//  TeamListViewController.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 5/4/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user: User? {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.title = "Your Teams"
        
        // todo - how do i get current user into new team??
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Team", style: .plain, target: self, action: #selector(addTeam))
        
        teamsTableView.register(UINib(nibName: "TeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "team")
    }
    
    func addTeam() {
        print ("yayy adding team!")
    }
    
    @IBOutlet weak var teamsTableView: UITableView! {
        didSet {
            teamsTableView.dataSource = self
            teamsTableView.delegate = self
            teamsTableView.rowHeight = UITableViewAutomaticDimension
            teamsTableView.estimatedRowHeight = 100
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    /* Probably wrongo! */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.teamKeys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath)
        if let teamsCell = (cell as? TeamsTableViewCell),
            let teamKey = user?.teamKeys[indexPath.row]
                {
            API.getTeamWithKey(teamKey, completed: { team in teamsCell.team = team
            })
            return teamsCell
        }
        return cell
    }
    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */

}
