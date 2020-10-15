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

extension HistoryModelObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryModelObject> {
        return NSFetchRequest<HistoryModelObject>(entityName: "HistoryModelObject")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var expression: String?
    @NSManaged public var result: String?
    @NSManaged public var id: Int32
}

extension HistoryModelObject : Identifiable {
    
}

