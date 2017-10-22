//
//  RoundTextField.swift
//  Devchat
//
//  Created by yoann lathuiliere on 23/10/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedTextField: UITextField {
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    didSet {
      layer.borderColor = borderColor?.cgColor
    }
  }
  
  @IBInspectable var bgColor: UIColor? {
    didSet {
      backgroundColor = bgColor
    }
  }
  
  @IBInspectable var placeholderColor: UIColor? {
    didSet {
      let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
      let str = NSAttributedString(string: attributedPlaceholder!.string, attributes: [NSAttributedStringKey.foregroundColor : placeholderColor!])
      attributedPlaceholder = str
      
    }
  }
}
