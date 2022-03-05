//
//  BottomView.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 27.10.21.
//

import UIKit

class BottomView: UIView {
    
    // MARK: - Outlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var typeWeather: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    // MARK: - For using CustonView in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    // MARK: - For using CustomView in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    // MARK: - Method
    private func commonInit() {
        Bundle.main.loadNibNamed("BottomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setUpViewByWeather(_ weather: CurrentWeather) {
        windSpeed.text = weather.windSpeed.wholeNumberString
        typeWeather.text = weather.textTypeWeather.textNameString
    }
}
