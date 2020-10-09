//
//  HistoryViewInput.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 09.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

protocol HistoryViewInput: class {
    func reloadData(historyModels: [HistoryPlainObject])
    func delete(at index: Int)
}
