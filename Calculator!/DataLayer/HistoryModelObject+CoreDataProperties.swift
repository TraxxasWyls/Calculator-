//
//  HistoryModelObject+CoreDataProperties.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 06.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//
//

import Foundation
import CoreData


extension HistoryModelObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryModelObject> {
        return NSFetchRequest<HistoryModelObject>(entityName: "HistoryModelObject")
    }

    @NSManaged public var date: Date?
    @NSManaged public var expression: String?
    @NSManaged public var result: String?

}

extension HistoryModelObject : Identifiable {

}
