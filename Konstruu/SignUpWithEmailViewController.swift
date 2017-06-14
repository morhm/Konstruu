//
//  SignUpWithEmailViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 4/24/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpWithEmailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addToolbarToKeyboard()
    }

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { [weak self] firebaseUser, error in
                if error != nil || firebaseUser == nil {
                    print(error.debugDescription)
                    let alert = UIAlertController(title: "Unable to Sign Up", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    let userInfo: Dictionary<String, AnyObject> = ["name": name as AnyObject  , "email": firebaseUser!.email as AnyObject]
                    let user = API.createUserWithKey(firebaseUser!.uid, userInfo: userInfo)
                    user.registerForChat()
                    
                    let gettingStartedVC = GettingStartedViewController(nibName: "GettingStartedViewController", bundle: nil)
                    gettingStartedVC.user = user
                    self?.present(gettingStartedVC, animated: true, completion: nil)
                }
            })
        }
    }
    
    // FOR TESTING PURPOSES
    // not connected to a button at this time
    @IBAction func createTestUser(_ sender: UIButton) {
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { [weak self] firebaseUser, error in
                if error != nil || firebaseUser == nil {
                    print(error!)
                } else {
                    let userInfo: Dictionary<String, AnyObject> = ["name": name as AnyObject, "email": firebaseUser!.email as AnyObject, "desc": "Test description for user with id \(firebaseUser!.uid)" as AnyObject, "skills": ["iOS", "git"] as AnyObject]
                    let user = API.createUserWithKey(firebaseUser!.uid, userInfo: userInfo)
                    user.registerForChat()
                    
                    let challengeInfo: Dictionary<String, AnyObject> = ["title": "Test Challenge" as AnyObject, "desc": "Created for user \(user.key)" as AnyObject]
                    let challenge = API.createChallenge(challengeInfo: challengeInfo)
                    
                    let teamInfo: Dictionary<String, AnyObject> = ["name": "Test Team" as AnyObject, "open": true as AnyObject, "challengeKey": challenge.key as AnyObject]
                    let team = API.createTeam(teamInfo: teamInfo)
                    
                    team.addUser(user)
                    challenge.addTeam(team)
                    
                    let tabBarVC = KonstruuTabBarController(nibName: "KonstruuTabBarController", bundle: nil)
                    tabBarVC.user = user
                    self?.present(tabBarVC, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        present(loginVC, animated: true, completion: nil)
    }
    
    private func addToolbarToKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        nameTextField.inputAccessoryView = toolbar
    }
    
    func doneClicked() {
        view.endEditing(true)
    }

}
