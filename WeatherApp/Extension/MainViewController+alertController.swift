//
//  MainViewController+alertController.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 19.10.21.
//

import UIKit

extension MainViewController {
    
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        alertController.addTextField { tf in
            let cities = "Введите название города"
            tf.autocapitalizationType = .words
            tf.placeholder = cities
        }
        
        let searchAction = UIAlertAction(title: "Искать", style: .default) { action in
            
            let textField = alertController.textFields?.first
            
            guard let cityName = textField?.text else { return }
            
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


