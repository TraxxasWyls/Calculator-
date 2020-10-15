//
//  HistoryServiceImplementation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 15.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import CoreData
import Monreau

// MARK: - HistoryServiceImplementation

public final class HistoryServiceImplementation: HistoryService {
    
    /// CoreStorage instance
    let storage = try? CoreStorage(configuration: CoreStorageConfig(containerName: "HistoryModel"), model: HistoryModelObject.self)
    
    // MARK: - Useful
    
    func saveHistory(expression: String, result: String) {
        do {
            try storage?.create { element in
                element.expression = expression
                element.result = result
                element.date = NSDate() as Date
                element.id = Int32(element.date?.timeIntervalSince1970 ?? -1)
            }
        }
        catch {
            print("Error while saving to storage")
        }
    }
    
    func getHistory() -> [HistoryPlainObject] {
        var historyPlainObjectArray: [HistoryPlainObject] = [HistoryPlainObject]()
        var historyModelArray: [HistoryModelObject]?
        do {
            historyModelArray = try storage?.read(orderedBy: "date", ascending: false)
        }
        catch {
            print("Error while getting the storage")
        }
        if let history = historyModelArray {
            for element in history {
                if let expression = element.expression,
                   let result = element.result,
                   let date = element.date {
                    let id = Int(element.id)
                    let historyPlainObjectElement = HistoryPlainObject(expression: expression, result: result, date: date, id: id)
                    historyPlainObjectArray.append(historyPlainObjectElement)
                }
            }
        }
        return historyPlainObjectArray
    }
    
    func deleteHistoryObject(element: HistoryPlainObject) {
        let predicateByDate = NSPredicate(format: "date == %@", element.date as NSDate)
        do {
            try storage?.erase(predicatedBy: predicateByDate)
        }
        catch {
            print("Error while deleting the element")
        }
    }
}
