//
//  Stack.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

 struct Stack<Element>{
<<<<<<< HEAD

    var items = [Element]()
=======
  
     var items = [Element]()
>>>>>>> calculator
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

