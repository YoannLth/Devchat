//
//  MessagesVC.swift
//  Devchat
//
//  Created by yoann lathuiliere on 24/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import Firebase
import Player

class MessagesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [Message]()
    var player: Player?
    var snapText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.sharedInstance.getSnaps(uid: (Auth.auth().currentUser?.uid)!) { (error, snaps) in
            if let messages = snaps as? [Message] {
                self.messages = messages
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension MessagesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell {
            let message = messages[indexPath.row]
            cell.updateUI(message: message)
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension MessagesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.player = Player()
        self.player!.playbackDelegate = self
        self.player?.view.frame = self.view.bounds
        
        self.addChildViewController(self.player!)
        self.view.addSubview(self.player!.view)
        self.player!.didMove(toParentViewController: self)
        
        let videoUrl: URL = URL(string: messages[indexPath.row].mediaURL)!
        self.snapText = messages[indexPath.row].text
        self.player!.url = videoUrl
        
        self.player!.playFromBeginning()
        
        self.player!.fillMode = PlayerFillMode.resizeAspectFit.avFoundationType
    }
}

extension MessagesVC: PlayerPlaybackDelegate {
    func playerCurrentTimeDidChange(_ player: Player) {
        
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let viewHeight = CGFloat(40)
        let idealPos = (screenHeight/2) - CGFloat((viewHeight/2))
        let customView = UIView(frame: CGRect(x: 0, y: idealPos, width: screenWidth, height: viewHeight))
        customView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.player!.view.addSubview(customView)
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: viewHeight))
        label.textAlignment = .center
        label.text = self.snapText!
        label.textColor = UIColor.white
        
        customView.addSubview(label)
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        self.player?.dismiss(animated: true, completion: nil)
        self.player = nil
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        
    }
    
    
}
