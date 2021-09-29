//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 29.09.21.
//

import UIKit

class LocationViewController: UIViewController {
    
    // MARK: - Varaibles
    var isEditMode = false
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addBarButtonsItem()
    }
    
    private func addBarButtonsItem() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(goBackOnMainView))
        
        let rightBarButton = UIBarButtonItem(title: isEditMode ? "Готово" : "Править",
                                          style: .done,
                                          target: self,
                                          action: #selector(updateTableView))
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Actions
    @objc func goBackOnMainView() {
        dismiss(animated: true)
    }
    
    @objc func updateTableView() {
        
    }
}
