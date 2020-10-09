//
//  ParserProtocol.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 27.09.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - ParserProtocol

protocol ParserProtocol {
    
    /// Checks if the given string is an operation
    /// - Parameter input: target string
    func isOperation(_ input: String) -> Bool

    /// Parses the given expression into array
    /// - Parameter input: target expression
    func parse(_ input: String) -> [String]
}

// MARK: - Default

extension ParserProtocol {
    
    func isOperation(_ input: String) -> Bool {
        ["+", "-", "*", "/", "(", ")"].contains(input)
    }
}
    
