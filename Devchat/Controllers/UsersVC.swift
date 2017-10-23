//
//  UsersVC.swift
//  Devchat
//
//  Created by yoann lathuiliere on 23/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import Firebase

class UsersVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBAction func sendSnapPressed(_ sender: Any) {
    if let url = _videoURL {
      let videoName = "\(NSUUID().uuidString)-\(url)"
      let ref = DataService.sharedInstance.videoStorageRef.child(videoName)
      
      let task = ref.putFile(from: url, metadata: nil, completion: { (metadata, error) in
        if error != nil {
          // handle error
        } else {
          let downloadURL = metadata?.downloadURL()
          
          if let userUID = Auth.auth().currentUser?.uid, let downloadURL = downloadURL {
            DataService.sharedInstance.sendSnap(senderUID: userUID, sendingTo: self.selectedUsers, mediaURL: downloadURL, textSnippet: "Hey!")
            self.dismiss(animated: true, completion: nil)
          } else {
            // handle error
            self.dismiss(animated: true, completion: nil)
          }
          
        }
      })
    }
  }
  
  private var users = [User]()
  private var selectedUsers = Dictionary<String, User>()
  private var _imageData: Data?
  private var _videoURL: URL?
  
  var videoURL: URL? {
    get {
      return _videoURL
    }
    set {
      _videoURL = newValue
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.allowsMultipleSelection = true
    navigationItem.rightBarButtonItem?.isEnabled = true
    
    DataService.sharedInstance.getUsers { (error, users) in
      if let err = error {
        print(err)
      } else {
        if let users = users as? [User] {
          self.users = users
          self.tableView.reloadData()
        }
      }
    }
  }
}


extension UsersVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell {
      let user = users[indexPath.row]
      cell.updateUI(user: user)
      
      return cell
    }
    
    return UITableViewCell()
  }
}


extension UsersVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) as? UserCell {
      cell.setCheckmark(selected: true)
      let user = users[indexPath.row]
      selectedUsers[user.uid] = user
      
      if selectedUsers.count > 0 {
        navigationItem.rightBarButtonItem?.isEnabled = true
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) as? UserCell {
      cell.setCheckmark(selected: false)
      let user = users[indexPath.row]
      selectedUsers[user.uid] = nil
      
      if selectedUsers.count <= 0 {
        navigationItem.rightBarButtonItem?.isEnabled = false
      }
    }
  }
}
