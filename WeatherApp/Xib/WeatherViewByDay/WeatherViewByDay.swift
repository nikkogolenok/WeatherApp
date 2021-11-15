//
//  WeatherViewByDay.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 16.10.21.
//

import UIKit

class WeatherViewByDay: UIView {
    
    // MARK: - Outlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageByDay: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    // MARK: - For using CustonView in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    // MARK: - For using CustomView in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    

    // MARK: - Method
    private func commonInit() {
        Bundle.main.loadNibNamed("WeatherViewByDay", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setUpView(_ daily: Daily /*,weather: CurrentWeather*/) {
        dayLabel.text = Date(timeIntervalSince1970: daily.dt).formatted("dd.MM")
        
        self.imageByDay.image = UIImage(systemName: .defaultSystemWeatherImage)
        
        
        //self.imageByDay.image = UIImage(systemName: weather.conditionCode.systemIconNameString)
        self.maxTemperatureLabel.text = daily.temp.max.wholeNumberString
        self.minTemperatureLabel.text = daily.temp.min.wholeNumberString
    }
    
    func setUpViewImage(_ weather: CurrentWeather) {
        self.imageByDay.image = UIImage(systemName: weather.conditionCode.systemIconNameString)
    }
}