//
//  CreateTeamViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit

class CreateTeamViewController: UIViewController {
    
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var teamDescription: UITextField!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var createTeamButton: UIButton!
    
    @IBAction func addImage(_ sender: UIButton) {
    }
    @IBAction func createTeam(_ sender: UIButton) {
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Team"
        self.edgesForExtendedLayout = []

    }
    
    
}
