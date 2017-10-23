//
//  UserCell.swift
//  Devchat
//
//  Created by yoann lathuiliere on 23/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
  
  @IBOutlet weak var username: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.setCheckmark(selected: false)
  }
  
  func updateUI(user: User) {
    self.username.text = user.firstname
  }
  
  func setCheckmark(selected: Bool) {
    let imgStr = selected ? "messageindicatorchecked1" : "messageindicator1"
    self.accessoryView = UIImageView(image: UIImage(named: imgStr))
  }
}
