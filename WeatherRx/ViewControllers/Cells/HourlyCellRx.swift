//
//  HourlyCellRx.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/25/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import UIKit

class HourlyCellRx: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with element: WeatherHourItem) {
        let readableTime = Converter.makeTimeString(from: element.dt)
        timeLabel.text = "\(readableTime)"
        tempLabel.text = " \(element.main.tempFht)°"
        conditionsLabel.text = "\(element.weather.first?.main ?? "")"
        humidityLabel.text = "Humidity  \(element.main.humidity)%"
        let metricSpeed = element.wind?.speed ?? 0.0
        let mphSpeed = Converter.speedMetersToMilesPerHr(speed: metricSpeed)
        windLabel.text = "Wind  \(mphSpeed) mph"
        let imageIconId = element.weather.first?.icon ?? ""
        let iconImage = UIImage(named: "\(imageIconId)")
        iconImageView.image = iconImage
    }

}
