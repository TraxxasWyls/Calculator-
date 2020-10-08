//
//  History+CoreDataProperties.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 06.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var date: Date?
    @NSManaged public var expression: String?
    @NSManaged public var result: String?

}

extension History : Identifiable {

}
