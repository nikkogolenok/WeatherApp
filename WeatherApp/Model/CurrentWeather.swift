//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 30.09.21.
//

import Foundation

struct CurrentWeather {
    var cityName: String?
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

    init(currentWeatherCoordinate: CurrentWeatherDataByCoordinate) {
        cityName = nil
        coordinate = Coord(lon: Double(currentWeatherCoordinate.lon), lat: Double(currentWeatherCoordinate.lat))
        temperature = currentWeatherCoordinate.current.temp
        
        // Convert daily.dt to Date. Compare it to current date
        let daily = currentWeatherCoordinate.daily.first { $0.dt == currentWeatherCoordinate.current.dt }
        feelLikeTemperature = currentWeatherCoordinate.current.feelsLike
        maxTemperature = daily?.temp.day ?? temperature
        minTemperature = daily?.temp.day ?? temperature
        pressure = currentWeatherCoordinate.current.pressure
        humidity = currentWeatherCoordinate.current.humidity
        visibility = currentWeatherCoordinate.current.visibility
        windSpeed = currentWeatherCoordinate.current.windSpeed
        conditionCode = currentWeatherCoordinate.current.weather.first?.id
        sunrise = currentWeatherCoordinate.current.sunrise
        sunset = currentWeatherCoordinate.current.sunset
    }
}
