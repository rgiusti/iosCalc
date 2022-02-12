//
//  Operation.swift
//  iosCalc
//
//  Created by Rafael Giusti on 2/11/22.
//

import Foundation

enum InputState {
    case initial, cleared, allCleared, readingKeys
}

enum CalculationState {
    case initial, operationPerformed, xEntered, yEntered
}

enum Operation: String {
    case add="+"
    case substract="−"
    case multiply="×"
    case divide="÷"
    case equals="="
}

struct Calculation {
    let shortFormat = NumberFormatter()
    let longFormat = NumberFormatter()
    var x: Float = 0
    var y: Float!
    var result: Float!
    var operation = Operation.equals
    var inputState = InputState.initial
    var calcState = CalculationState.initial
    
    init() {
        shortFormat.maximumFractionDigits = 10
        longFormat.maximumFractionDigits = 100
    }
    
    func description() -> String {
        return String(format: "%@ %@ %@ = %@",
                      shortFormat.string(from: NSNumber(value:x))!,
                      operation.rawValue,
                      shortFormat.string(from: NSNumber(value:y))!,
                      shortFormat.string(from: NSNumber(value:result))!)
    }
    
    func partialDescription() -> String {
        return String(format: "%@ %@ ? = ?",
                      shortFormat.string(from: NSNumber(value:x))!,
                      operation.rawValue)
    }
    
    func resultString() -> String {
        return longFormat.string(from: NSNumber(value:result)) ?? "NaN"
    }
    
    mutating  func performOperation() {
        switch operation {
        case .add:
             result = x + y
        case .substract:
            result = x - y
        case .multiply:
            result = x * y
        case .divide:
            result = x / y
        default:
            result = 0
        }
    }
}
