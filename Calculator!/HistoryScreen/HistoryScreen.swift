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
    
    weak var delegate: FirstViewControllerDelegate?
    
    /// TableVeiw instance
    var tableView = UITableView()
    
    /// SearchView intance
    let search = UISearchController(searchResultsController: nil)
    
    /// FetchedResultsController inctance
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
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

extension HistoryScreen: UITableViewDelegate, UITableViewDataSource {
    
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
            let managedObject = fetchedResultsController.object(at: indexPath)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let history = fetchedResultsController.object(at: indexPath)
        if let expression = history.expression {
            delegate?.update(expression: expression)
            self.dismiss(animated:true)
        }
    }
    
}
extension HistoryScreen: NSFetchedResultsControllerDelegate {
   
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if let indexPath = indexPath,
           type == .delete {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension HistoryScreen: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("")
    }
    
}
