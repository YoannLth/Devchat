//
//  User.swift
//  Devchat
//
//  Created by yoann lathuiliere on 23/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation

struct User {
  private var _firstname: String
  private var _uid: String
  
  var firstname: String {
    return _firstname
  }
  
  var uid: String {
    return _uid
  }
  
  init(uid: String, firstname: String) {
    self._firstname = firstname
    self._uid = uid
  }
}
