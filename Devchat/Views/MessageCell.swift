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

    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var infosLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateUI(message: Message) {
        DataService.sharedInstance.getUsername(from: message.senderUID) { (error, username) in
            if let username = username as? String {
                self.usernameLabel.text = username
            }
        }
        
        self.infosLabel.text = message.infos
        
        if message.openCount > 0 {
            indicatorImageView.image = UIImage(named: "messageindicator1")!
        } else {
            indicatorImageView.image = UIImage(named: "messageindicator3")!
        }
    }
    
    
}
