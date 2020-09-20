//
//  insertOperation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 20.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
final class Insert{
    public func insertOperation(_ expression: String,_ operation: String) -> String{
        switch operation {
        case "*","/": return insertMultOrDiv(expression,operation)
        case "+": return insertPlus(expression)
        case "-": return insertMinus(expression)
        case "(": return insertOpen(expression)
        case ")": return insertClose(expression)
        default: return ""
        }
    }
    private func insertMultOrDiv(_ expression: String,_ operation: String) -> String{
        let preLast = expression.dropLast(1)
        if expression == "0"{
            return "0"
        }
        if Int(String(expression.last!)) != nil
        || expression.last == ")"{
            return expression + operation
        }
        if String(expression.last!) == operation
            || expression.last == "("
            || (expression.last == "-" && (preLast.last == "*"
            || preLast.last == "/" || preLast.last == "(")){
            return expression
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
            || expression.last == "-" && (preLast.last == "*"
            || preLast.last == "/" || preLast.last == "("){
            return expression
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
        return expression + "("
    }
    private func insertClose(_ expression: String) -> String{
        if expression == "0"{
            return "0"
        }
        return expression + ")"
    }
    
}
