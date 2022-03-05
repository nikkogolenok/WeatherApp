//
//  CurrentWeatherDataByCoordinate.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 18.10.21.
//

import Foundation

// MARK: - CurrentWeatherDataByCoordinate
struct CurrentWeatherDataByCoordinate: Codable {
    let lat: Double
    let lon: Double
    let current: Current
    let minutely: [Minutely]
    let hourly: [Hourly]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case current
        case hourly
        case minutely
        case daily
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let visibility: Int
    let windSpeed: Double
    let windGust: Double
    let weather: [Weather]
    let pop: Double?

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case visibility
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case weather
        case pop
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int

    enum CodingKeys: String, CodingKey {
        case id
    }
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt: Int
    let precipitation: Int
}

// MARK: - Hourly
struct Hourly: Codable {
    let dt: Int
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
    }
}

struct Daily: Codable {
    let temp: Temp
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
}

struct Temp: Codable {
    let max: Double
    let min: Double
}
