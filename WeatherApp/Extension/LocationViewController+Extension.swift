//
//  LocationViewController+Extension.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 30.09.21.
//

import UIKit

// MARK: -UITableViewDelegate
extension LocationViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UITableViewDataSource
extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier,
                                                       for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        
        let object = objects[indexPath.row]
        cell.set(object: object)
        
        return cell
    }
}
