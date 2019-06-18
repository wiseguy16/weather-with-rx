//
//  DailyCellRx.swift
//  OmicronWeather
//
//  Created by Greg Weiss on 5/24/19.
//  Copyright © 2019 weissguygreg. All rights reserved.
//

import UIKit

class DailyCellRx: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with element: WeatherDailyItem) {
        let day = Converter.makeDayString(from: element.dt)
        dayLabel.text = day
        highTempLabel.text = "\(element.temp.maxFht)"
        lowTempLabel.text = "\(element.temp.minFht)"
        conditionsLabel.text = "\(element.weather.first?.main ?? "")"
        let imageIconId = element.weather.first?.icon ?? ""
        let iconImage = UIImage(named: "\(imageIconId)")
        iconImageView.image = iconImage
    }

}
