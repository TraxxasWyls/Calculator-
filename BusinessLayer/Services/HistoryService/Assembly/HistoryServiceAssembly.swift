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

final class HistoryServiceAssembly: CollectableAssembly {
    
    func assemble(inContainer container: Container) {
        assembleDAO()
        assembleHistoryService()
    }
    
    /// Assemling DAO
    private func assembleDAO() {
        container.register(CoreStorageConfig.self) { _ in
            CoreStorageConfig(containerName: "HistoryModel")
        }
        container.register(CoreStorage.self) { resolver in
            try! CoreStorage(configuration: resolver.resolve(CoreStorageConfig.self).unwrap(), model: HistoryModelObject.self)
        }
        container.register(HistoryTranslator.self) { _ in
            HistoryTranslator()
        }
        container.register(DAO.self) { resolver in
            DAO(storage: resolver.resolve(CoreStorage.self).unwrap(), translator: resolver.resolve(HistoryTranslator.self).unwrap())
        }
    }
    
    /// Assemling the history service
    /// - Returns: the HistoryService inctance
    private func assembleHistoryService() {
        container.register(HistoryService.self) { resolver in
            HistoryServiceImplementation(dao: resolver.resolve(DAO.self)!)
        }
    }
    
    /// Returns HistoryService instance from container
    /// - Returns: HistoryService
    func getHistoryService() -> HistoryService {
        let historyService = container.resolve(HistoryService.self)
        return historyService.unwrap()
    }
    
}
