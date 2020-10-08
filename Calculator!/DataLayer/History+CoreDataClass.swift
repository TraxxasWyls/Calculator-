//
//  History+CoreDataClass.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 06.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//
//

import Foundation
import CoreData

protocol DataServiceProtocol {
    func getHistory() -> [HistoryModel]?
}

@objc(History)
public class History: NSManagedObject {
    
    convenience init() {
        // Создание нового объекта
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "History"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}

extension History: DataServiceProtocol {
    
    func getHistory() -> [HistoryModel]? {
        /// FetchedResultsController inctance
        let fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "History", keyForSort: "date")
        
        var HistoryModelArray: [HistoryModel]! = [HistoryModel]()
    
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        
        if let history = fetchedResultsController.fetchedObjects{
            for element in history {
                if let expression = element.expression,
                   let result = element.result,
                   let date = element.date {
                    let HistoryModelElement = HistoryModel(expression: expression, result: result, date: date)
                    HistoryModelArray.append(HistoryModelElement)
                }
            }
        }
        return HistoryModelArray
    }
}
