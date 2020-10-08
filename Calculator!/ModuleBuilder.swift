//
//  ModuleBuilder.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation
import UIKit

protocol Builder {
    func createHistoryScreen() -> UIViewController
}

class ModuleBuilder: Builder {
    func createHistoryScreen() -> UIViewController {
        let view = HistoryScreen()
        let dataService = History()
        let presenter = HistoryPresenter(view: view, dataService: dataService)
        view.presenter = presenter
        return view
    }
    
    
}
