//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 28.09.21.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    // MARK: - Variables
    let locationManager = CLLocationManager()
    var networkWeatherManager = NetworkWeatherManager()
    
    // MARK: - Outlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cityLabel: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var imageIconForWeater: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Lifecycle
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateInterfaceWith(weather: currentWeather)
            }
            
            print(currentWeather.cityName)
            print(currentWeather.temperature)
            print(currentWeather.conditionCode)
            print(currentWeather.maxTemperature)
            print(currentWeather.minTemperature)
            print(currentWeather.feelLikeTemperature)
            print(currentWeather.visibility)
            print(currentWeather.pressure)
        }
        //networkWeatherManager.fetchCurrentWeather(forRequestType: ))
        
        
        mainView.backgroundColor = .green
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        locationManager.requestAlwaysAuthorization()
        let status = locationManager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        }
        
        
        
       
        
        
    }
    
    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainView.addCornerRadius(radius: mainView.frame.width / 2)
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Methods
    private func updateInterfaceWith(weather: CurrentWeather) {
        self.temperatureLabel.text = weather.temperatureString
        self.feelsLikeTemperatureLabel.text = weather.feelLikeTemperatureString
        self.maxTemperatureLabel.text = weather.maxTemperatureString
        self.minTemperatureLabel.text = weather.minTemperatureString
        self.pressureLabel.text = String(weather.pressure)
        self.visibilityLabel.text = String(weather.visibility)
        self.imageIconForWeater.image = UIImage(systemName: weather.systemIconNameString)
    }
    // MARK: - Actions
    @IBAction func goToMapVC(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as? MapViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func goToSearchVC(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? LocationViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func goToSettingsVC(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as? SettingsViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

