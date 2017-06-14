//
//  TeamListViewController.swift
//  Konstruu
//
//  Created by Mark Anthony Orozco on 5/4/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var whiteRoundedView: UIView!
    var numLoaded = 0
    let cellSpacingHeight = CGFloat(7.0)
    
    var user: User? {
        didSet {
        }
    }
    
//    private lazy var backgroundView: UIImageView = { [unowned self] in
//        let backgroundView = UIImageView()
//        backgroundView.image = UIImage(named: "profileGradient.png")
//        backgroundView.contentMode = UIViewContentMode.scaleAspectFill
//        
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        return backgroundView
//    }()
    
    @IBOutlet weak var teamListTableView: UITableView! {
      didSet {
        teamListTableView.dataSource = self
        teamListTableView.delegate = self
        teamListTableView.separatorStyle = .none
        
  //      teamListTableView.rowHeight = UITableViewAutomaticDimension
  //      teamListTableView.estimatedRowHeight = 150
      }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItems = KonstruuTabBarController.barButtonItems
        
        self.edgesForExtendedLayout = []
        self.title = "Your Teams"
      
        teamListTableView.register(UINib(nibName: "TeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "teams")
        
        //view.addSubview(backgroundView)
    }
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      self.teamListTableView.reloadData()
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return (user?.teamKeys.count)!
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teams", for: indexPath)
        
        if (numLoaded < (user?.teamKeys.count)! ) {
            numLoaded = numLoaded + 1
            whiteRoundedView = UIView(frame: CGRect(x: 10, y: 10, width: (self.view.frame.size.width - 20), height: 60))
            
            whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
            whiteRoundedView.layer.masksToBounds = false
            whiteRoundedView.layer.cornerRadius = 10.0
            whiteRoundedView.layer.shadowOffset = CGSize(width: -0, height: 1.0)
            whiteRoundedView.layer.shadowOpacity = 0.2
            
            cell.contentView.addSubview(whiteRoundedView)
            cell.contentView.sendSubview(toBack: whiteRoundedView)
        }
        
        if let teamsCell = (cell as? TeamsTableViewCell),
            let teamKey = user?.teamKeys[indexPath.section]
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
        if let teamKey = user?.teamKeys[indexPath.section]
            {
                API.getTeamWithKey(teamKey, completed: { team in
                    teamVC.team = team
                    teamVC.navigationItem.rightBarButtonItem =
                        KonstruuTabBarController.messagingButtonItem
                    //teamVC.navigationItem.leftBarButtonItem = KonstruuTabBarController.logoutButtonItem
                    self.navigationController?.pushViewController(teamVC, animated: true)
                })
        }
    }
}
