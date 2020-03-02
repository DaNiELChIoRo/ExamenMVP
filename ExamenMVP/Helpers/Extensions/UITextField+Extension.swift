//
//  CustomTextField.swift
//  ExamenMVP
//
//  Created by Daniel Meneses on 01/03/20.
//  Copyright © 2020 Daniel Meneses. All rights reserved.
//

import UIKit

extension UITextField {
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat {
         get {
             return layer.cornerRadius
         }
         set {
             layer.cornerRadius = newValue
             layer.masksToBounds = newValue > 0
         }
     }  
}
