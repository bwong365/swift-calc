//
//  ViewController.swift
//  FunctioningCalculator
//
//  Created by Ben Wong on 2019-07-19.
//  Copyright © 2019 Ben Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  private var isFinishedTypingNum = true
  private var displayValue: Double {
    get {
      guard let number = Double(resultsLabel.text!) else {
        return 0
      }
      return number
    }
    set {
      if newValue == newValue.rounded(.towardZero) {
        resultsLabel.text = String(Int(newValue))
      } else {
        resultsLabel.text = String(newValue)
      }
    }
  }
  private var calculator = CalculatorLogic()
  
  @IBOutlet weak var resultsLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    calculator.delegate = self
  }

  @IBAction func calcButtonPressed(_ sender: UIButton) {
    isFinishedTypingNum = true
    guard let calcMethod = sender.currentTitle else {
      fatalError("Couldn't get operator from button")
    }
    
    calculator.setNumber(displayValue)
    displayValue = calculator.calculate(calcMethod) ?? displayValue
  }
  
  @IBAction func numButtonPressed(_ sender: UIButton) {
    guard let numValue = sender.currentTitle else { return }
    isFinishedTypingNum ? replaceDisplay(with: numValue) : appendToDisplay(with: numValue)
  }
}

extension ViewController {
  private func replaceDisplay(with numValue: String) {
    resultsLabel.text = numValue
    isFinishedTypingNum = false
  }
  
  private func appendToDisplay(with numValue: String) {
    if numValue == "." && resultsLabel.text!.contains(".") { return }
    resultsLabel.text? += numValue
  }
}

extension ViewController: CalculatorDelegate {
  func displayError(_ error: String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
      self.resultsLabel.text = error
    }
  } 
}
