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
  // MARK: - Variables
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
  
  var snapRef: DatabaseReference {
    return dbRef.child("snaps")
  }
  
  var mainStorageRef: StorageReference {
    return Storage.storage().reference()
  }
  
  var videoStorageRef: StorageReference {
    return mainStorageRef.child("videos")
  }
  
  
  
  
  
  // MARK: - Functions
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

  func getSnaps(uid: String, onComplete: @escaping Completion) {
    var returnedSnaps = [Message]()
    
    snapRef.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
      if let snaps = snapshot.value as? Dictionary<String, AnyObject> {
        for(_, value) in snaps {
          if let dict = value as? Dictionary<String, AnyObject> {
            //let x = dict["recipients"]
            if let recipients = dict["recipients"] as? [String] {
              for value in recipients {
                if let recipientUID = value as? String, recipientUID == uid {
                  if let text = dict["text"] as? String, let infos = dict["infos"] as? String, let mediaURL = dict["mediaURL"] as? String, let openCount = dict["openCount"] as? Int, let senderUID = dict["userID"] as? String {
                    let message = Message(senderUID: senderUID, text: text, mediaURL: mediaURL, openCount: openCount, infos: infos)
                    returnedSnaps.append(message)
                  }
                }
              }
            }
          }
        }
        
        onComplete(nil, returnedSnaps)
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
  
  func getUsername(from uid: String, onComplete: @escaping Completion) {
    userRef.child(uid).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
      if let dict = snapshot.value as? Dictionary<String, AnyObject> { //rm?
        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
          if let firstname = profile["firstname"] as? String {
            onComplete("", firstname)
          }
        }
      }
    }
  }
  
}
