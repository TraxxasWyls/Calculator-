//
//  ModuleBuilder.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import UIKit

protocol Assembly {
    func createHistoryScreen() -> HistoryScreen
}

class ModuleAssembly: Assembly {
    func createHistoryScreen() -> HistoryScreen {
        let view = HistoryScreen()
        let dataService = HistoryModelObject()
        let presenter = HistoryPresenter(view: view, dataService: dataService)
        view.presenter = presenter
        return view
    }
}
