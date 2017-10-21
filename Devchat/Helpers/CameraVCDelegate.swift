//
//  CameraVCDelegate.swift
//  Devchat
//
//  Created by yoann lathuiliere on 21/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation

protocol CameraVCDelegate {
  func shouldEnableRecordUI(enable: Bool)
  func shouldEnableCameraUI(enable: Bool)
  func canStartRecording()
  func recordingHasStarted()
}
