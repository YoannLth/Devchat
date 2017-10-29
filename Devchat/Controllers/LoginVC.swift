//
//  LoginVC.swift
//  Devchat
//
//  Created by yoann lathuiliere on 23/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

  // MARK: - Outlets
  @IBOutlet weak var emailField: RoundedTextField!
  @IBOutlet weak var passwordField: RoundedTextField!

  
  
  
  // MARK: - Actions
  @IBAction func loginButtonPressed(_ sender: Any) {
    if let email = emailField.text, let password = passwordField.text, (email.characters.count > 0 && password.characters.count > 0) {
      AuthService.sharedInstance.login(email: email, password: password, onComplete: { (errMsg, data) in
        guard errMsg == nil else {
          let alert = UIAlertController(title: "Error", message: errMsg, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
          return
        }
        
        self.dismiss(animated: true, completion: nil)
      })
    } else {
      let alertView = UIAlertController(title: "Username and password required", message: "Please enter your username and password", preferredStyle: .alert)
      alertView.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
      present(alertView, animated: true, completion: nil)
    }
  }
}
