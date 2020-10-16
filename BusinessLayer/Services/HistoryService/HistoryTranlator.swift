//
//  HistoryTranlator.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 16.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import SwiftyDAO

// MARK: - HistoryTranslator

final class HistoryTranslator: Translator {
    
    // MARK: - Translator

    func translate(model: HistoryModelObject) throws -> HistoryPlainObject {
        guard let expression = model.expression,
              let result = model.result,
              let date = model.date else {
            return HistoryPlainObject(expression: "", result: "", date: Date(), id: 0)
        }
        let id = Int(model.uniqueId) ?? 0
        print("!!!!!!!!!" + String(id) + "!!!!!!!")
        return HistoryPlainObject(expression: expression, result: result, date: date, id: id)
    }
    
    func translate(plain: HistoryPlainObject) throws -> HistoryModelObject {
        let model = HistoryModelObject()
        try translate(from: plain, to: model)
        return model
    }

    func translate(from plain: HistoryPlainObject, to databaseModel: HistoryModelObject) throws {
        if databaseModel.uniqueId.isEmpty {
            databaseModel.uniqueId = plain.uniqueId.rawValue
        }
        databaseModel.date = plain.date
        databaseModel.expression = plain.expression
        databaseModel.result = plain.result
        databaseModel.id = Int64(plain.id)
    }
}
