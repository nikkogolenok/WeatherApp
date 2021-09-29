//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 29.09.21.
//

import UIKit

extension UIView {
    
    // MARK: - CornerRadius
    func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    // MARK: - Shadow
    func addShadow(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
    }
}
