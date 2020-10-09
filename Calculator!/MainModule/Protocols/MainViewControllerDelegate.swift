//
//  ViewControllerDelegate.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 06.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import Foundation

protocol MainViewControllerDelegate: class {
    
    /// Updating the current state
    func update(expression: String)
}
