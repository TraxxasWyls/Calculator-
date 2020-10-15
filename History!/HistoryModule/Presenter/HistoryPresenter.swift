//
//  HistoryPresenter.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 07.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - HistoryPresenter

final class HistoryPresenter: HistoryViewOutput {
    
    /// HistoryViewInput that presenter is using
    weak var view: HistoryViewInput?
    
    /// HistoryService that presenter is using
    let dataService: HistoryService?
    
    /// Initialize the HistoryPresenter with the required dataService
    /// - Parameter dataService: target dataService
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

