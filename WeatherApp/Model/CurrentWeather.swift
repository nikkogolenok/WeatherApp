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
    let sunrise: Int?
    let sunset: Int?
    let dailyWeather: [Daily]
    let hourlyWeather: [Hourly]

    init(currentWeatherCoordinate: CurrentWeatherDataByCoordinate) {
        cityName = nil
        coordinate = Coord(lon: Double(currentWeatherCoordinate.lon), lat: Double(currentWeatherCoordinate.lat))
        temperature = currentWeatherCoordinate.current.temp
        
        let daily = currentWeatherCoordinate.daily.first {
            let date = Date(timeIntervalSince1970: $0.dt)
            
            return Calendar.current.isDateInToday(date)
        }
        
        feelLikeTemperature = currentWeatherCoordinate.current.feelsLike
        maxTemperature = daily?.temp.max ?? temperature
        minTemperature = daily?.temp.min ?? temperature
        pressure = currentWeatherCoordinate.current.pressure
        humidity = currentWeatherCoordinate.current.humidity
        visibility = currentWeatherCoordinate.current.visibility
        windSpeed = currentWeatherCoordinate.current.windSpeed
        conditionCode = currentWeatherCoordinate.current.weather.first?.id
        backgroundImageCode = currentWeatherCoordinate.current.weather.first?.id
        textTypeWeather = currentWeatherCoordinate.current.weather.first?.id
        sunrise = currentWeatherCoordinate.current.sunrise
        sunset = currentWeatherCoordinate.current.sunset
        self.dailyWeather = currentWeatherCoordinate.daily
        hourlyWeather = currentWeatherCoordinate.hourly
    }
}
