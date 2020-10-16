//
//  ModuleBuilder.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import UIKit
import Monreau
import SwiftyDAO

// MARK: - HistoryAssembly

final class HistoryAssembly {
    
    /// Assembling the history module
    /// - Returns: the HistoryViewController instance
    func createHistoryScreen() -> HistoryViewController {
        let view = HistoryViewController()
        let dataService = createHistoryService()
        let presenter = HistoryPresenter(dataService: dataService)
        presenter.view = view
        view.output = presenter
        return view
    }
    
    /// Assemling the history service
    /// - Returns: the HistoryService inctance
    func createHistoryService() -> HistoryService {
        let dao: DAO<CoreStorage<HistoryModelObject>, HistoryTranslator>
        let config = CoreStorageConfig(containerName: "HistoryModel")
        do {
            let storage = try CoreStorage(configuration: config, model: HistoryModelObject.self)
            dao = DAO(storage: storage, translator: HistoryTranslator())
            return HistoryServiceImplementation(dao: dao)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
