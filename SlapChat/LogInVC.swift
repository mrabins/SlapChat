//
//  LogInVC.swift
//  SlapChat
//
//  Created by Mark Rabins on 7/11/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: RoundTextField!
    @IBOutlet weak var passwordTextField: RoundTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {

        if let email = emailTextField.text, let password = passwordTextField.text, (email.characters.count > 6 && password.characters.count > 6) {
            
            // Call the login service
            AuthService.instance.login(email: email, password: password)
            
        } else {
            let alert = UIAlertController(title: "Username and Password Required", message: "You must enter both a username and password with a minimum of at least 6 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    
}
