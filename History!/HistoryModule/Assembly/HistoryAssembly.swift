//
//  ModuleBuilder.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import UIKit
import Swinject

// MARK: - HistoryAssembly

final class HistoryAssembly: CollectableAssembly {
    
    func assemble(inContainer container: Container) {
        container.register(HistoryViewInput.self) { resolver in
            let controller = HistoryViewController()
            controller.output = resolver.resolve(HistoryViewOutput.self).unwrap()
            return controller
        }
        
        container.register(HistoryViewOutput.self) { resolver in
            HistoryPresenter(dataService: resolver.resolve(HistoryService.self).unwrap())
        }.initCompleted { resolver, c in
            let presenter = c as! HistoryPresenter
            presenter.view = resolver.resolve(HistoryViewInput.self)
        }
    }
    
    /// Returns HistoryViewController  instance from container
    /// - Returns: the HistoryViewController instance
    func getHistoryScreen() -> HistoryViewController {
        let view = container.resolve(HistoryViewInput.self).unwrap(as: HistoryViewController.self)
        return view
    }
    
    
    
    
}
