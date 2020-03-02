//
//  CustomTextField.swift
//  ExamenMVP
//
//  Created by Daniel Meneses on 02/03/20.
//  Copyright © 2020 Daniel Meneses. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
 
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false
  }
  
}
