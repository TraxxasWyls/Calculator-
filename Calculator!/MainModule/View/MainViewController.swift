//
//  MainViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit
import CoreData

// MARK: - MainViewController

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    /// UserDefaults instance
    private let defaults: UserDefaults = .standard
    
    /// ParserAlgorithm  instance
    private let parser: ParserProtocol = MathExpressionParser()
    
    /// CalculationAlgorithm instance
    private lazy var algorithm: CalculationAlgorithm = Notation(parser: parser)
    
    /// HistoryServiceImplementation inctance
    private let historyService = HistoryAssembly().createHistoryService()
    
    /// Insert instance
    private let inseration = Insert()
    
    /// Current expression
    private var expression = "0"
    
    /// Sampler inctance
    let sampler = Sampler(delay: 0.1)
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        saveData()
    }
    
    // MARK: - Actions
    
    @IBAction func historyPressed(_ sender: UIButton) {
        let nextScreen = HistoryAssembly().createHistoryScreen()
        nextScreen.delegate = self
        let navigationController = UINavigationController(rootViewController: nextScreen)
        present(navigationController, animated: true)
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
            let historyObject = createHistoryPlainObject()
            sampler.sample {
                self.historyService.saveHistory(object: historyObject)
            }
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
    
    private func createHistoryPlainObject() -> HistoryPlainObject {
        let result = String(algorithm.calculate(expression)).createResult()
        let date = NSDate() as Date
        let leftOffset = Int.min
        let rightOffset = Int.max - Int(date.timeIntervalSince1970)
        let id = Int(date.timeIntervalSince1970) + Int.random(in: leftOffset..<rightOffset)
        return HistoryPlainObject(
            expression: expression,
            result: result,
            date: date,
            id: id
        )
    }
}

extension MainViewController: MainViewControllerDelegate {
    func update(expression: String) {
        self.expression = expression
        outputLabel.text = expression.createOutput()
        resultLabel.text = String(algorithm.calculate(expression)).createResult()
    }
}
