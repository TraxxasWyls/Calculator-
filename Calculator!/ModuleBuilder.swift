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

class ModelBuilder: Builder {
    func createHistoryScreen() -> UIViewController {
        let model = HistoryModel(expression: "", result: "", date: NSDate() as Date)
        let view = HistoryScreen()
        let presenter = HistoryPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
    
    
}
