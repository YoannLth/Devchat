//
//  ViewController.swift
//  Devchat
//
//  Created by yoann lathuiliere on 19/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController {

  
  @IBOutlet weak var previewView: AAPLPreviewView!
  
  override func viewDidLoad() {
    self._previewView = previewView
    
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
