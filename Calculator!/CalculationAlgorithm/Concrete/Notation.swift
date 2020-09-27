//
//  Notation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - Notation

final class Notation {

    // MARK: - Private
    private func operationPriority(_ element: String) -> Int {
        switch element {
        case ")":
            return -1
        case "+","-":
            return 1
        case "*","/":
            return 2
        default:
            return 0
        }
    }
    
    private func notation(_ expression: [String]) -> [String] {
        var output: [String] = []
        var stackofOperations = Stack<String>()
        var currentPriority = -1
        for element in expression{
            if Double(element) == nil{
                if element == "("{
                    stackofOperations.push(element)
                    currentPriority = -1
                    continue
                }
                if operationPriority(element) > currentPriority{
                    stackofOperations.push(element)
                    currentPriority = operationPriority(element)
                    continue
                }
                if operationPriority(element) == currentPriority {
                    if !stackofOperations.isEmpty(){
                        output.append(stackofOperations.pop())
                    }
                    stackofOperations.push(element)
                    continue
                } else {
                    while stackofOperations.topItem != nil && stackofOperations.topItem != "(" {
                        output.append(stackofOperations.pop())
                    }
                    if stackofOperations.topItem == "(" && element == ")"{
                        stackofOperations.pop()
                        if let priority = stackofOperations.topItem {
                            currentPriority = operationPriority(priority)
                        }
                    }
                    if element != ")" {
                        stackofOperations.push(element)
                        currentPriority = operationPriority(element)
                    }
                }
            } else {
                output.append(element)
            }
        }
        while !stackofOperations.isEmpty() {
            output.append(stackofOperations.pop())
        }
        return output
    }

}

// MARK: - CalculationAlgorithm

extension Notation: CalculationAlgorithm {

    func calculate(_ expression: String) -> Double {
        var expression = notation(parse(expression))
        var n = 2
        while n < expression.count {
            if
                let preLast = Double(expression[n - 2]),
                let last = Double(expression[n - 1]),
                isOperation(expression[n]) {
                switch expression[n] {
                case "+":
                    expression[n] = String(preLast + last)
                case "-":
                    expression[n] = String(preLast - last)
                case "*":
                    expression[n] = String(preLast * last)
                case "/":
                    expression[n] = String(preLast / last)
                default:
                    return -0
                }
                expression.remove(at: n - 2)
                expression.remove(at: n - 2)
                n = 2
                continue
            }
            n += 1
        }
        return Double(expression[0]) ?? 0
    }
}
