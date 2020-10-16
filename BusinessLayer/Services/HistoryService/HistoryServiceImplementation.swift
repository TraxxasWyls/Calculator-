//
//  HistoryServiceImplementation.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 15.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import Monreau
import SwiftyDAO

// MARK: - HistoryServiceImplementation

public final class HistoryServiceImplementation: HistoryService {
    
    /// DAO
    let dao: DAO<CoreStorage<HistoryModelObject>, HistoryTranslator>
    
    // MARK: - Initialize
    
    init(dao: DAO<CoreStorage<HistoryModelObject>, HistoryTranslator>) {
        self.dao = dao
    }
    
    // MARK: - Useful
    
    func saveHistory(object: HistoryPlainObject) {
        if getLastExpression() != object.expression {
            do {
                try dao.create(object)
            } catch {
                print("Error while saving to storage")
            }
        }
    }
    
    func getHistory() -> [HistoryPlainObject] {
        var historyPlainObjectArray: [HistoryPlainObject]?
        do {
             historyPlainObjectArray = try dao.read(orderedBy: "date", asceding: false)
        } catch {
            print("Error while getting the storage")
        }
        return historyPlainObjectArray ?? [HistoryPlainObject]()
    }
    
    func deleteHistoryObject(element: HistoryPlainObject) {
        do {
            try dao.erase(byPrimaryKey: element.uniqueId)
        } catch {
            print("Error while deleting the element")
        }
    }
    
    private func getLastExpression() -> String {
        do {
            return try dao.read().last?.expression ?? ""
        } catch {
            print("Error while getting first element")
        }
        return ""
    }
}
