//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 5.10.21.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    let urlCity = "https://api.openweathermap.org/data/2.5/weather?q=Minsk&apikey=\(apiKey)&units=metric"
    let urlCoordinate = "https://api.openweathermap.org/data/2.5/onecall?lat=30&lon=90&appid=\(apiKey)&units=metric"
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        //var urlString = ""
        switch requestType {
        case .cityName(let city):
            //urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
            
            self.cityRequest(city: urlCity)
        
        case .coordinate(let latitude, let longitude):
            //urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
            
            self.coordinateRequest(coordinate: urlCoordinate)
            
        }
        //performRequest(withURLString: urlString)
    }
    
//    fileprivate func performRequest(withURLString urlString: String) {
//        guard let url = URL(string: urlString) else { return }
//
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { data, response, error in
//            if let data = data {
//                if let currentWeather = self.parseJSON(withData: data) {
//                    self.onCompletion?(currentWeather)
//                }
//            }
//        }
//        task.resume()
//    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData =  try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func cityRequest(city: String) {
        guard let url = URL(string: urlCity) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    private func coordinateRequest(coordinate: String) {
        guard let url = URL(string: urlCoordinate) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
}
