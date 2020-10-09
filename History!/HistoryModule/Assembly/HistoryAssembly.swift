//
//  ModuleBuilder.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import UIKit

final class HistoryAssembly {
    func createHistoryScreen() -> HistoryViewController {
        let view = HistoryViewController()
        let dataService = HistoryModelObject()
        let presenter = HistoryPresenter(dataService: dataService)
        presenter.view = view
        view.output = presenter
        return view
    }
}
