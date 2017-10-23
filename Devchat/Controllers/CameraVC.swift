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
  func shouldEnableRecordUI(enable: Bool) {
    recordingButton.isEnabled = enable
    print("Ish ish")
  }
  
  func shouldEnableCameraUI(enable: Bool) {
    changeCameraButton.isEnabled = enable
    print("93 empire")
  }
  
  func canStartRecording() {
    print("Can start recording")
  }
  
  func recordingHasStarted() {
    print("Recording has started")
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
    guard Auth.auth().currentUser != nil else {
      performSegue(withIdentifier: "homeToLogin", sender: nil)
      return
    }
  }
  
  
  
  // MARK: - Actions
  @IBAction func recordButtonPressed(_ sender: Any) {
    initRecording()
    toggleMovieRecording()
  }
  @IBAction func changeCameraButtonPressed(_ sender: Any) {
    changeCamera()
  }
  
  
  
  
  
  // MARK: - Functions
  
}
