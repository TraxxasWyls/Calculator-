//
//  Extensions.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 13.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

func separatedNumber(_ number: Any) -> String {
guard let itIsANumber = number as? NSNumber else { return "Not a number" }
let formatter = NumberFormatter()
formatter.numberStyle = .decimal
formatter.groupingSeparator = " "
formatter.decimalSeparator = "."
return formatter.string(from: itIsANumber)!
}
extension String {
private func changeChar() -> String{
      self
      .replacingOccurrences(of: "*", with:"×")
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
        
      .components(separatedBy: "#")
  }
    private func formateNum(_ input: [String] ) -> String {
          var result = ""
          var point = false
          for element in input {
            if Int(element) != nil && !point{
                result += separatedNumber(Double(element))
            } else { result += element }
            if element == "."{
                point = true
            } else { point = false }
          }
          return result
      }
    func createOutput() -> String{
        self.formateNum(self.tokinize()).changeChar()
      }
    func createResult() -> String{
        let result = self
        let preLast = result.dropLast(1)
            if self.last == "0" && preLast.last == "." {
                return separatedNumber(Double(self))
            }
        return self.createOutput()
    }
}
