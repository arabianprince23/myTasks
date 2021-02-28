//
//  TableViewDataSourceExtension.swift
//  MyPlaces
//
//  Created by Анас Бен Мустафа on 2/24/21.
//  Copyright © 2021 Ben Mustafa Anas. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPlaces.count
        }
        return tasks.isEmpty ? 0 : tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        var task = Task()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy hh:mm"
        dateFormatter.locale = Locale.init(identifier: "ru")
        
        if isFiltering {
            task = filteredPlaces[indexPath.row]
        } else {
            task = tasks[indexPath.row]
        }
        
        cell.nameLabel.text = task.name
        cell.dateLabel.text = "Created: \(dateFormatter.string(from: task.date))"
        cell.statusLabel.text = "Status: \(task.status ?? "-")"
        cell.taskImage.image = UIImage(data: task.imageData!)
        
        cell.taskImage.layer.cornerRadius = cell.taskImage.frame.size.height / 2
        cell.taskImage.clipsToBounds = true

        return cell
    }
    
}
