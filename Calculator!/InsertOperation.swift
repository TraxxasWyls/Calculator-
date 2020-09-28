//
//  insertOperation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 20.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - Insert

final class Insert {

    // MARK: - Public

    public func insertOperation(
        _ operation: String,
        into input: String,
        basedOn algorithm: ParserAlgorithm
    ) -> String {
        var expression = input
        let error = expression == "nan" || expression == "-inf" || expression == "inf"
        if error {
            expression = "0"
        }
        switch operation {
        case "*", "/":
            return insertMultOrDiv(expression,operation)
        case "+":
            return insertPlus(expression)
        case "-":
            return insertMinus(expression)
        case "(":
            return insertOpen(expression)
        case ")":
            return insertClose(expression, using: algorithm)
        case ".":
            return insertDott(expression, using: algorithm)
        default:
            return insertNumber(expression,operation)
        }
    }

    // MARK: - Private

    private func insertMultOrDiv(_ expression: String, _ operation: String) -> String {
        let preLast = expression.dropLast(1).last
        if expression == "0" {
            return "0" + operation
        }
        guard let expressionLast = expression.last else {
            return "error"
        }
        if Int(String(expressionLast)) != nil || expressionLast == ")" {
            return expression + operation
        }
        if String(expressionLast) == operation
            || expressionLast == "("
            || (expressionLast == "-" && preLast == "(") {
            return expression
        }
        if (expressionLast == "-" && (preLast == "*" || preLast == "/")) {
            return "\(expression.dropLast(2) + operation)"
        }
        if expressionLast == "*" && operation == "/"
            || expressionLast == "/" && operation == "*"
            || expressionLast == "-" && (preLast != nil)
            || expressionLast == "+" {
            return "\(expression.dropLast() + operation)"
            
        }
        return expression
    }

    private func insertPlus(_ expression: String) -> String {
        let preLast = expression.dropLast(1).last
        if expression == "0" {
            return "0"
        }
        guard let expressionLast = expression.last else {
            return "error"
        }
        if Int(String(expressionLast)) != nil || expressionLast == ")"{
            return expression + "+"
        }
        if expressionLast == "(" || expressionLast == "+" || expressionLast == "-" && preLast == "(" {
            return expression
        }
        if (expressionLast == "-" && (preLast == "*" || preLast == "/")){
            return "\(expression.dropLast(2) + "+")"
        }
        if expressionLast == "*" || expressionLast == "/" || (expressionLast == "-" && (preLast != nil)) {
            return "\(expression.dropLast() + "+")"
            
        }
        return expression
    }

    private func insertMinus(_ expression: String) -> String{
        if expression == "0"{
            return "-"
        }
        guard let expressionLast = expression.last else {
            return "error"
        }
        if Int(String(expressionLast)) != nil
            || expressionLast == ")"
            || expressionLast == "("
            || expressionLast == "*"
            || expressionLast == "/" {
            return expression + "-"
        }
        if expressionLast == "-"{
            return expression
        }
        if expressionLast == "+"{
            return "\(expression.dropLast() + "-")"
            
        }
        return expression
    }

    private func insertOpen(_ expression: String) -> String{
        if expression == "0"{
            return "("
        }
        guard let expressionLast = expression.last else {
            return "error"
        }
        if Int(String(expressionLast)) != nil{
            return expression + "*("
        }
        if expressionLast == "."{
            return expression
        }
        if expressionLast == ")"{
            return expression + "*("
        }
        return expression + "("
        
    }

    private func insertClose(
        _ expression: String,
        using algorithm: ParserAlgorithm
    ) -> String {
        if expression == "0"{
            return "0"
        }
        guard let expressionLast = expression.last else {
            return "error"
        }
        if algorithm.isOperation(String(expressionLast)) && expressionLast != ")" {
            return expression
        }
        if expression.filter({ $0 == "(" }).count > expression.filter({ $0 == ")" }).count {
            if expressionLast == "."{
                return expression.dropLast() + ")"
            }
            return expression + ")"
        }
        return expression
    }

    private func insertDott(
        _ expression: String,
        using algorithm: ParserAlgorithm
    ) -> String{
        
        if expression.last == "." || expression.amountOfDottsInLastNum() > 0 {
            return expression
        }
        if let parsedLastString = algorithm.parse(expression).last, let parsedLast = Double(parsedLastString) {
            let number = String(parsedLast) 
            let preLast = number.dropLast(1).last
            if number.last == "0" && preLast == "." {
                return expression + "."
            }
        }
        return expression
    }

    private func insertNumber(_ expression: String, _ operation: String) -> String{
        expression == "0" ? operation : expression + operation
    }
}
