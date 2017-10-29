//
//  MessageCell.swift
//  Devchat
//
//  Created by yoann lathuiliere on 24/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {
  
  // MARK: - Outlets
  @IBOutlet weak var indicatorImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var infosLabel: UILabel!
  
  
  
  
  
  // MARK: - Actions
  func updateUI(message: Message) {
    DataService.sharedInstance.getUsername(from: message.senderUID) { (_, username) in
      if let username = username as? String {
        self.usernameLabel.text = username
      }
    }
    
    self.infosLabel.text = message.infos
  }
  
}
