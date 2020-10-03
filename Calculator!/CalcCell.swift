//
//  CalcCell.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 02.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

// MARK: - TableViewCell

class CalcCell: UITableViewCell {
    
    // MARK: - Properties
    
    var expressionLabel = SelectableLabel()
    var resultLabel = SelectableLabel()
    var dateLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dateLabel.text = "01.02.2001  "
        resultLabel.text = "22312"
        expressionLabel.text = "2342+(33+666)+54344+344"
        addSubview(dateLabel)
        addSubview(resultLabel)
        addSubview(expressionLabel)
        configureDateLabel()
        configureResultLabel()
        configureExpressionLabel()
        setDateLabel()
        setResultLabel()
        setExpressionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - Configure
    
    func configureExpressionLabel() {
        expressionLabel.numberOfLines = 2
        expressionLabel.adjustsFontSizeToFitWidth = true
        expressionLabel.fontSizeToFit()
    }
    
    func configureDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.font = dateLabel.font.withSize(15)
    }
    
    func configureResultLabel() {
        resultLabel.numberOfLines = 1
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.fontSizeToFit()
    }
    
    // MARK: - Set
    
    func set(calc: String, res: String, date: String) {
        expressionLabel.text = calc
        resultLabel.text = res
        dateLabel.text = date
    }
    
    func setExpressionLabel() {
        expressionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expressionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            expressionLabel.heightAnchor.constraint(equalToConstant: 80),
            expressionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            expressionLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 25)
           
        ])
    }
    
    func setResultLabel() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 55),
            resultLabel.leadingAnchor.constraint(equalTo: expressionLabel.trailingAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
