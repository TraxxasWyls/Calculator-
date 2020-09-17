//
//  ViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

var compute = Notation()
//var left = 0 , right = 0

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var expression = ""
    
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
//        if left-right == 0{
        resultLabel.text = "="+String(compute.calculate(expression)).createOutput()
//        }
       
    }
    
    @IBAction func allclearPressed(_ sender: RoundButton) {
        expression = ""
        outputLabel.text = "0"
        resultLabel.text = ""
    }
    
    @IBAction func dottPressed(_ sender: RoundButton) {
        expression += "."
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
       outputLabel.text = String(compute.calculate(expression)).createOutput()
       resultLabel.text = ""
       expression = String(compute.calculate(expression))
        .replacingOccurrences(of: " ", with: "")
       
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
       expression += "+"
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        expression += "-"
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
       expression += "*"
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        expression += "/"
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func openPressed(_ sender: RoundButton) {
        expression += "("
        outputLabel.text = expression.createOutput()
        resultLabel.text = "="+String(compute.calculate(expression)).createOutput()
//        left+=1
    }
    
    @IBAction func closePressed(_ sender: RoundButton) {
        expression += ")"
        outputLabel.text = expression.createOutput()
//        right+=1
//        if left-right == 0{
            resultLabel.text = "="+String(compute.calculate(expression)).createOutput()
//        }
    }
    
}

