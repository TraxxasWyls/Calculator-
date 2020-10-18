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

final class HistoryAssembly {
    
    let container: Container

    init(historyService: HistoryService) {
        container = Container()
        container.register(HistoryViewController.self) { _ in
            HistoryViewController()
        }
        container.register(HistoryPresenter.self) { r in
            let presenter = HistoryPresenter(dataService: historyService)
            presenter.view = r.resolve(HistoryViewController.self)!
            return presenter
        }
//        container.register(HistoryViewController.self) { r in
//            let view = r.resolve(HistoryViewController.self).unwrap()
//            view.output = r.resolve(HistoryPresenter.self).unwrap()
//            return view
//        }
    }
    
    /// Assembling the history module
    /// - Returns: the HistoryViewController instance
    func createHistoryScreen() -> HistoryViewController {
        let view = container.resolve(HistoryViewController.self)
        view?.output = container.resolve(HistoryPresenter.self)
        return view.unwrap()
    }
    
    
    
    
}
