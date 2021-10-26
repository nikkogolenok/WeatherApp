//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 29.09.21.
//

import UIKit
import RxSwift

class LocationViewController: UIViewController {
    
    // MARK: - Varaibles
    var isEditMode = false
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchLocationTF: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addBarButtonsItem()
        searchCityByName(name: "")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func addBarButtonsItem() {
//        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
//                                            style: .plain,
//                                            target: self,
//                                            action: #selector(goBackOnMainView))
        
        let rightBarButton = UIBarButtonItem(title: isEditMode ? "Готово" : "Править",
                                          style: .done,
                                          target: self,
                                          action: #selector(updateTableView))
        
        //navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Method
    private func searchCityByName(name: String) {
        guard let cityName = searchLocationTF.text else { return }
        NetworkWeatherManager.shared.fetchCurrentWeather(forRequestType: .cityName(city: cityName))
    }
    
    
    
    // MARK: - Actions
    @objc func goBackOnMainView() {
        dismiss(animated: true)
    }
    
    @objc func updateTableView() {
        dismiss(animated: true)
    }
}
