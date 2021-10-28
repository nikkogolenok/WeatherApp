//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 28.09.21.
//

import UIKit
import CoreLocation
import RxSwift

class MainViewController: UIViewController {

    // MARK: - Variables
    let locationManager = CLLocationManager()
    var networkWeatherManager = NetworkWeatherManager.shared
    private let disposeBag = DisposeBag()
    
    // MARK: - Outlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var leftView: LeftView!
    @IBOutlet weak var rightView: RightView!
    @IBOutlet weak var bottonView: BottomView!
    @IBOutlet weak var cityLabel: UIButton!
    @IBOutlet weak var imageIconForWeater: UIImageView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var weatherViewByDay: WeatherViewByDay!
    @IBOutlet weak var weatherViewByTime: WeatherViewByTime!
    
    // MARK: - Lifecycle
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainView.backgroundColor = .black
        mainView.alpha = 0.4
        footerView.alpha = 0.5
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
                print("Город \(String(describing: currentWeather.cityName))") 
                print("Температура \(currentWeather.temperature)")
                print("По ощущениям \(currentWeather.feelLikeTemperatureString)")
                print("Макс темп \(currentWeather.maxTemperatureString)")
                print("Мин темп \(currentWeather.minTemperatureString)")
                print("Давление \(currentWeather.pressure)")
                print("Влажность \(currentWeather.humidity)")
                print("Видимость \(currentWeather.visibility/1000)")
                print("Скорость ветра \(currentWeather.windSpeedString)")
                print("Восход \(currentWeather.sunrise)")
                print("закат \(currentWeather.sunset)")
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
        // MainView
        self.imageIconForWeater.image = UIImage(systemName: weather.systemIconNameString)
        // TopView
        self.topView.temperatureLabel.text = weather.temperatureString
        self.topView.feelsLikeTemperatureLabel.text = weather.feelLikeTemperatureString
        // LeftView
        self.leftView.maxTemperature.text = weather.maxTemperatureString
        self.leftView.pressureValueLabel.text = String(weather.pressure)
        // RightView
        self.rightView.minTemperature.text = weather.minTemperatureString
        self.rightView.visibilityValueLabel.text = String(weather.visibility/1000)
        // BottomView
        self.bottonView.windSpeed.text = weather.windSpeedString
        // WeatherViewByDay
        self.weatherViewByDay.imageByDay.image = UIImage(systemName: weather.systemIconNameString)
        self.weatherViewByDay.maxTemperatureLabel.text = weather.maxTemperatureString
        self.weatherViewByDay.minTemperatureLabel.text = weather.minTemperatureString
        // WeatherViewByTime
        self.weatherViewByTime.imageByTime.image = UIImage(systemName: weather.systemIconNameString)
        self.weatherViewByTime.tempertureByTime.text = weather.temperatureString
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
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Введите город", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
}

