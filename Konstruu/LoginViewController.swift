//
//  LoginViewController.swift
//  Konstruu
//
//  Created by Al Yuen on 3/6/17.
//  Copyright © 2017 Frog and Code. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth

class LoginViewController: UIViewController, LoginButtonDelegate {
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let facebookLoginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        facebookLoginButton.center = view.center
        
        facebookLoginButton.delegate = self
        
        view.addSubview(facebookLoginButton)
    }
    
    // MARK: - Facebook login button delegate
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .cancelled:
            break
        case .failed(let error):
            print("failed in loginButtonDidCompleteLogin") // DEBUGGING
            print(error.localizedDescription)
        case .success(_, _, let token):
            loginWithFacebook(token: token)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    private func loginWithFacebook(token: AccessToken) {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
        FIRAuth.auth()?.signIn(with: credential, completion: { [weak self] (firebaseAuthUser, error) in
            if error != nil || firebaseAuthUser == nil {
                print(error.debugDescription) // DEBUGGING
                let alert = UIAlertController(title: "Unable to Login", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            } else {
                print(String(describing:
                    firebaseAuthUser!.displayName)) // DEBUGGING
                print(String(describing: firebaseAuthUser!.email)) // DEBUGGING
                API.getUserWithKey(firebaseAuthUser!.uid, completed: { [weak self] user in
                    if user != nil {
                        user?.registerForChat()
                        self?.showProfile(user: user!)
                    } else {
                        self?.createUserFromFacebookProfile(token: token, firebaseAuthUser: firebaseAuthUser!)
                    }
                })
            }
            
        })
    }
    
    private func createUserFromFacebookProfile(token: AccessToken, firebaseAuthUser: FIRUser) {
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], accessToken: token, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        graphRequest.start({ [weak self] (response, result) in
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
                let alert = UIAlertController(title: "Unable to Sign Up", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            case .success(let value):
                if let dictionary = value.dictionaryValue {
                    let userInfo: Dictionary<String, AnyObject> = ["name": dictionary["name"] as AnyObject, "email": dictionary["email"] as AnyObject]
                    let user = API.createUserWithKey(firebaseAuthUser.uid, userInfo: userInfo)
                    user.registerForChat()
                    
                    /* Added test challenge and team for fb logins */
                    let challengeInfo: Dictionary<String, AnyObject> = ["title": "Test Challenge" as AnyObject, "desc": "Created for user \(user.key)" as AnyObject]
                    let challenge = API.createChallenge(challengeInfo: challengeInfo)
                    
                    let teamInfo: Dictionary<String, AnyObject> = ["name": "Test Team" as AnyObject, "open": true as AnyObject, "challengeKey": challenge.key as AnyObject]
                    let team = API.createTeam(teamInfo: teamInfo)
                    
                    team.addUser(user)
                    challenge.addTeam(team)
                    
                    self?.showProfile(user: user)
                }
                
            }
        })
    }
    
    // MARK: - Navigation

    private func showProfile(user: User) {
        print(user) // DEBUGGING
        let tabBarVC = KonstruuTabBarController(nibName: "KonstruuTabBarController", bundle: nil)
        tabBarVC.user = user
        present(tabBarVC, animated: true, completion: nil)
    }
    
    @IBAction func loginWithEmail(_ sender: UIButton) {
        let loginWithEmailVC = LoginWithEmailViewController(nibName: "LoginWithEmailViewController", bundle: nil)
        present(loginWithEmailVC, animated: true, completion: nil)
    }
    
    @IBAction func signUpWithEmail(_ sender: UIButton) {
        let signUpWithEmailVC = SignUpWithEmailViewController(nibName: "SignUpWithEmailViewController", bundle: nil)
        present(signUpWithEmailVC, animated: true, completion: nil)
    }
}
