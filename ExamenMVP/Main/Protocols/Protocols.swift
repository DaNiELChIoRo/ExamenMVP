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

protocol Storyboarded {
  func instantiate(fromStoryboard nibName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
  func instantiate(fromStoryboard nibName:String) -> Self {
    let id = String(describing: self)
    let storyboard = UIStoryboard(name: nibName, bundle: Bundle.main)
    return storyboard.instantiateViewController(withIdentifier: id) as! Self
  }
}
