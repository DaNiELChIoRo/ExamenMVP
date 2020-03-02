//
//  ViewController.swift
//  ExamenMVP
//
//  Created by Daniel Meneses on 01/03/20.
//  Copyright © 2020 Daniel Meneses. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var textField: CustomTextField!
  @IBOutlet weak var wrongEntryLabel: UILabel!
  @IBOutlet weak var processedSequenceLabel: UILabel!
  
  private var presenter: Presentator?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupBinds()
  }
  
  func setup(presentator: Presentator) {
    self.presenter = presentator
  }
  
  //MARK:- Private Methods
  private func setupView() {
    textField.addTarget(self, action: #selector(onTextEntered(_:)), for: .editingChanged)
  }
  
  private func setupBinds() {
    presenter?.errorMessage.bind({ errorMessage in
      if !errorMessage.isEmpty {
        self.displayWrongEntryMesssage(withMessage: errorMessage)
        self.presenter?.errorMessage.value = ""
      }
    })
    
    presenter?.processedSequence.bind({ processedSequence in
      self.processedSequenceLabel.text = processedSequence
    })
    
    presenter?.valueEntered.bind({ _ in
      self.resetTextField()
    })
  }

  @objc private func onTextEntered(_ sender: UITextField) {
    guard let text = sender.text else { return }
    presenter?.validateInput(text)
  }
  
  private func textFieldError() {
    textField.layer.borderWidth = 1
    textField.layer.masksToBounds = true
    textField.layer.borderColor = UIColor.red.cgColor
    UIDevice.vibrate()
  }
  
  private func displayWrongEntryMesssage(withMessage error: String) {
    textFieldError()
    hideProcessedString()
    wrongEntryLabel.text = error
    wrongEntryLabel.alpha = 1
  }
  
  private func hideProcessedString() {
    processedSequenceLabel.alpha = 0
  }
  
  private func resetTextField() {
    textField.layer.borderColor = UIColor.clear.cgColor
    wrongEntryLabel.alpha = 0
    processedSequenceLabel.alpha = 1
  }
}

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
