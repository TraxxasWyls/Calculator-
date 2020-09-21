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
    
    func saveData(){
        UserDefaults.standard.set(expression, forKey: "expressionKey")
        UserDefaults.standard.synchronize()
    }
    func loadData(){
        if let temp = UserDefaults.standard.string(forKey: "expressionKey"){
            expression = temp
        }
    }
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        outputLabel.text = expression.createOutput()
        if expression != "0"{
        resultLabel.text = String(compute.calculate(expression)).createResult()
        } else {
            resultLabel.text = "Поехали"
          }
    }
    override func viewDidDisappear(_ animated: Bool) {
        saveData()
    }
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if !expression.isEmpty{
            expression.removeLast()
            outputLabel.text = expression.createOutput()
            resultLabel.text = String(compute.calculate(expression))
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
        resultLabel.text = String(compute.calculate(expression)).createResult()
    }
    
    @IBAction func allclearPressed(_ sender: RoundButton) {
        expression = "0"
        outputLabel.text = "0"
        resultLabel.text = ""
    }
    
    @IBAction func dottPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, ".")
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
       outputLabel.text = String(compute.calculate(expression)).createResult()
       resultLabel.text = ""
       expression = String(compute.calculate(expression))
        .replacingOccurrences(of: " ", with: "").createResult()
        .replacingOccurrences(of: ",", with: ".")
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
       expression = inseration.insertOperation(expression, "+")
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, "-")
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
       expression = inseration.insertOperation(expression, "*")
       outputLabel.text = expression.createOutput()
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, "/")
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func openPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, "(")
        outputLabel.text = expression.createOutput()
        resultLabel.text = String(compute.calculate(expression)).createResult()
    }
    
    @IBAction func closePressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, ")")
        resultLabel.text = String(compute.calculate(expression)).createResult()
        outputLabel.text = expression.createOutput()
    }
    
}

