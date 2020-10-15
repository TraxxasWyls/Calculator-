//
//  ViewControllerDelegate.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 06.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

// MARK: - MainViewControllerDelegate

protocol MainViewControllerDelegate: class {
    
    /// Updating the current expression
    /// - Parameter expression: target expression
    func update(expression: String)
}
