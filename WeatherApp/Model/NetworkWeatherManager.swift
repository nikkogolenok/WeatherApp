//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 5.10.21.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
}
