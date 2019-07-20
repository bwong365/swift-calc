//
//  CalculatorLogic.swift
//  FunctioningCalculator
//
//  Created by Ben Wong on 2019-07-19.
//  Copyright © 2019 Ben Wong. All rights reserved.
//

import UIKit

protocol CalculatorDelegate {
  func displayError(_ error: String)
}

struct CalculatorLogic {
  private var number: Double?
  private var operation: (number: Double, calcMethod: String)?
  var delegate: CalculatorDelegate?
  
  mutating func setNumber(_ number: Double) {
    self.number = number
  }
  
  mutating func calculate(_ symbol: String) -> Double? {
    guard let n = number else { return nil }
    switch symbol {
    case "AC":
      number = nil
      operation = nil
      return 0
    case "+/-":
      return n * -1
    case "%":
      return n / 100
    case "=":
      return performCalculation(n)
    default:
      operation = (number: n, calcMethod: symbol)
    }
    return n
  }
  
  private func performCalculation(_ number: Double) -> Double? {
    guard let (n1, calcMethod) = operation else { return nil }
    switch calcMethod {
    case "+":
      return n1 + number
    case "-":
      return n1 - number
    case "x":
      return n1 * number
    case "÷":
      guard number != 0 else {
        delegate?.displayError("Error: Divide by 0")
        return nil
      }
      return n1 / number
    default:
      return nil
    }
  }
  
  private func displayError(error: String) {
    delegate?.displayError(error)
  }
}
