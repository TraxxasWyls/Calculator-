//
//  HistoryServiceImplementation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import Monreau
import SwiftyDAO

// MARK: - HistoryModelObject

@objc(HistoryModelObject)
public final class HistoryModelObject: ManagedModel {
        
    @NSManaged public var date: Date?
    @NSManaged public var expression: String?
    @NSManaged public var result: String?
    @NSManaged public var id: Int64
}


