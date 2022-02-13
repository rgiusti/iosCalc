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
        shortFormat.maximumFractionDigits = 4
        longFormat.maximumFractionDigits = 6
    }
    
    func description() -> String {
        return String(format: "%@ %@ %@ = %@",
                      shortFormat.string(for: x)!,
                      operation.rawValue,
                      shortFormat.string(for: y)!,
                      shortFormat.string(for: result)!)
    }
    
    func partialDescription() -> String {
        return String(format: "%@ %@ ? = ?",
                      shortFormat.string(for: x)!,
                      operation.rawValue)
    }
    
    func resultString() -> String {
        return longFormat.string(for: result) ?? "NaN"
    }
    
    mutating  func performOperation() {
        print("x:",x," y:",y!)
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
        print("result:",result!)
    }
}
