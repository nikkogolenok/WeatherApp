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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var leftView: LeftView!
    @IBOutlet weak var rightView: RightView!
    @IBOutlet weak var bottonView: BottomView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var imageIconForWeater: UIImageView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var weatherViewByDay: WeatherViewByDay!
    @IBOutlet weak var weatherViewByTime: WeatherViewByTime!
    @IBOutlet weak var weatherByDayStackView: UIStackView!
    @IBOutlet weak var weatherByTimeStackView: UIStackView!
    
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
                print("По ощущениям \(currentWeather.feelLikeTemperature.wholeNumberString)")
                print("Макс темп \(currentWeather.maxTemperature.wholeNumberString)")
                print("Мин темп \(currentWeather.minTemperature.wholeNumberString)")
                print("Давление \(currentWeather.pressure)")
                print("Влажность \(currentWeather.humidity)")
                print("Видимость \(currentWeather.visibility/1000)")
                print("Скорость ветра \(currentWeather.windSpeed.wholeNumberString)")
                print("Восход \(String(describing: currentWeather.sunrise))")
                print("закат \(String(describing: currentWeather.sunset))")
                
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
        self.cityName.text = weather.cityName
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
        
        // look BottomView
        self.bottonView.windSpeed.text = weather.windSpeed.wholeNumberString
        // WeatherViewByDay
        for dailyWeatherByDay in weather.dailyWeather {
            let view = WeatherViewByDay()
            view.setUpView(dailyWeatherByDay)
            self.weatherByDayStackView.addArrangedSubview(view)
        }
        // WeatherViewByTime
        
        // look WeatherViewByTime
//        for dailyWeatherByTime in weather {
//            let view = WeatherViewByTime()
//            view.setUpView(dailyWeatherByTime)
//            self.weatherByTimeStackView.addArrangedSubview(view)
//        }
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
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Введите город", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
}

