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
    
    static let storage = try? CoreStorage(configuration: CoreStorageConfig(containerName: "HistoryModel"), model: HistoryModelObject.self)
    
    // MARK: - Useful
    
    func getHistory() -> [HistoryPlainObject] {
        /// FetchedResultsController inctance
        let fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "HistoryModelObject", keyForSort: "date")
        
        /// HistoryModelArray instance
        var historyModelArray: [HistoryPlainObject] = [HistoryPlainObject]()
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
                    let id = Int(element.id)
                    let HistoryModelElement = HistoryPlainObject(expression: expression, result: result, date: date, id: id)
                    historyModelArray.append(HistoryModelElement)
                }
            }
        }
        return historyModelArray
    }
    
    func deleteElement(element: HistoryPlainObject) {
        let context = CoreDataManager.instance.managedObjectContext
        do {
            let fetchRequest : NSFetchRequest<HistoryModelObject> = HistoryModelObject.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "date == %@", element.date as NSDate)
            let fetchedResults = try context.fetch(fetchRequest)
            if let elementToDelete = fetchedResults.first {
                
                CoreDataManager.instance.managedObjectContext.delete(elementToDelete)
                CoreDataManager.instance.saveContext()
            }
        }
        catch {
            print ("fetch task failed", error)
        }
    }
}
