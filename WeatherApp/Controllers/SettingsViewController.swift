//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 29.09.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var temperatureSegmentedControl: UISegmentedControl!
    @IBOutlet weak var speedSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pressureSegmentedControl: UISegmentedControl!
    @IBOutlet weak var languageSelectionSegmentedControl: UISegmentedControl!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBarButtonItem()
    }
    
    // MARK: - Method
    private func addBarButtonItem() {
        let rightBarButton = UIBarButtonItem(title: "Готово",
                                             style: .done,
                                             target: self,
                                             action: #selector(readyAction))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Action
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc func readyAction() {
        dismiss(animated: true)
    }
    
}
