//
//  Notation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

final class Notation{
    
    private func isOperation(_ input: String)->Bool{
        if input == "+" || input == "*" || input == "-" || input == "/"
            || input == "(" || input == ")"{
            return true
        }
        return false
    }
    private func deleteBrackets (_ input: [String]) -> [String]{
        var expression = input
        var n = 1
<<<<<<< HEAD
        while  n < expression.count{
=======
        while  (n + 1) < expression.count && expression.count > 3 {
>>>>>>> calculator
        if  expression[n-1] == "(" && Double(expression[n]) != nil
            && expression[n+1] == ")"{
            expression.remove(at: n-1)
            expression.remove(at: n)
        }
        n+=1
        }
        return expression
    }
   private func parse(_ input: String)->[String]{
            var expression : [String] = [""]
            var i = 0
            if Int(input.prefix(1)) != nil
                || input.prefix(1) == "("
                || input.prefix(1) == "-"{
                
            for char in input{
                
                if Int(String(char)) != nil{
                    if Int(expression[i]) == nil  { expression.append(String(char));i+=1 }
                    else { expression[i] += String(char) }
                }
                if char == "." { expression[i] += String(char)}
            
                if isOperation(String(char)){
                    i+=1
                    expression.append(String(char))             }
            }
            }else { expression.append( "Error" ); return expression}
    expression.remove(at: 0)
    var n = 1
    while  n < expression.count{
<<<<<<< HEAD
        
        if expression[n-1].last == "." && Int(expression[n]) != nil{
            expression[n-1]=expression[n-1]+expression[n]
=======

        if expression[n-1].last == "." && Int(expression[n]) != nil{
            expression[n-1] = expression[n-1]+expression[n]
>>>>>>> calculator
            expression.remove(at: n)
        }
        if n != expression.count-1 && isOperation(expression[n-1])
            && expression[n] == "-" && Double(expression[n+1]) != nil
            && expression[n-1] != ")" {
            expression[n+1]="-"+expression[n+1]
            expression.remove(at: n)
        }
        if n == 1 && expression[n-1] == "-" && expression[n] == "(" {
            expression[n-1]="-1"
            expression.insert("*", at: n)
        }
<<<<<<< HEAD
        if  (expression[n-1] == "*" || expression[n-1] == "/")
=======
        if  n != expression.count-1 && (expression[n-1] == "*" || expression[n-1] == "/")
>>>>>>> calculator
            && expression[n] == "-" && expression[n+1] == "("{
            expression.remove(at: n)
            expression.insert("-1", at: n-1)
            expression.insert("*", at: n-1)
        }
<<<<<<< HEAD
        if  expression[n-1] == "+" && expression[n] == "-" && expression[n+1] == "("{
            expression[n-1]="-"
            expression.remove(at: n)
        }
        if  expression[n-1] == "(" && expression[n] == "-" && expression[n+1] == "("{
=======
        if  n != expression.count-1 && expression[n-1] == "+" && expression[n] == "-" && expression[n+1] == "("{
            expression[n-1]="-"
            expression.remove(at: n)
        }
        if  n != expression.count-1 && expression[n-1] == "(" && expression[n] == "-" && expression[n+1] == "("{
>>>>>>> calculator
            expression.remove(at: n)
            expression.insert("-1", at: n)
            expression.insert("*", at: n+1)
        }
<<<<<<< HEAD
=======
        
>>>>>>> calculator
        if n == 1 && expression[n-1] == "-" && Double(expression[n]) != nil {
            expression[n-1]="-"+expression[n]
            expression.remove(at: n)
            n = 0
        }
        n+=1
        }
        return deleteBrackets(expression)
    }
    private func notation(_ expression :[String]) -> [String]{
        func operationPriority(_ element: String) -> Int {
            switch element {
            case ")": return -1
            case "+","-": return 1
            case "*","/": return 2
            default: return 0
            }
        }
          var output : [String] = []
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
                }else {
                    while stackofOperations.topItem != nil
                    && stackofOperations.topItem != "(" {
                        output.append(stackofOperations.pop())
                    }
                    if stackofOperations.topItem == "(" && element == ")"{
                        stackofOperations.pop()
                        if let priority = stackofOperations.topItem{
                        currentPriority = operationPriority(priority)
                        }
                    }
                    if element != ")" {
                        stackofOperations.push(element)
                        currentPriority = operationPriority(element)
                    }
                }
            }else {
                output.append(element)
                
            }
        }
            while !stackofOperations.isEmpty(){
            output.append(stackofOperations.pop())
            }
    return output
    }
    func calculate(_ expression : String) -> Double{
<<<<<<< HEAD
        var expression = notation(parse(expression))
=======
        var expression = notation(parse(expression.replacingOccurrences(of: "#", with:"")))
>>>>>>> calculator
        var result : Double
        var n = 2
        while n < expression.count{
            if Double(expression[n-2]) != nil
               && Double(expression[n-1]) != nil
                && isOperation(expression[n]){
                switch expression[n] {
                case "+": expression[n] = String(Double(expression[n-2])! + Double(expression[n-1])!)
                case "-": expression[n] = String(Double(expression[n-2])! - Double(expression[n-1])!)
                case "*": expression[n] = String(Double(expression[n-2])! * Double(expression[n-1])!)
                case "/": expression[n] = String(Double(expression[n-2])! / Double(expression[n-1])!)
                default: return -0
                }
                expression.remove(at: n-2)
                expression.remove(at: n-2)
                n=2
                continue
            }
        n+=1
        }
<<<<<<< HEAD
        result = Double(expression[0])!
=======
        if Double(expression[0]) != nil {
        result = Double(expression[0])!
        } else { result = 0 }
>>>>>>> calculator
        return result
    }

}

