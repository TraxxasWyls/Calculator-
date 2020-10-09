//
//  CalcCell.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 02.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

// MARK: - TableViewCell

final class CalcCell: UITableViewCell {
    
    // MARK: - Properties
    
    let expressionLabel = SelectableLabel()
    let resultLabel = SelectableLabel()
    let dateLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateLabel)
        addSubview(resultLabel)
        addSubview(expressionLabel)
        configureDateLabel()
        configureResultLabel()
        configureExpressionLabel()
        setupDateLabel()
        setupResultLabel()
        setupExpressionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - Configure
    
    private func configureExpressionLabel() {
        expressionLabel.numberOfLines = 3
        expressionLabel.adjustsFontSizeToFitWidth = true
        expressionLabel.fontSizeToFit()
    }
    
    private func configureDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.font = dateLabel.font.withSize(15)
    }
    
    private func configureResultLabel() {
        resultLabel.numberOfLines = 1
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.fontSizeToFit()
    }
    
    // MARK: - Set
    
    func update(exp: String, res: String, date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        expressionLabel.text = exp.createOutput()
        resultLabel.text = "= " + res.createResult()
        dateLabel.text = formatter.string(from: date as Date)
    }
    
    private func setupExpressionLabel() {
        expressionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expressionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            expressionLabel.heightAnchor.constraint(equalToConstant: 80),
            expressionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            expressionLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -5),
            dateLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupResultLabel() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 55),
            resultLabel.leadingAnchor.constraint(equalTo: expressionLabel.trailingAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
