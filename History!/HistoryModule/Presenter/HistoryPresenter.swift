//
//  HistoryPresenter.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

final class HistoryPresenter: HistoryViewOutput {
    weak var view: HistoryViewInput?
    let dataService: HistoryService?
    
    required init(dataService: HistoryService) {
        self.dataService = dataService
    }
    
    func getHistoryModels() {
        if let historyModels = dataService?.getHistory(){
            view?.reloadData(historyModels: historyModels)
        }
    }
    
    func didTriggerViewReadyEvent() {
        getHistoryModels()
    }
    
    func didTriggerDeleteElement(element: HistoryPlainObject, index: Int) {
        dataService?.deleteElement(element: element)
        getHistoryModels()
        view?.delete(at: index)
    }
}

