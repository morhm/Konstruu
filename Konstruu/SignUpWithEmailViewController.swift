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
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { [weak self] user, error in
                if error != nil || user == nil {
                    print(error!)
                } else {
                    let databaseUser = API.createUserWithKey(user!.uid, userInfo: ["name": name as AnyObject  , "email": user!.email as AnyObject])
                    let tabBarVC = KonstruuTabBarController(nibName: "KonstruuTabBarController", bundle: nil)
                    tabBarVC.user = databaseUser
                    self?.present(tabBarVC, animated: true, completion: nil)
                }
            })
        }
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
