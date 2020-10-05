//
//  ViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit
import CoreData

// MARK: - ViewController

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    /// UserDefaults instance
    private let defaults: UserDefaults = .standard
    
    /// ParserAlgorithm  instance
    private let parser: ParserAlgorithm = Parser()
    
    /// CalculationAlgorithm instance
    private lazy var algorithm: CalculationAlgorithm = Notation(basedOn: parser)
    
    /// Insert instance
    private let inseration = Insert()
    
    /// Current expression
    private var expression = "0"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var outputLabel: SelectableLabel!
    @IBOutlet weak var ScrollOutput: UIScrollView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        view.backgroundColor = .black
        outputLabel.autoAdjustFontSize = true
        outputLabel.minFontScale = 1
        outputLabel.maxFontSize = 75
        outputLabel.text = expression.createOutput()
        ScrollOutput.addSubview(outputLabel)
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
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        saveData()
    }
    
    // MARK: - Actions
    
    @IBAction func historyPressed(_ sender: UIButton) {
        let nextScreen = HistoryScreen()
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        let notError = expression != "nan" && expression != "inf" && expression != "-inf"
        if !expression.isEmpty && notError {
            expression.removeLast()
            outputLabel.text = expression.createOutput()
            resultLabel.text = String(algorithm.calculate(expression)).createResult()
        }
        let error = expression == "nan" || expression == "-inf" || expression == "inf"
        if expression.isEmpty || error {
            expression = "0"
            outputLabel.text = "0"
            resultLabel.text = ""
        }
    }
    
    @IBAction func numberPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(String(sender.tag), into: expression, basedOn: parser)
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
        expression = inseration.insertOperation(".", into: expression, basedOn: parser)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
        if expression != "0" {
        saveToBase()
        }
        outputLabel.text = String(algorithm.calculate(expression)).createResult()
        resultLabel.text = ""
        expression = String(algorithm.calculate(expression))
            .createResult()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: ".")
    }
    
    @IBAction func plusPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("+", into: expression, basedOn: parser)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func minusPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("-", into: expression, basedOn: parser)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("*", into: expression, basedOn: parser)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("/", into: expression, basedOn: parser)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func openPressed(_ sender: RoundButton) {
        expression = inseration.insertOperation("(", into: expression, basedOn: parser)
        outputLabel.text = expression.createOutput()
    }
    
    @IBAction func closePressed(_ sender: RoundButton) {
        expression = inseration.insertOperation(")", into: expression, basedOn: parser)
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
        defaults.set(resultLabel.text, forKey: "resultKey")
        defaults.set(NSDate(),forKey: "dateKey")
        defaults.synchronize()
    }
    
    private func loadData() {
        if let exp = defaults.string(forKey: "expressionKey"),
           let res = defaults.string(forKey: "resultKey"){
            expression = exp
            resultLabel.text = res
        }
    }
    
    private func saveToBase() {
        // Создание нового объекта
        let managedObject = History()
        // Установка значения атрибута
        managedObject.expression = expression
        managedObject.result = String(algorithm.calculate(expression)).createResult()
        managedObject.date = NSDate() as Date
        CoreDataManager.instance.saveContext()
    }
    
}
