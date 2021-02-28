//
//  MainViewController.swift
//  MyTasks
//
//  Created by Ben Mustafa Anas on 24/02/2021.
//  Copyright © 2021 Ben Mustafa Anas. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    internal var tasks: Results<Task>!
    internal var filteredPlaces: Results<Task>!
    private let searchController = UISearchController(searchResultsController: nil)
    private var ascendingSorting = true
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    internal var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var reversedSortingButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Getting objects from database
        tasks = realm.objects(Task.self)
        
        // Setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let place: Task
            
            if isFiltering {
                place = filteredPlaces[indexPath.row]
            } else {
                place = tasks[indexPath.row]
            }
            
            let newPlaceVC = segue.destination as! NewTaskViewController
            newPlaceVC.currentTask = place
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVC = segue.source as? NewTaskViewController else { return }
        
        newPlaceVC.saveTask()
        tableView.reloadData()
    }
    
    
    // MARK: - Sorting

    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @IBAction func reversedSorting(_ sender: Any) {
        
        ascendingSorting.toggle()
        
        if ascendingSorting {
            reversedSortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reversedSortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        
        sorting()
    }
    
    private func sorting() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            tasks = tasks.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            tasks = tasks.sorted(byKeyPath: "name", ascending: ascendingSorting)
        } else {
            tasks = tasks.sorted(byKeyPath: "status", ascending: ascendingSorting)
        }
        
        tableView.reloadData()
    }
}
