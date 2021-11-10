//
//  CurrentWeatherDataByCity.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 29.09.21.
//

import Foundation
import CoreText

// MARK: - CurrentWeatherDataByCity
struct CurrentWeatherDataByCity: Codable {
    let coord: Coord
    let name: String
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double
    let lat: Double
}
