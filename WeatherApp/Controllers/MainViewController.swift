//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 28.09.21.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cityLabel: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.addCornerRadius(radius: mainView.frame.width / 2)
        mainView.backgroundColor = .green
    }
    
    // MARK: - Methods
    
    // MARK: - Actions
}

