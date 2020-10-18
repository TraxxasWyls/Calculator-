//
//  ServiceAssembly.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 18.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import Monreau
import SwiftyDAO
import Swinject

final class HistoryServiceAssembly {
    
   let container = Container()
    
    init() {
        createDAO()
    }
    /// Assemling DAO
    private func createDAO() {
        container.register(CoreStorageConfig.self) { _ in
            CoreStorageConfig(containerName: "HistoryModel")
        }
        container.register(CoreStorage.self) { r in
            try! CoreStorage(configuration: r.resolve(CoreStorageConfig.self).unwrap(), model:HistoryModelObject.self)
        }
        container.register(HistoryTranslator.self) { _ in
            HistoryTranslator()
        }
        container.register(DAO.self) { r in
            DAO(storage: r.resolve(CoreStorage.self).unwrap(), translator: r.resolve(HistoryTranslator.self).unwrap())
        }
    }
    
    /// Assemling the history service
    /// - Returns: the HistoryService inctance
    func createHistoryService() -> HistoryService {
        container.register(HistoryService.self) { r in
            HistoryServiceImplementation(dao: r.resolve(DAO.self)!)
        }
        return container.resolve(HistoryService.self).unwrap()
    }
}
