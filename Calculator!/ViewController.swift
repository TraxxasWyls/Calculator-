//
//  ViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

// MARK: - ViewController

final class ViewController: UIViewController {

    // MARK: - Properties

    /// UserDefaults instance
    private let defaults: UserDefaults = .standard

    /// CalculationAlgorithm instance
    private let algorithm: CalculationAlgorithm = Notation()

    /// Insert instance
    private let inseration = Insert()

    /// Current expression
    private var expression = "0"

    // MARK: - IBOutlets
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var outputLabel: SelectableLabel!

    // MARK: - UIViewController

    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        outputLabel.autoAdjustFontSize = true
        outputLabel.text = expression.createOutput()
        if expression != "0" {
            resultLabel.text = String(algorithm.calculate(expression)).createResult()
        } else {
            resultLabel.text = "Поехали"
        }
        outputLabel.pasteAction = { [weak self] text in
            guard let self = self else { return }
            self.expression = text.prepareForCreate()
            self.resultLabel.text = String((self.algorithm.calculate(self.expression))).createResult()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        saveData()
    }

    // MARK: - Actions

    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if !expression.isEmpty && expression != "nan" && expression != "inf" && expression != "-inf" {
            expression.removeLast()
            outputLabel.text = expression.createOutput()
            resultLabel.text = String(algorithm.calculate(expression)).createResult()
        }
        if expression.isEmpty || expression == "nan" || expression == "inf" || expression == "-inf" {
            expression = "0"
            outputLabel.text = "0"
            resultLabel.text = ""
        }
    }
    
    @IBAction func numberPressed(_ sender: RoundButton) {
        outputLabel.sizeToFit()
        expression = inseration.insertOperation(String(sender.tag), into: expression, basedOn: algorithm)
        outputLabel.text = expression.createOutput()
        if expression != "0"{
            resultLabel.text = String(algorithm.calculate(expression)).createResult()
        }
    }
    
    @IBAction func allclearPressed(_ sender: RoundButton) {
        expression = "0"
        outputLabel.text = "0"
        resultLabel.text = ""
    }
    
    @IBAction func dottPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(".", into: expression, basedOn: algorithm)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
        outputLabel.text = String(algorithm.calculate(expression)).createResult()
        resultLabel.text = ""
        expression = String(algorithm.calculate(expression))
            .createResult()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: ".")
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("+", into: expression, basedOn: algorithm)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("-", into: expression, basedOn: algorithm)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("*", into: expression, basedOn: algorithm)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("/", into: expression, basedOn: algorithm)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func openPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("(", into: expression, basedOn: algorithm)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func closePressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(")", into: expression, basedOn: algorithm)
        let isExpressionHasClosingBrackets = expression.filter({ $0 == ")" }).count != 0
        let openingBracketsCount = expression.filter({ $0 == "(" }).count
        let closingBracketsCount = expression.filter({ $0 == ")" }).count
        let isExpressionBracketsAreExclusive = openingBracketsCount == closingBracketsCount
        if isExpressionBracketsAreExclusive && isExpressionHasClosingBrackets {
            resultLabel.text = String(algorithm.calculate(expression)).createResult()
        }
        outputLabel.text = expression.createOutput()
    }

    // MARK: - Private

    private func saveData() {
        defaults.set(expression, forKey: "expressionKey")
        defaults.synchronize()
    }

    private func loadData() {
        if let temp = defaults.string(forKey: "expressionKey"){
            expression = temp
        }
    }
}
