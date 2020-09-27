//
//  Extensions.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 13.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

extension String {

   private func separatedNumber() -> String {
        guard let itIsANumber = Double(self) as NSNumber? else { return "error" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        return formatter.string(from: itIsANumber)!
    }
    
    private func formateOperationSymbols() -> String{
        self.replacingOccurrences(of: "*", with:"×")
            .replacingOccurrences(of: "/", with:"÷")
            .replacingOccurrences(of: ".", with:",")
    }

    private func tokinize() -> [String] {
        self.replacingOccurrences(of: "*", with:"#*#")
            .replacingOccurrences(of: "/", with:"#/#")
            .replacingOccurrences(of: "-", with:"#-#")
            .replacingOccurrences(of: "+", with:"#+#")
            .replacingOccurrences(of: ".", with:"#.#")
            .replacingOccurrences(of: ")", with:"#)#")
            .replacingOccurrences(of: "(", with:"#(#")
            .replacingOccurrences(of: " ", with:"")
            .components(separatedBy: "#")
    }

    private func formateNum(_ input: [String] ) -> String {
        var result = ""
        var point = false
        for element in input {
            if Int(element) != nil && !point{
                result += element.separatedNumber()
            } else { result += element }
            if element == "."{
                point = true
            } else { point = false }
        }
        return result
    }

    func createOutput() -> String{
        formateNum(tokinize()).formateOperationSymbols()
    }

    func createResult() -> String{
        let result = self
        let preLast = result.dropLast(1).last
        if last == "0" && preLast == "."{
            return separatedNumber()
        }
        return createOutput()
    }

    func prepareForCreate() -> String{
        self.replacingOccurrences(of: "×", with:"*")
            .replacingOccurrences(of: "÷", with:"/")
            .replacingOccurrences(of: ",", with:".")
            .replacingOccurrences(of: " ", with:"")
    }
    
    func amountOfDottsInLastNum() -> Int {
        var count = 0
        for char in self {
            if ["+", "-", "*", "/", "(", ")"].contains(char){
                count = 0
            }
            if char == "."{
                count += 1
            }
        }
        return count
    }
}
