//
//  HistoryServiceImplementation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import CoreData

// MARK: - HistoryModelObject

@objc(HistoryModelObject)
public final class HistoryModelObject: NSManagedObject {
    
    // MARK: - Initializers
    
    convenience init() {
        // Creating a new managedObject
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "HistoryModelObject"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}

// MARK: - Extension

extension HistoryModelObject: HistoryService {
    
    // MARK: - Useful
    
    func getHistory() -> [HistoryPlainObject]? {
        /// FetchedResultsController inctance
        let fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "HistoryModelObject", keyForSort: "date")
        
        /// HistoryModelArray instance
        var HistoryModelArray: [HistoryPlainObject]! = [HistoryPlainObject]()
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        if let history = fetchedResultsController.fetchedObjects {
            for element in history {
                if let expression = element.expression,
                   let result = element.result,
                   let date = element.date {
                    let HistoryModelElement = HistoryPlainObject(expression: expression, result: result, date: date)
                    HistoryModelArray.append(HistoryModelElement)
                }
            }
        }
        return HistoryModelArray
    }
    
    func deleteElement(at: IndexPath) {
        /// FetchedResultsController inctance
        let fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "HistoryModelObject", keyForSort: "date")
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        /// ManagedObject instance
        let managedObject = fetchedResultsController.object(at: at)
        CoreDataManager.instance.managedObjectContext.delete(managedObject)
        CoreDataManager.instance.saveContext()
    }
}
