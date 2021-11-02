//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 29.09.21.
//

import UIKit
import RxSwift
import RxCocoa

class LocationViewController: UIViewController {
    
    // MARK: - Varaibles
    var isEditMode = false
    private var disposeBag = DisposeBag()
    
    var objects = [
        LocationData(countryName: "Беларусь", cityName: "Минск", temperature: "10"),
        LocationData(countryName: "Россия", cityName: "Москва", temperature: "15"),
        LocationData(countryName: "Украина", cityName: "Киев", temperature: "20")
    ]
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchLocationTF: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil),
                           forCellReuseIdentifier: LocationTableViewCell.identifier)
        
        addBarButtonsItem()
        
        searchLocationTF.rx
            .text
            .distinctUntilChanged()
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] text in
                self?.searchCityByName(name: text)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tapForCellOpenMainVC()
    }
    
    private func addBarButtonsItem() {
        
        let rightBarButton = UIBarButtonItem(title: isEditMode ? "Готово" : "Править",
                                          style: .done,
                                          target: self,
                                          action: #selector(updateTableView))
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Method
    private func searchCityByName(name: String?) {
        guard let cityName = name else { return }
        
        NetworkWeatherManager.shared.fetchCurrentWeather(forRequestType: .cityName(city: cityName))
        NetworkWeatherManager.shared.onCompletion = { data in
//            objects.append(LocationData(countryName: ., cityName: <#T##String#>, temperature: <#T##String#>))
            // reload table view
        }
    }
    
    func tapForCellOpenMainVC() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMainVC(_:)))
        tableView.addGestureRecognizer(tapGesture)
        tableView.isUserInteractionEnabled = true
    }

    // MARK: - Actions
    @objc func goBackOnMainView() {
        dismiss(animated: true)
    }
    
    @objc func updateTableView() {
        dismiss(animated: true)
    }
    
    @objc private func openMainVC(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}
