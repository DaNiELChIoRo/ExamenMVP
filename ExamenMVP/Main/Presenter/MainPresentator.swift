//
//  MainPresentator.swift
//  ExamenMVP
//
//  Created by Daniel Meneses on 01/03/20.
//  Copyright © 2020 Daniel Meneses. All rights reserved.
//

import UIKit

class MainPresentator: Presentator {
  var errorMessage: Dynamic<String>
  var processedSequence: Dynamic<String>
  var valueEntered: Dynamic<Bool>
  
  private var currentNumber = -2
  private var currentEntry = ""
  private var stillErrors = false
  
  init() {
    errorMessage = Dynamic("")
    processedSequence = Dynamic("")
    valueEntered = Dynamic(false)
  }
  
  func instantiate() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let view = storyboard.instantiateViewController(withIdentifier: "MainView") as! ViewController
    view.setup(presentator: self)
    
    return view
  }
  
  //MARK:- Protocol Methods
  func validateInput(_ input: String) {    
    if let lastInput = input.last, input.count > currentEntry.count {
      let errorMessage = checkLastInput(lastInput)
      !errorMessage.isEmpty ? processError(withErrors: errorMessage) : processSequence(input)
    } else {
      // Note:- called when erase
      input.isEmpty ? resetValues() : onErase(input)
    }
  }
  
  func processSequence(_ sequence: String) {
    guard !stillErrors else { return }
    var processedSequence = ""
    let length = sequence.count - 1
    guard length >= 2 else {
      self.processedSequence.value = ""
      return
    }
    for x in (0...length/2) {
      processedSequence.append(sequence[x])
      if sequence[x] != sequence[length-x] {
        processedSequence.append(sequence[length-x])
      }
    }
    self.processedSequence.value = processedSequence
  }
  
  //MARK:- Private Functions
  private func resetValues() {
    currentEntry = ""
    currentNumber = -2
  }
  
  private func onErase(_ value: String) {
    let errorsFromErase = checkLastInput(value.last!, true)
    if errorsFromErase.isEmpty {
      
      currentEntry = value
      currentNumber = Int(String(value.last!))!
      processSequence(value)
      
      stillErrors = false
      valueEntered.value = true
    } else {
      processError(withErrors: errorsFromErase)
    }
  }
  
  private func processError(withErrors errorMessage: String) {
    stillErrors = true
    self.errorMessage.value = errorMessage
  }
  
  private func checkLastInput(_ lastInput: Character, _ fromErase: Bool = false) -> String {
    guard let enteredNum = Int(String(lastInput)) else { return "Something really just bad happened!! 😱" }
    let isAlready = !fromErase ? currentEntry.contains(lastInput) : evaluateExistanceFromErase(lastInput)
    var errorMessage = ""
    switch (lastInput) {
    case _ where enteredNum == (currentNumber - 1):
      errorMessage += "\(enteredNum) precedesthe last entered number in the sequence\n"
    case _ where enteredNum == (currentNumber + 1):
      errorMessage += "\(enteredNum) is next to the last entered number in the sequence\n"
    case _ where isAlready:
      errorMessage += "The number \(enteredNum) already exists in the sequence"
    default:
      //TODO:- If it is from an earese
      if !fromErase {
        currentNumber = enteredNum
        currentEntry.append(lastInput)
      }
      stillErrors = false
    }
    return errorMessage
  }
  
  private func evaluateExistanceFromErase(_ remaningInput: Character) -> Bool {
    let lengthWithoutLast = currentEntry.count-3
    let c = currentEntry[...lengthWithoutLast]
    return c.contains(remaningInput)
  }
  
}
