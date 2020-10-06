//
//  Stack.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - Stack

struct Stack<Element> {

    // MARK: - Properties

    var items = [Element]()

    // MARK: - Useful

    mutating func push(_ item: Element) {
        items.append(item)
    }

    @discardableResult mutating func pop() -> Element {
        items.removeLast()
    }

    func isEmpty() -> Bool {
        items.isEmpty
    }

    mutating func append(_ item: Element) {
        push(item)
    }

    var count: Int {
        items.count
    }

    var topItem: Element? {
        items.isEmpty ? nil : items[items.count - 1]
    }

    subscript(i: Int) -> Element {
        items[i]
    }
}
