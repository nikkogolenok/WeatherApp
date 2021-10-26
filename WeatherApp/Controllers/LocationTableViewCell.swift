//
//  LocationTableViewCell.swift
//  WeatherApp
//
//  Created by Никита Коголенок on 14.10.21.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    // MARK - Outlet
    @IBOutlet weak var imageLocation: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
