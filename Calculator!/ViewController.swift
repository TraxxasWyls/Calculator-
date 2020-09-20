//
//  ViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

var compute = Notation()
var inseration = Insert()

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var expression = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0"
        resultLabel.text = "Ну рискни"
    }

    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if !expression.isEmpty{
            expression.removeLast()
            outputLabel.text = expression.createOutput()
            resultLabel.text = "= " + String(compute.calculate(expression))
                .createResult()
        }
        if expression.isEmpty{
            expression = "0"
            outputLabel.text = "0"
            resultLabel.text = ""
        }
    }
    
    @IBAction func numberPressed(_ sender: RoundButton) {
        if expression == "0" { expression = "\(sender.tag)" }
        else { expression += "\(sender.tag)" }
        outputLabel.text = expression.createOutput()
        resultLabel.text = "= " + String(compute.calculate(expression)).createResult()
    }
    
    @IBAction func allclearPressed(_ sender: RoundButton) {
        expression = "0"
        outputLabel.text = "0"
        resultLabel.text = ""
    }
    
    @IBAction func dottPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, ".")
//        expression += "."
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
       outputLabel.text = String(compute.calculate(expression)).createResult()
       resultLabel.text = ""
       expression = String(compute.calculate(expression))
        .replacingOccurrences(of: " ", with: "").createResult()
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
       expression = inseration.insertOperation(expression, "+")
//       expression += "+"
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, "-")
//        if expression == "0"{
//        expression = "-"
//        } else { expression += "-" }
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
       expression = inseration.insertOperation(expression, "*")
//       expression += "*"
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, "/")
//        expression += "/"
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func openPressed(_ sender: RoundButton) {
        if expression == "0"{
        expression = "("
        } else { expression += "(" }
        outputLabel.text = expression.createOutput()
        resultLabel.text = "= " + String(compute.calculate(expression)).createResult()
    }
    
    @IBAction func closePressed(_ sender: RoundButton) {
        if expression != "0"{
        expression += ")"
        resultLabel.text = "= " + String(compute.calculate(expression)).createResult()
        }
        outputLabel.text = expression.createOutput()
    }
    
}

