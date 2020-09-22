//
//  insertOperation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 20.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
final class Insert{
    public func insertOperation(_ input: String,_ operation: String) -> String{
        var expression = input
        if expression == "nan" || expression == "-inf" || expression == "inf"{
              expression = "0"
        }
        switch operation {
        case "*","/": return insertMultOrDiv(expression,operation)
        case "+": return insertPlus(expression)
        case "-": return insertMinus(expression)
        case "(": return insertOpen(expression)
        case ")": return insertClose(expression)
        case ".": return insertDott(expression)
        default: return insertNumber(expression,operation)
        }
    }
    private func insertMultOrDiv(_ expression: String,_ operation: String) -> String{
        let preLast = expression.dropLast(1)
        if expression == "0"{
            return "0" + operation
        }
        if Int(String(expression.last!)) != nil
        || expression.last == ")"{
            return expression + operation
        }
        if String(expression.last!) == operation
            || expression.last == "("
            || (expression.last == "-" && preLast.last == "("){
            return expression
        }
        if (expression.last == "-" && (preLast.last == "*"
            || preLast.last == "/")){
            return "\(expression.dropLast(2) + operation)"
        }
        if expression.last == "*" && operation == "/"
            || expression.last == "/" && operation == "*"
            || expression.last == "-" && (preLast.last != nil) 
            || expression.last == "+"{
            return "\(expression.dropLast() + operation)"
            
        }
        return expression
    }
    private func insertPlus(_ expression: String) -> String{
        let preLast = expression.dropLast(1)
        if expression == "0"{
            return "0"
        }
        if Int(String(expression.last!)) != nil
        || expression.last == ")"{
            return expression + "+"
        }
        if expression.last == "(" || expression.last == "+"
            || expression.last == "-" && preLast.last == "("{
            return expression
        }
        if (expression.last == "-" && (preLast.last == "*"
            || preLast.last == "/")){
            return "\(expression.dropLast(2) + "+")"
        }
        if expression.last == "*" || expression.last == "/"
            || (expression.last == "-" && (preLast.last != nil)){
            return "\(expression.dropLast() + "+")"
            
        }
        return expression
    }
    private func insertMinus(_ expression: String) -> String{
        if expression == "0"{
            return "-"
        }
        if Int(String(expression.last!)) != nil
        || expression.last == ")"
        || expression.last == "("
        || expression.last == "*" || expression.last == "/"{
            return expression + "-"
        }
        if expression.last == "-"{
            return expression
        }
        if expression.last == "+"{
            return "\(expression.dropLast() + "-")"
            
        }
        return expression
    }
    private func insertOpen(_ expression: String) -> String{
        if expression == "0"{
            return "("
        }
        if Int(String(expression.last!)) != nil{
            return expression + "*("
        }
        if expression.last == "."{
            return expression
        }
        if expression.last == ")"{
            return expression + "*("
        }
        return expression + "("
        
    }
    private func insertClose(_ expression: String) -> String{
        if expression == "0"{
            return "0"
        }
        if compute.isOperation(String(expression.last!))
            && expression.last != ")"{
            return expression
        }
        if expression.filter({$0 == "("}).count
            > expression.filter({$0 == ")"}).count{
            if expression.last == "."{
                return expression.dropLast() + ")"
            }
            return expression + ")"
        }
        return expression
    }
    private func insertDott(_ expression: String) -> String{
        func amountOfDotts() -> Int{
            var count = 0
            for char in expression {
                if compute.isOperation(String(char)){
                    count = 0
                }
                if char == "."{
                    count += 1
                }
            }
            return count
        }
        if expression.last == "." || amountOfDotts() > 0 {
            return expression
        }
        if Double(compute.parse(expression).last!) != nil {
            let number = String(Double(compute.parse(expression).last!)!)
            let preLast = number.dropLast(1)
            if number.last == "0" && preLast.last == "." {
                    return expression + "."
            }
        }
        return expression
    }
    private func insertNumber(_ expression: String, _ operation: String) -> String{
        if expression == "0" {
            return operation
        }
        return expression + operation 
    }
}
