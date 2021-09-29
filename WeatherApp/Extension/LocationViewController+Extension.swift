//
//  LocationViewController+Extension.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 30.09.21.
//

import UIKit

// MARK: -UITableViewDelegate
extension LocationViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}
