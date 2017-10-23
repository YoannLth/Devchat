//
//  DataService.swift
//  Devchat
//
//  Created by yoann lathuiliere on 23/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation
import Firebase

class DataService {
  private static let _sharedInstance = DataService()
  
  static var sharedInstance: DataService {
    return _sharedInstance
  }
  
  var dbRef: DatabaseReference {
    return Database.database().reference()
  }
  
  var userRef: DatabaseReference {
    return dbRef.child("users")
  }
  
  var mainStorageRef: StorageReference {
    return Storage.storage().reference()
  }
  
  var videoStorageRef: StorageReference {
    return mainStorageRef.child("videos")
  }
  
  func saveUser(uid: String) {
    let profile: Dictionary<String, Any> = ["firstname": "", "lastname": ""]
    dbRef.child("users").child(uid).child("profile").setValue(profile)
  }
  
  func getUsers(onComplete: @escaping Completion) {
    var returnedUsers = [User]()
    
    userRef.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
      if let users = snapshot.value as? Dictionary<String, AnyObject> {
        for(key, value) in users {
          if let dict = value as? Dictionary<String, AnyObject> {
            if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
              if let firstname = profile["firstname"] as? String {
                let uid = key
                let user = User(uid: uid, firstname: firstname)
                returnedUsers.append(user)
              }
            }
          }
        }
        
        onComplete(nil, returnedUsers)
      }
    }
  }
  
  func sendSnap(senderUID: String, sendingTo:Dictionary<String, User>, mediaURL: URL, textSnippet: String? = nil) {
    
    var uids = [String]()
    for uid in sendingTo.keys {
      uids.append(uid)
    }
    
    let pr: Dictionary<String, AnyObject> = ["mediaURL":mediaURL.absoluteString as AnyObject, "userID":senderUID as AnyObject,"openCount": 0 as AnyObject, "recipients":uids as AnyObject]
    
    dbRef.child("snaps").childByAutoId().setValue(pr)
  }
}
