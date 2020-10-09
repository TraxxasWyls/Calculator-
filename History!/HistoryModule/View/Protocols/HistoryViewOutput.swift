//
//  HistoryViewOutput.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

protocol HistoryViewOutput: class {
    func didTriggerDeleteElement(indexPath: IndexPath)
    func didTriggerViewReadyEvent()
    func getHistoryModels()
}
