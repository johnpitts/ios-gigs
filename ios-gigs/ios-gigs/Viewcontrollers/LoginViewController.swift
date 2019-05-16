//
//  LoginViewController.swift
//  ios-gigs
//
//  Created by John Pitts on 5/16/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func authenticationButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func authenticationSegmentedControlChanged(_ sender: Any) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
}
