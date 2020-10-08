//
//  HistoryPresenter.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

protocol HistoryViewProtocol: class {
    func success()
//    func delete()
}

protocol HistoryPresenterProtocol: class {
    init (view: HistoryViewProtocol, dataService: DataServiceProtocol)
//    func deleteElementOfHistory()
    func getHistoryModels()
    var historyModels: [HistoryModel]? { get set }
}

class HistoryPresenter: HistoryPresenterProtocol {
    weak var view: HistoryViewProtocol?
    let dataService: DataServiceProtocol!
    var historyModels: [HistoryModel]?
    
    required init(view: HistoryViewProtocol, dataService: DataServiceProtocol) {
        self.view = view
        self.dataService = dataService
        getHistoryModels()
    }
    
    func getHistoryModels() {
        historyModels = dataService.getHistory()
        view?.success()
    
    }
    
//    func deleteElementOfHistory() {
//        <#code#>
//    }
    
}

