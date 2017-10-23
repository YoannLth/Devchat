//
//  ViewController.swift
//  Devchat
//
//  Created by yoann lathuiliere on 19/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class CameraVC: CameraViewController, CameraVCDelegate {
  func videoRecordingComplete(videoURL: URL) {
    performSegue(withIdentifier: "cameraToUsersVC", sender: ["videoURL": videoURL])
  }
  
  func videoRecordingFailed() {
    
  }
  
  func snapshotTaken(data: Data) {
    
  }
  
  func snapshotFailed() {
    
  }
  
  func shouldEnableRecordUI(enable: Bool) {
    recordingButton.isEnabled = enable
  }
  
  func shouldEnableCameraUI(enable: Bool) {
    changeCameraButton.isEnabled = enable
  }
  
  func canStartRecording() {
    print("Can start recording")
    recordingButton.imageView?.tintColor = UIColor.white
  }
  
  func recordingHasStarted() {
    print("Recording has started")
    recordingButton.imageView?.tintColor = UIColor.red
  }
  

  
  @IBOutlet weak var previewView: PreviewView!
  @IBOutlet weak var changeCameraButton: UIButton!
  @IBOutlet weak var recordingButton: UIButton!
  
  override func viewDidLoad() {
    self.delegate = self
    
    self._previewView = previewView
    self._previewView.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    
    super.viewDidLoad()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    //performSegue(withIdentifier: "homeToLogin", sender: nil)
    
    guard Auth.auth().currentUser != nil else {
      performSegue(withIdentifier: "homeToLogin", sender: nil)
      return
    }
  }
  
  
  @IBAction func recordButtonPressed(_ sender: Any) {
    initRecording()
    toggleMovieRecording()
  }
  
  // MARK: - Actions
  
  @IBAction func changeCameraButtonPressed(_ sender: Any) {
    changeCamera()
  }
  
  
  
  
  
  // MARK: - Functions
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let userVC = segue.destination as? UsersVC {
      if let dict = sender as? Dictionary<String, URL>, let url = dict["videoURL"] {
        userVC.videoURL = url
      }
    }
  }
}
