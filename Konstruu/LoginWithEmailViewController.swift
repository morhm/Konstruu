//
//  LoginWithEmailViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 5/4/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import Applozic
import FirebaseAuth

class LoginWithEmailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Navigation

    @IBAction func loginClicked(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { [weak self] firebaseUser, error in
                if error != nil || firebaseUser == nil {
                    print(error!)
                } else {
                    API.getUserWithKey(firebaseUser!.uid, completed: { user in
                        user?.registerForChat()
                        
                        let tabBarVC = KonstruuTabBarController(nibName: "KonstruuTabBarController", bundle: nil)
                        tabBarVC.user = user
                        self?.present(tabBarVC, animated: true, completion: nil)
                    })
                }
            })
        }
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToolbarToKeyboard()
    }
    
    private func addToolbarToKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
    }
    
    func doneClicked() {
        view.endEditing(true)
    }

}
