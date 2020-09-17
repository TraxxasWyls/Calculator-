//
//  ViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

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

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var expression = ""
    var result = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0"
        resultLabel.text = "Ну рискни"
    }

    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
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
        outputLabel.text = "0"
        resultLabel.text = ""
    }
    
    @IBAction func dottPressed(_ sender: RoundButton) {
        dotisPressed = true
        expression += "#.#"
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
       dotisPressed = false
        outputLabel.text = String(compute.calculate(expression)).createOutput()
//       outputLabel.text = separatedNumber(compute.calculate(expression))
       resultLabel.text = ""
       
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
       dotisPressed = false
       expression += "#+#"
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        dotisPressed = false
        expression += "#-#"
        outputLabel.text = expression.createOutput()
        
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
       dotisPressed = false
       expression += "#*#"
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        dotisPressed = false
        expression += "#/#"
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func openPressed(_ sender: RoundButton) {
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
    }
    
}

