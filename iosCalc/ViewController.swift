//
//  ViewController.swift
//  iosCalc
//
//  Created by Rafael Giusti on 2/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    var currentCalculation = Calculation()
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var lastCalculationLabel: UILabel!
    @IBOutlet weak var calculationsHistoryPicker: UIPickerView!
    @IBOutlet weak var dynamicClear: UIButton!
    @IBOutlet weak var calculationsHistoryTxtView: UITextView!
    
    @IBAction func modifierPressed(_ sender: UIButton) {
        
        switch sender.currentTitle {

        case "AC":
            if lastCalculationLabel.text == "AC" {
                dynamicClear.setTitle("HC", for: .normal)
            }

            resultLabel.text = "0"
            lastCalculationLabel.text = "AC"
            currentCalculation = Calculation()
            
        case "C":
            resultLabel.text = "0"
            dynamicClear.setTitle("AC", for: .normal)
            currentCalculation.inputState = .cleared

        case "DEL","❮☒":
            resultLabel.text = String(resultLabel.text!.dropLast())
            currentCalculation.inputState = .readingKeys

        case "±":
            if resultLabel.text != "0" {
                if resultLabel.text?.first == "-" {
                    resultLabel.text = String(resultLabel.text!.dropFirst())
                }else{
                    resultLabel.text = "-"+resultLabel.text!
                }
                currentCalculation.inputState = .readingKeys
            }
            
        case "HC":
            resultLabel.text = "0"
            lastCalculationLabel.text = "HC"
            currentCalculation = Calculation()
            calculationsHistoryTxtView.text = ""
            dynamicClear.setTitle("AC", for: .normal)
            
        default:
            resultLabel.text! += sender.currentTitle!
        }
    }
    
    @IBAction func numKeyPressed(_ sender: UIButton) {
        
        switch currentCalculation.inputState {
        case .initial,.cleared,.allCleared:
            resultLabel.text! = sender.currentTitle!
            currentCalculation.inputState = .readingKeys
            dynamicClear.setTitle("C", for: UIControl.State.normal)
        default:
            resultLabel.text! += sender.currentTitle!
        }
        
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        
        if currentCalculation.calcState != .xEntered {
            
            currentCalculation.operation = Operation(rawValue: sender.currentTitle!)!

            currentCalculation.x = Float(resultLabel.text!)!
            print("currentCalculation.x:",currentCalculation.x)
            currentCalculation.calcState = .xEntered
            
            currentCalculation.inputState = .cleared
            lastCalculationLabel.text = currentCalculation.partialDescription()

        }else{
            equalPressed(sender)
            operationPressed(sender)
        }

    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
    
        if currentCalculation.calcState != .operationPerformed {
            currentCalculation.y = Float(resultLabel.text!)!
            print("currentCalculation.y:",currentCalculation.y!)
        }
    
        currentCalculation.performOperation()
        resultLabel.text = currentCalculation.resultString()
        
        currentCalculation.calcState = .operationPerformed
        
        lastCalculationLabel.text = currentCalculation.description()
        
        calculationsHistoryTxtView.text = String(format: "%@\n", lastCalculationLabel.text!) + calculationsHistoryTxtView.text
        
        currentCalculation.x = currentCalculation.result
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

