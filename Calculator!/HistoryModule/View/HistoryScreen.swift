//
//  HistoryScreen.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 01.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit
import CoreData

// MARK: - ViewController

class HistoryScreen: UIViewController {
    
    // MARK: - Properties
    
    var presenter: HistoryViewOutputProtocol!
    weak var delegate: FirstViewControllerDelegate?
    
    /// TableVeiw instance
    var tableView = UITableView()
    
    /// SearchView intance
    let search = UISearchController(searchResultsController: nil)
    
    /// Cells struct
    struct Cells {
        static let calcCell = "CalcCell"
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setNavigationController()
        setSearchController()
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        title = "History"
        tableView.separatorColor = .gray
        setTableViewDelegate()
        tableView.rowHeight = 100
        tableView.register(CalcCell.self, forCellReuseIdentifier: Cells.calcCell)
        tableView.pin(to: view, x: 0, y: 0) 
    }
    
    // MARK: - Setting
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .gray
    }
    
    func setSearchController() {
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
}

// MARK: - Extensions

extension HistoryScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.calcCell) as! CalcCell
        let history = presenter.historyModels?[indexPath.row]
        if let expression = history?.expression,
           let result = history?.result,
           let date = history?.date {
            cell.set(exp: expression, res: result, date: date)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.historyModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            presenter.deleteElementOfHistory(indexPath: indexPath)
        }
    }
}

extension HistoryScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let history = presenter.historyModels?[indexPath.row]
        if let expression = history?.expression {
            delegate?.update(expression: expression)
            self.dismiss(animated:true)
        }
    }
}

extension HistoryScreen: HistoryViewInputProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func delete(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

extension HistoryScreen: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("")
    }
}
