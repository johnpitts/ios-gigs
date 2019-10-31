//
//  LoginViewController.swift
//  ios-gigs
//
//  Created by John Pitts on 5/16/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var authSegmentedControl: UISegmentedControl!
    @IBOutlet var authenticationButton: UIButton!
    
    
    enum SignInType {
        case signUp
        case logIn
    }
    
    var loginType: SignInType = .signUp
    
    var gigController: GigController!
    
    
    
    @IBAction func authenticationButtonPressed(_ sender: Any) {
        
        guard let username = usernameTextField.text,
            let password = passwordTextField.text else { return }
        
        switch loginType {
        case .signUp:
            
            gigController?.signUp(with: username, password: password) { (error) in
                
                if let error = error {
                    NSLog("Error signing up: \(error)")
                } else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Sign Up Successful", message: "Now please log in.", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true, completion: {
                            self.loginType = .logIn
                            self.authSegmentedControl.selectedSegmentIndex = 1
                            self.authenticationButton.setTitle("Sign In", for: .normal)
                            // need to do an outlet for the button so we can give it a name
                        })
                    }
                }
            }
        case .logIn:
            
            gigController?.logIn(with: username, password: password, completion: { (error) in
                if let error = error {
                    NSLog("Error logging in: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    @IBAction func authenticationSegmentedControlChanged(_ sender: Any) {
        if authSegmentedControl.selectedSegmentIndex == 0 {
            loginType = .signUp
            authenticationButton.setTitle("Sign Up Now!", for: .normal)

        } else {
            loginType = .logIn
            authenticationButton.setTitle("Please Log In", for: .normal)

        }
    }

}
