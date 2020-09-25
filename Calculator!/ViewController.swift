//
//  ViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var compute = Notation()
    var inseration = Insert()
    var expression = "0"
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var outputLabel: SelectableLabel!
    
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
        outputLabel.pasteAction = { [weak self] text in
            guard let self = self else { return }
            self.expression = text
                .prepareForCreate()
            self.resultLabel.text = String((self.compute.calculate(self.expression))).createResult()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        saveData()
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if !expression.isEmpty && expression != "nan" && expression != "inf"
            && expression != "-inf"{
            expression.removeLast()
            outputLabel.text = expression.createOutput()
            resultLabel.text = String(compute.calculate(expression))
                .createResult()
        }
        if expression.isEmpty || expression == "nan" || expression == "inf"
            || expression == "-inf"{
            expression = "0"
            outputLabel.text = "0"
            resultLabel.text = ""
        }
    }
    
    @IBAction func numberPressed(_ sender: RoundButton) {
        outputLabel.sizeToFit()
        expression = inseration.insertOperation(expression, String(sender.tag))
        outputLabel.text = expression.createOutput()
        if expression != "0"{
        resultLabel.text = String(compute.calculate(expression)).createResult()
        }
        
        print(outputLabel.text)
        print(outputLabel.intrinsicContentSize)
        print(outputLabel.constraints)
        print(resultLabel.superview!.constraints)
        print("-----------------------------------")
//       outputLabel.font = UIFont.systemFont(ofSize: 25)
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
        .createResult()
        .replacingOccurrences(of: " ", with: "")
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
    }
    
    @IBAction func closePressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(expression, ")")
        if expression.filter({$0 == "("}).count
            == expression.filter({$0 == ")"}).count
            && expression.filter({$0 == ")"}).count != 0{
            resultLabel.text = String(compute.calculate(expression)).createResult()
        }
        outputLabel.text = expression.createOutput()
    }

}

