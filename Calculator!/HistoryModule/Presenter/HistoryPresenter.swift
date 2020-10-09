//
//  HistoryPresenter.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

protocol HistoryViewInputProtocol: class {
    func success()
    func delete(indexPath: IndexPath)
}

protocol HistoryViewOutputProtocol: class {
    init (view: HistoryViewInputProtocol, dataService: HistoryService)
    func deleteElementOfHistory(indexPath: IndexPath)
    func getHistoryModels()
    var historyModels: [HistoryPlainObject]? { get set }
}

class HistoryPresenter: HistoryViewOutputProtocol {
    weak var view: HistoryViewInputProtocol?
    let dataService: HistoryService!
    var historyModels: [HistoryPlainObject]?
    
    required init(view: HistoryViewInputProtocol, dataService: HistoryService) {
        self.view = view
        self.dataService = dataService
        getHistoryModels()
    }
    
    func getHistoryModels() {
        historyModels = dataService.getHistory()
        view?.success()
    }
    
    func deleteElementOfHistory(indexPath: IndexPath) {
        dataService.deleteElement(at: indexPath)
        historyModels = dataService.getHistory()
        view?.delete(indexPath: indexPath)
    }
}

