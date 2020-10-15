//
//  HistoryService.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - HistoryService

protocol HistoryService {
    
    /// Returns ready to use Array of HIstory models
    func getHistory() -> [HistoryPlainObject]
    
    /// Removes an item from the CoreData
    /// - Parameter at: target object
    func deleteHistoryObject(element: HistoryPlainObject)
    
    /// Saves data to database
    /// - Parameters:
    ///   - expression: target HistoryModel expression
    ///   - result: target HistoryModel result
    func saveHistory(expression: String, result: String)
}
