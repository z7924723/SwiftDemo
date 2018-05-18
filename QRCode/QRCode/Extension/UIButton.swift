//
//  UIButton.swift
//  QRCode
//
//  Created by PinguMac on 2018/5/18.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

@IBDesignable
class TestButton: UIButton {
  @IBInspectable var borderColor: UIColor? {
    get {
      return UIColor(cgColor: layer.borderColor!)
    }
    
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }
}
