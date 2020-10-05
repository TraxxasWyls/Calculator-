//
//  History+CoreDataClass.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 05.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//
//

import Foundation
import CoreData

@objc(History)
public class History: NSManagedObject {
    
    convenience init() {
        
        // Создание нового объекта
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "History"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
