//
//  HistoryServiceImplementation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import CoreData
import Monreau

// MARK: - HistoryModelObject

@objc(HistoryModelObject)
public final class HistoryModelObject: NSManagedObject, Storable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryModelObject> {
        return NSFetchRequest<HistoryModelObject>(entityName: "HistoryModelObject")
    }
    
    public typealias PrimaryType = Int32
    
    @NSManaged public var date: Date?
    @NSManaged public var expression: String?
    @NSManaged public var result: String?
    @NSManaged public var id: Int32
}

// MARK: - Extension

extension HistoryModelObject : Identifiable {
    
}

