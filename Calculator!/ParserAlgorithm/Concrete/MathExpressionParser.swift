//
//  MathExpressionParser.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 28.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - MathExpressionParser

final class MathExpressionParser: ParserProtocol {
    
    // MARK: - Private
    
    private func deleteBrackets(_ input: [String]) -> [String] {
        var expression = input
        var n = 1
        while (n + 1) < expression.count && expression.count > 2 {
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
        while (difference > 0) {
            expression.append(")")
            difference -= 1
        }
        return expression
    }

    // MARK: - Useful
    
    func parse(_ input: String) -> [String] {
        var expression: [String] = [""]
        var i = 0
        let input = addBrackets(input.replacingOccurrences(of: "#", with: ""))
        let firstElmentIsNum = Int(input.prefix(1)) != nil
        let parsable = firstElmentIsNum || input.prefix(1) == "(" || input.prefix(1) == "-"
        if parsable {
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
            return ["error"]
        }
        expression.remove(at: 0)
        var n = 1
        while n < expression.count {
            // First position check
            if n == 1{
                if expression[n - 1] == "-" && expression[n] == "(" {
                    expression[n - 1] = "-1"
                    expression.insert("*", at: n)
                }
                // - ( -> -1*(
                if expression[n - 1] == "-" && Double(expression[n]) != nil {
                    expression[n - 1] = "-" + expression[n]
                    expression.remove(at: n)
                }
                // - 3 -> (-3)
            }
            // Three elements are available for check
            if (n + 1) < expression.count && expression.count > 2 {
                if expression[n] == "-" && expression[n + 1] == "(" {
                    if (expression[n - 1] == "*" || expression[n - 1] == "/") {
                        expression.remove(at: n)
                        expression.insert("-1", at: n - 1)
                        expression.insert("*", at: n - 1)
                    }
                    // * - ( -> *(-1)*(
                    if expression[n - 1] == "+" {
                        expression[n - 1] = "-"
                        expression.remove(at: n)
                    }
                    // + - ( -> -(
                    if expression[n - 1] == "(" {
                        expression.remove(at: n)
                        expression.insert("-1", at: n)
                        expression.insert("*", at: n + 1)
                    }
                    // ( - ( -> ((-1)*(
                }
                if  isOperation(expression[n - 1]) && expression[n] == "-",
                    Double(expression[n + 1]) != nil,
                    expression[n - 1] != ")" {
                    expression[n + 1] = "-" + expression[n + 1]
                    expression.remove(at: n)
                }
                // * - 3 -> *(-3)
            }
            // Concatinate decimals
            if expression[n - 1].last == "." && Int(expression[n]) != nil {
                expression[n - 1] = expression[n - 1] + expression[n]
                expression.remove(at: n)
            }
            // 3. 12 -> 3.12
            n += 1
        }
        return deleteBrackets(expression)
    }
}
