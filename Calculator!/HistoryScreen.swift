//
//  HistoryScreen.swift
//  Calculator!
//
//  Created by Дмитрий Савинов on 01.10.2020.
//  Copyright © 2020 Дмитрий Савинов. All rights reserved.
//

import UIKit

class HistoryScreen: UIViewController {
    
    var tableView = UITableView()
    let search = UISearchController(searchResultsController: nil)
    
    struct Cells {
        static let calcCell = "CalcCell"
    }
    
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

extension HistoryScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.calcCell) as! CalcCell
        cell.set(calc: "2+(-3+1)")
        return cell
    }
    
}

extension HistoryScreen: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("")
    }
    
}
