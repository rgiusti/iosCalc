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
    var x: Float = 0
    var y: Float!
    var result: Float!
    var operation = Operation.equals
    var inputState = InputState.initial
    var calcState = CalculationState.initial
    
    func description() -> String {
        return String(format: "%g %@ %g = %g",x,operation.rawValue,y,result)
    }
    
    func partialDescription() -> String {
        return String(format: "%g %@ ? = ?",x,operation.rawValue)
    }
    
    func resultString() -> String {
        return String(format: "%g", result)
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
