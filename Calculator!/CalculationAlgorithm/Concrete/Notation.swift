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

    private func deleteBrackets(_ input: [String]) -> [String] {
        var expression = input
        var n = 1
        while (n + 1) < expression.count && expression.count > 3 {
            if expression[n - 1] == "(" && Double(expression[n]) != nil && expression[n + 1] == ")" {
                expression.remove(at: n - 1)
                expression.remove(at: n)
                n = 0
            }
            n += 1
        }
        return expression
    }

    private func addBrackets(_ input: String) -> String{
        var expression = input
        var difference = expression.filter { $0 == "(" }.count - expression.filter { $0 == ")" }.count
        while (difference != 0) {
            expression.append(")")
            difference -= 1
        }
        return expression
    }

    private func notation(_ expression: [String]) -> [String] {
        func operationPriority(_ element: String) -> Int {
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
        var expression = notation(parse(addBrackets(expression.replacingOccurrences(of: "#", with: ""))))
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

    func isOperation(_ input: String) -> Bool {
        ["+", "-", "*", "/", "(", ")"].contains(input)
    }

    func parse(_ input: String) -> [String] {
        var expression: [String] = [""]
        var i = 0
        if Int(input.prefix(1)) != nil || input.prefix(1) == "(" || input.prefix(1) == "-" {
            for char in input {
                if Int(String(char)) != nil {
                    if Int(expression[i]) == nil {
                        expression.append(String(char))
                        i += 1
                    }
                    else {
                        expression[i] += String(char)
                    }
                }
                if char == "." {
                    expression[i] += String(char)
                }
                if isOperation(String(char)) {
                    i += 1
                    expression.append(String(char))
                }
            }
        } else {
            expression.append("Error")
            return expression
        }
        expression.remove(at: 0)
        var n = 1
        while n < expression.count {
            if expression[n - 1].last == "." && Int(expression[n]) != nil{
                expression[n - 1] = expression[n - 1] + expression[n]
                expression.remove(at: n)
            }
            if n != expression.count - 1 && isOperation(expression[n - 1])
                && expression[n] == "-" && Double(expression[n + 1]) != nil
                && expression[n - 1] != ")" {
                expression[n + 1] = "-" + expression[n + 1]
                expression.remove(at: n)
            }
            if n == 1 && expression[n - 1] == "-" && expression[n] == "(" {
                expression[n - 1] = "-1"
                expression.insert("*", at: n)
            }
            if n != expression.count - 1
                && (expression[n - 1] == "*" || expression[n - 1] == "/")
                && expression[n] == "-" && expression[n + 1] == "(" {
                expression.remove(at: n)
                expression.insert("-1", at: n - 1)
                expression.insert("*", at: n - 1)
            }
            if  n != expression.count - 1
                    && expression[n - 1] == "+"
                    && expression[n] == "-"
                    && expression[n + 1] == "(" {
                expression[n - 1] = "-"
                expression.remove(at: n)
            }
            if  n != expression.count - 1
                    && expression[n - 1] == "("
                    && expression[n] == "-"
                    && expression[n + 1] == "(" {
                expression.remove(at: n)
                expression.insert("-1", at: n)
                expression.insert("*", at: n + 1)
            }
            if n == 1 && expression[n - 1] == "-" && Double(expression[n]) != nil {
                expression[n - 1] = "-" + expression[n]
                expression.remove(at: n)
                n = 0
            }
            n += 1
        }
        return deleteBrackets(expression)
    }
}
