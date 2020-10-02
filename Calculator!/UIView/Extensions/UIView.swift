//
//  UIView.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 01.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

extension UIView {
    
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
