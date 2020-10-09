//
//  HistoryViewController.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 01.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit
import CoreData

// MARK: - ViewController

final class HistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    var output: HistoryViewOutput?
    weak var delegate: MainViewControllerDelegate?
    
    /// TableVeiw instance
    let tableView = UITableView()
    
    private var history = [HistoryPlainObject]()
    
    /// SearchView intance
    let search = UISearchController(searchResultsController: nil)
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didTriggerViewReadyEvent()
        configureTableView()
        setupNavigationController()
        setupSearchController()
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        title = "History"
        tableView.separatorColor = .gray
        setTableViewDelegate()
        tableView.rowHeight = Constants.tableViewHeight
        tableView.register(CalcCell.self, forCellReuseIdentifier: Constants.calcCell)
        tableView.pin(to: view, x: 0, y: 0) 
    }
    
    // MARK: - Setting
    
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .gray
    }
    
    func setupSearchController() {
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }
    
}

// MARK: - Extensions

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.calcCell) as! CalcCell
        let expression = history[indexPath.row].expression
        let result =  history[indexPath.row].result
        let date =  history[indexPath.row].date
        cell.update(exp: expression, res: result, date: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        history.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            output?.didTriggerDeleteElement(element: history[indexPath.row], index: indexPath.row)
        }
    }
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let expression = history[indexPath.row].expression
        delegate?.update(expression: expression)
        self.dismiss(animated: true)
    }
}


extension HistoryViewController: HistoryViewInput {
    
    func reloadData(historyModels: [HistoryPlainObject]) {
        history = historyModels
    }
    
    func delete(at index: Int) {
        tableView.deleteRows(at: [IndexPath(row: index, section: 0 )], with: .automatic)
        tableView.endUpdates()
    }
}

extension HistoryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("")
    }
}

extension HistoryViewController {
    
    /// Enumeration of constants
    enum Constants {
        static let calcCell = "CalcCell"
        static let tableViewHeight: CGFloat = 100
    }
    
}
