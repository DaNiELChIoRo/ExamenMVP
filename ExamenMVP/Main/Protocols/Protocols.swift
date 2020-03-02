//
//  Protocols.swift
//  ExamenMVP
//
//  Created by Daniel Meneses on 01/03/20.
//  Copyright © 2020 Daniel Meneses. All rights reserved.
//

import UIKit

protocol Presentator {
  var errorMessage: Dynamic<String> { get set }
  var processedSequence: Dynamic<String> { get set }
  var valueEntered: Dynamic<Bool> { get set }
    
  func validateInput(_ input: String)
  func processSequence(_ sequence: String)
}

protocol Presentable {
  func setup(presenter: Presentator)
}

