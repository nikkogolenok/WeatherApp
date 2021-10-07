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
    
    let feelLikeTemperature: Double
    var feelLikeTemperatureString: String {
        return String(format: "%.0f", feelLikeTemperature)
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
    
    
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelLikeTemperature = currentWeatherData.main.feelsLike
        maxTemperature = currentWeatherData.main.tempMax
        minTemperature = currentWeatherData.main.tempMin
        pressure = currentWeatherData.main.pressure
        visibility = currentWeatherData.visibility
        windSpeed = currentWeatherData.wind.speed
    }
}
