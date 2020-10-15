//
//  HistoryViewInput.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - HistoryViewInput

protocol HistoryViewInput: class {
    
    /// Reloading data of the HistoryView
    /// - Parameter historyModels: target history
    func reloadData(historyModels: [HistoryPlainObject])
    
    /// Deleting the HistoryPlainObject at index in the array
    /// - Parameter index: of the concrete HistoryPlainObject in the array
    func delete(at index: Int)
}
