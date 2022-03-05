//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 30.09.21.
//

import Foundation

struct CurrentWeather {
    let temperature: Double
    let feelLikeTemperature: Double
    let maxTemperature: Double
    let minTemperature: Double
    let pressure: Int
    let humidity: Int
    let visibility: Int
    let windSpeed: Double
    let conditionCode: Int?
    let backgroundImageCode: Int?
    let textTypeWeather: Int?
    let weatherDataHourly: [WeatherDataHourly]

    init(currentWeatherCoordinate: CurrentWeatherDataByCoordinate) {
        temperature = currentWeatherCoordinate.current.temp
        feelLikeTemperature = currentWeatherCoordinate.current.feelsLike
        maxTemperature = currentWeatherCoordinate.current.temp
        minTemperature =  currentWeatherCoordinate.current.temp
        pressure = currentWeatherCoordinate.current.pressure
        humidity = currentWeatherCoordinate.current.humidity
        visibility = currentWeatherCoordinate.current.visibility
        windSpeed = currentWeatherCoordinate.current.windSpeed
        conditionCode = currentWeatherCoordinate.current.weather.first?.id
        backgroundImageCode = currentWeatherCoordinate.current.weather.first?.id
        textTypeWeather = currentWeatherCoordinate.current.weather.first?.id
        
        var weatherDataDictionary = [Date: [Hourly]]()
        currentWeatherCoordinate.hourly.forEach {
            let date = Date(timeIntervalSince1970: $0.dt)
            let hour = Calendar.current.component(.hour, from: date)
            guard hour % 2 == 0 else { return }
            let day = Calendar.current.startOfDay(for: date)
            weatherDataDictionary[day, default: []].append($0)
        }
        self.weatherDataHourly = weatherDataDictionary.map {
            WeatherDataHourly(date: $0.key, hourly: $0.value)
        }
    }
    
    func getDataWeather() -> [String] {
        return ["Temperature: \(String(temperature)), feel like temperature: \(feelLikeTemperature), pressure: \(pressure), humidity: \(humidity), visibility: \(visibility), windSpeed: \(windSpeed)!"]
    }
}

struct WeatherDataHourly {
    let date: Date
    let hourly: [Hourly]
}
