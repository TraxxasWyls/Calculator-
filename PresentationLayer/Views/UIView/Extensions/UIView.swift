//
//  UIView.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 01.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

// MARK: - Extension

extension UIView {
    
    /// Binds the current UIView to his superUIView with zero padding
    /// - Parameters:
    ///   - superView: the UIView that the current UIView is attached to
    ///   - x: offset by the x - axis
    ///   - y: offset by the y - axis
    func pin(to superView: UIView, x: CGFloat, y: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor,constant: y),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor,constant: x),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor,constant: x),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor,constant: y)
        ])
    }
}

