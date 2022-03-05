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
    var networkWeatherManager = NetworkWeatherManager.shared
    
    // MARK: - Outlet
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var textFieldForCity: UITextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var leftView: LeftView!
    @IBOutlet weak var rightView: RightView!
    @IBOutlet weak var bottonView: BottomView!
    @IBOutlet weak var imageIconForWeater: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: - Lifecycle
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        textFieldForCity.delegate = self
        mainView.backgroundColor = .black
        mainView.alpha = 0.4
        shareButton.alpha = 0.4
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
    
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateInterfaceWith(weather: currentWeather)
                
                print("Температура \(currentWeather.temperature)")
                print("По ощущениям \(currentWeather.feelLikeTemperature.wholeNumberString)")
                print("Макс темп \(currentWeather.maxTemperature.wholeNumberString)")
                print("Мин темп \(currentWeather.minTemperature.wholeNumberString)")
                print("Давление \(currentWeather.pressure)")
                print("Влажность \(currentWeather.humidity)")
                print("Видимость \(currentWeather.visibility/1000)")
                print("Скорость ветра \(currentWeather.windSpeed.wholeNumberString)")
                
            }
        }
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Methods
    private func updateInterfaceWith(weather: CurrentWeather) {
        self.backgroundImage.image = UIImage(named: weather.backgroundImageCode.backgroundNameString)
        // MainView
        self.imageIconForWeater.image = UIImage(systemName: weather.conditionCode.systemIconNameString)
        // TopView
        self.topView.temperatureLabel.text = weather.temperature.wholeNumberString
        self.topView.feelsLikeTemperatureLabel.text = weather.feelLikeTemperature.wholeNumberString
        // LeftView
        self.leftView.maxTemperature.text = weather.maxTemperature.wholeNumberString
        self.leftView.pressureValueLabel.text = String(weather.pressure)
        // RightView
        self.rightView.minTemperature.text = weather.minTemperature.wholeNumberString
        self.rightView.visibilityValueLabel.text = String(weather.visibility/1000)
        // BottomView
        self.bottonView.typeWeather.text = weather.textTypeWeather.textNameString
        self.bottonView.windSpeed.text = weather.windSpeed.wholeNumberString
    }
    
    func getCoordinateFrom(address: String) {
        CLGeocoder().geocodeAddressString(address) { [weak self] coordinate, error in
            guard let coordinate = coordinate?.first?.location?.coordinate,
                  error == nil,
                  let self = self
            else { return }
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
    }
    
    // MARK: - Actions
    @IBAction func goToMapVC(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as? MapViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func goToSettingsVC(_ sender: UIButton) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as? SettingsViewController else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func ShareButtonAction(_ sender: UIButton) {
        guard let weatherForShare = NetworkWeatherManager.shared.currentWeather?.getDataWeather() else { return }
        
        let shareController = UIActivityViewController(activityItems: weatherForShare, applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Share button worked!")
            }
        }
        present(shareController, animated: true, completion: nil)
    }
}

