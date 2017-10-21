//
//  ViewController.swift
//  Devchat
//
//  Created by yoann lathuiliere on 19/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: CameraViewController {

  
  @IBOutlet weak var previewView: PreviewView!
  
  override func viewDidLoad() {
    self._previewView = previewView
    self._previewView.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    
    super.viewDidLoad()
  }
  
  
  
  
  
  // MARK: - Actions
  @IBAction func recordButtonPressed(_ sender: Any) {
    toggleMovieRecording()
  }
  @IBAction func changeCameraButtonPressed(_ sender: Any) {
    changeCamera()
  }
}
