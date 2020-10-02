//
//  CalcCell.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 02.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

class CalcCell: UITableViewCell {
    
    var expressionLabel = SelectableLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(expressionLabel)
        configureExpressionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func set(calc: String) {
        expressionLabel.text = calc
    }
    
    func configureExpressionLabel() {
        expressionLabel.numberOfLines = 0
        expressionLabel.adjustsFontSizeToFitWidth = true
        expressionLabel.fontSizeToFit()
        expressionLabel.pin(to: self, x: 50, y: 0)
    }
}
