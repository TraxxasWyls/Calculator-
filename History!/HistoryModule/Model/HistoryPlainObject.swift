//
//  HistoryPlainObject.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - HistoryPlainObject

/// Plain object with that HistoryModule is working
struct HistoryPlainObject {
    
    /// Mathematical expression
    let expression: String
    
    /// Result of the mathematical expression
    let result: String
    
    /// Date when calculation was
    let date: Date
    
    /// Unique identifier of the plain object
    var id: Int
}
