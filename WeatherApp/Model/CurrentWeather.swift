//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 30.09.21.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let maxTemperature: Double
    var maxTemperatureString: String {
        return String(format: "%.0f", maxTemperature)
    }
    
    let minTemperature: Double
    var minTemperatureString: String {
        return String(format: "%.0f", minTemperature)
    }
    
    let pressure: Int
    let visibility: Int
    let windSpeed: Double
    
//    init?(currentWeatherData: CurrentWeatherData) {
//        temperature = currentWeatherData.current.temp
//        //maxTemperature = currentWeatherData.daily.temp.max
//        //minTemperature = currentWeatherData.daily.temp.min
//        //pressure = currentWeatherData.daily.pressure
//        visibility = currentWeatherData.current.visibility
//        windSpeed = currentWeatherData.current.windSpeed
//    }
}
