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
    
    /// UserDefaults instance
    private let defaults: UserDefaults = .standard
    
    /// TableVeiw instance
    var tableView = UITableView()
    
    /// SearchView intance
    let search = UISearchController(searchResultsController: nil)
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "History", keyForSort: "date")
    
    /// Cells struct
    struct Cells {
        static let calcCell = "CalcCell"
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        configureTableView()
        setNavigationController()
        setSearchController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        CoreDataManager.instance.saveContext()
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

extension HistoryScreen: UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.calcCell) as! CalcCell
        if let expression = history.expression,
           let result = history.result,
           let date = history.date {
            cell.set(exp: expression, res: result, date: date)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                let managedObject = fetchedResultsController.object(at: indexPath) as NSManagedObject
                CoreDataManager.instance.managedObjectContext.delete(managedObject)
                CoreDataManager.instance.saveContext()
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
                    return sections[section].numberOfObjects
                } else {
                    return 0
                }
    }
  
}

extension HistoryScreen: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("")
    }
    
}
