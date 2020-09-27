//
//  CalculationAlgorithm.swift
//  Calculator!
//
//  Created by incetro on 9/25/20.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - CalculationAlgorithm

protocol CalculationAlgorithm: Parser {

    /// Calculates some math expression
    /// - Parameter expression: target expression
    func calculate(_ expression: String) -> Double

}
