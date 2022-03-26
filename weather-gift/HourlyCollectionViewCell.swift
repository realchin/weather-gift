//
//  HourlyCollectionViewCell.swift
//  weather-gift
//
//  Created by Timothy Chin on 3/26/22.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourlyLabel: UILabel!
    @IBOutlet weak var hourlyTemperature: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var hourlyWeather: HourlyWeather! {
        didSet {
            hourlyLabel.text = hourlyWeather.hour
            iconImageView.image = UIImage(systemName: hourlyWeather.hourlyIcon)
                hourlyTemperature.text = "\(hourlyWeather.hourlyTemperature)°"
        }
    }
}
