//
//  AuthService.swift
//  Devchat
//
//  Created by yoann lathuiliere on 23/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMessage: String?, _ data: Any?) -> Void

class AuthService {
  // MARK: - Variables
  private static let _sharedInstance = AuthService()
  
  static var sharedInstance: AuthService {
    return _sharedInstance
  }
  
  
  
  
  
  
  // MARK: - Functions
  func createUser(email: String, password: String, onComplete: Completion?) {
    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
      if let err = error {
        self.handleFirebaseError(error: err, onComplete: onComplete)
      } else {
        if let userUID = user?.uid {
          DataService.sharedInstance.saveUser(uid: userUID)
          self.login(email: email, password: password, onComplete: onComplete)
        }
      }
    })
  }
  
  func login(email: String, password: String, onComplete: Completion?) {
    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
      if let err = error, let errorCode = AuthErrorCode(rawValue: err._code) {
        if errorCode == AuthErrorCode.userNotFound {
          self.createUser(email: email, password: password, onComplete: onComplete)
        } else {
          self.handleFirebaseError(error: err, onComplete: onComplete)
        }
      } else {
        onComplete?(nil, user)
      }
    })
  }
  
  func handleFirebaseError(error: Error, onComplete: Completion?) {
    if let err = AuthErrorCode(rawValue: error._code) {
      switch (err) {
      case .invalidEmail:
        onComplete?("Invalid email adress", nil)
        break
      case .wrongPassword:
        onComplete?("Invalid password", nil)
        break
      default:
        print("Error: \(error)")
        print("Error value: \(err.rawValue)")
        onComplete?("Problem on auth", nil)
        break
      }
    }
  }
}
