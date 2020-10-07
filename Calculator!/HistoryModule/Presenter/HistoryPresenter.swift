//
//  HistoryPresenter.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

protocol HistoryViewProtocol: class {
    func setElementOfHistory(expression: String, result: String, date: Date)
}

protocol HistoryPresenterProtocol: class {
    init (view: HistoryViewProtocol, model: HistoryModel)
    func deleteElementOfHistory()
    func showCalculator()
}

class HistoryPresenter: HistoryPresenterProtocol {
    let view: HistoryViewProtocol
    let model: HistoryModel
    
    required init(view: HistoryViewProtocol, model: HistoryModel) {
        self.view = view
        self.model = model
    }
    
    func deleteElementOfHistory() {
        print("delete")
    }
    
    func showCalculator() {
        print("show")
    }
    
   
    
    
}
