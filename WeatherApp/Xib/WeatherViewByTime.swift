//
//  WeatherViewByTime.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 16.10.21.
//

import UIKit

class WeatherViewByTime: UIView {
    
    // MARK: - Outlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageByTime: UIImageView!
    @IBOutlet weak var tempertureByTime: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
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
        Bundle.main.loadNibNamed("WeatherViewByTime", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
