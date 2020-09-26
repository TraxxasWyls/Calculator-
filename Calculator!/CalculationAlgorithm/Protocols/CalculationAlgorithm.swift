//
//  CalculationAlgorithm.swift
//  Calculator!
//
//  Created by incetro on 9/25/20.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - CalculationAlgorithm

protocol CalculationAlgorithm {

    /// Calculates some math expression
    /// - Parameter expression: target expression
    func calculate(_ expression: String) -> Double

    /// Checks if the given string is an operation
    /// - Parameter input: target string
    func isOperation(_ input: String) -> Bool

    /// Parses the given expression into array
    /// - Parameter input: target expression
    func parse(_ input: String) -> [String]
}
