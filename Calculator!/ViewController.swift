//
//  ViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

<<<<<<< HEAD
func lastIsOperation(_ input: String) -> Bool{
    switch input.last{
        case "+": return true
        case "*": return true
        case "/": return true
    default: return false
    }
}

var compute = Notation()
var i = 0 , n = 0
var dotisPressed = false
var countofNum = 0
=======
var compute = Notation()
>>>>>>> calculator

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
<<<<<<< HEAD
    var expression = ""
    var result = ""
   
=======
    var expression = "0"

>>>>>>> calculator
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0"
        resultLabel.text = "Ну рискни"
    }

    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
<<<<<<< HEAD
        expression.removeLast()
        outputLabel.text = expression.createOutput()
        resultLabel.text =  "="+String(compute.calculate(expression)).createOutput()
    }
    
    @IBAction func numberPressed(_ sender: RoundButton) {
        expression += "\(sender.tag)"
        outputLabel.text = expression.createOutput()
        if i-n == 0{
        resultLabel.text = String(compute.calculate(expression)).createOutput()
//        resultLabel.text = "="+separatedNumber(compute.calculate(expression))
        }
       
    }
    
    @IBAction func allclearPressed(_ sender: RoundButton) {
        expression = ""
        result = ""
        dotisPressed = false
=======
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
>>>>>>> calculator
        outputLabel.text = "0"
        resultLabel.text = ""
    }
    
    @IBAction func dottPressed(_ sender: RoundButton) {
<<<<<<< HEAD
        dotisPressed = true
        expression += "#.#"
=======
        expression += "."
>>>>>>> calculator
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
<<<<<<< HEAD
       dotisPressed = false
        outputLabel.text = String(compute.calculate(expression)).createOutput()
//       outputLabel.text = separatedNumber(compute.calculate(expression))
       resultLabel.text = ""
       
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
       dotisPressed = false
       expression += "#+#"
=======
       outputLabel.text = String(compute.calculate(expression)).createResult()
       resultLabel.text = ""
       expression = String(compute.calculate(expression))
        .replacingOccurrences(of: " ", with: "").createResult()
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
       expression += "+"
>>>>>>> calculator
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
<<<<<<< HEAD
        dotisPressed = false
        expression += "#-#"
        outputLabel.text = expression.createOutput()
        
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
       dotisPressed = false
       expression += "#*#"
=======
        if expression == "0"{
        expression = "-"
        } else { expression += "-" }
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
       expression += "*"
>>>>>>> calculator
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
<<<<<<< HEAD
        dotisPressed = false
        expression += "#/#"
=======
        expression += "/"
>>>>>>> calculator
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func openPressed(_ sender: RoundButton) {
<<<<<<< HEAD
        dotisPressed = false
        expression += "#(#"
        outputLabel.text = expression.createOutput()
        i+=1
    }
    
    @IBAction func closePressed(_ sender: RoundButton) {
        dotisPressed = false
        expression += "#)#"
        outputLabel.text = expression.createOutput()
        n+=1
        if i-n == 0{
        resultLabel.text = String(compute.calculate(expression)).createOutput()
//        resultLabel.text = "="+separatedNumber(compute.calculate(expression))
        }
=======
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
>>>>>>> calculator
    }
    
}

