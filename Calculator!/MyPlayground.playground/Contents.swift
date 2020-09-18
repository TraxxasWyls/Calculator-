
  
import UIKit
import PlaygroundSupport

struct Stack<Element>{
    
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

var expression : [String] = [""]

func isOperation(_ input: String)->Bool{
    if input == "+" || input == "*" || input == "-" || input == "/"
        || input == "(" || input == ")"{
        return true
    }
    return false
}
func deleteBrackets (_ input: inout [String]) -> [String]{
    var n = 1
    while  n < input.count{
    if  input[n-1] == "(" && Double(input[n]) != nil
        && input[n+1] == ")"{
        input.remove(at: n-1)
        input.remove(at: n)
    }
    n+=1
    }
    return input
}
func parse(_ input: String)->[String]{
    
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
    if expression[n-1].last == "." && Int(expression[n]) != nil{
        expression[n-1]=expression[n-1]+expression[n]
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
    if  (expression[n-1] == "*" || expression[n-1] == "/")
        && expression[n] == "-" && expression[n+1] == "("{
        expression.remove(at: n)
        expression.insert("-1", at: n-1)
        expression.insert("*", at: n-1)
    }
    if  expression[n-1] == "+" && expression[n] == "-" && expression[n+1] == "("{
        expression[n-1]="-"
        expression.remove(at: n)
    }
    if expression[n-1] == "(" && expression[n] == "-"
        && expression[n+1] == "("{
        expression.remove(at: n)
        expression.insert("-1", at: n)
        expression.insert("*", at: n+1)
    }
    if n == 1 && expression[n-1] == "-" && Double(expression[n]) != nil {
        expression[n-1]="-"+expression[n]
        expression.remove(at: n)
        n = 0
    }
    n+=1
    }
    
    return deleteBrackets(&expression)
}

func notation(_ expression :[String]) -> [String]{
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

func calculate(_ expression : [String]) -> Double{
    var expression = expression
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
    result = Double(expression[0])!
    return result
}

func test(_ expression: String) -> Double{
   return calculate(notation(parse(expression)))
    
}

test("-4.2-5.2")
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
      self.components(separatedBy: "#")
  }
private func formateNum(_ input: [String] ) -> String {
         var result = ""
         var point = false
         for element in input {
           if Int(element) != nil && !point{
               result += separatedNumber(Int(element))
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
}
  var tester = "2222#.#2222#*#4444#/#1#.#1111"
separatedNumber(222222.2222)
tester.createOutput()
Int(1.0)
// выводит "1 234 567,89"
//var result = notation(parse("-(15.11-6/2*-(1+2))/-1*(2-6*2)"))
//calculate(&result)
//(2-1*2)+-(2*5)+(-10.12+10)
//12+3-4*56+/7*8+
//-(15.11-6/2*-(1+2))/-1*(2-6*2)
