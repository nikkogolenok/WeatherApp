//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 30.09.21.
//

import Foundation

struct CurrentWeather {
    let cityName: String?
    let coordinate: Coord
    
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
    let humidity: Int
    let visibility: Int
    var visibilityString: String {
        return String(format: "%.0f", visibility)
    }
    
    let windSpeed: Double
    var windSpeedString: String {
        return String(format: "%.0f", windSpeed)
    }
    
    let conditionCode: Int?
    let sunrise: Int?
    let sunset: Int?
    
    var systemIconNameString: String {
        guard let conditionCode = conditionCode else { return "nosign" }
        
        switch conditionCode {
        case 200...232: return "cloud.bold.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800:       return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }

    init?(currentWeatherCoordinate: CurrentWeatherDataByCoordinate) {
        cityName = nil
        coordinate = Coord(lon: Double(currentWeatherCoordinate.lon), lat: Double(currentWeatherCoordinate.lat))
        temperature = currentWeatherCoordinate.current.temp
        
        let daily = currentWeatherCoordinate.current
        
        feelLikeTemperature = daily.feelsLike
        maxTemperature = daily.temp
        minTemperature = daily.temp
        pressure = daily.pressure
        humidity = daily.humidity
        visibility = currentWeatherCoordinate.current.visibility
        windSpeed = currentWeatherCoordinate.current.windSpeed
        conditionCode = nil
        sunrise = daily.sunrise
        sunset = daily.sunset
    }
}
