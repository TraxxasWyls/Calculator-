//
//  HistoryViewOutput.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - HistoryViewOutput

protocol HistoryViewOutput: class {
    
    /// Trigger that a request to delete an item has occurred
    /// - Parameters:
    ///   - element: element to be deleted
    ///   - index: index of the element to be deleted
    func didTriggerDeleteElement(element: HistoryPlainObject, index: Int)
    
    /// Trigger that a request to start ready event has occures
    func didTriggerViewReadyEvent()
    
    /// Get models from the repository
    func getHistoryModels()
}
