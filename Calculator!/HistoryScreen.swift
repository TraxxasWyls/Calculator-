//
//  HistoryScreen.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 01.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

// MARK: - ViewController

class HistoryScreen: UIViewController {
    
    // MARK: - Properties
    
    /// UserDefaults instance
    private let defaults: UserDefaults = .standard
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    func setTableViewDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setNavigationController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .gray
    }
    
    func setSearchController() {
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    
}

// MARK: - Extensions

extension HistoryScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.calcCell) as! CalcCell
//        if let expression = defaults.string(forKey: "expressionKey"),
//           let result = defaults.string(forKey: "resultKey"),
//           let date = defaults.string(forKey: "dateKey"){
//            cell.set(calc: expression.createOutput(), res: result, date: date)
//            cell.set(calc: "22", res: "22", date: "33")
//        }
        return cell
    }
    
}

extension HistoryScreen: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("")
    }
    
}
