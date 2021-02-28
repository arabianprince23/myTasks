//
//  SearchResultsUpdatingExtensions.swift
//  MyPlaces
//
//  Created by Анас Бен Мустафа on 2/24/21.
//  Copyright © 2021 Ben Mustafa Anas. All rights reserved.
//

import UIKit

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {

        filteredPlaces = tasks.filter("name CONTAINS[c] %@ OR status CONTAINS[c] %@", searchText, searchText)

        tableView.reloadData()
    }
    
}
