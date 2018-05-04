//
//  WeatherCell.swift
//  Rainy shine
//
//  Created by Anshu Vij on 05/05/18.
//  Copyright © 2018 Anshu Vij. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet var highTemp: UILabel!
    
    @IBOutlet var lowTemp: UILabel!
    @IBOutlet var weatherType: UILabel!
    @IBOutlet var dayLabel: UILabel!
    

    @IBOutlet var weatherIcon: UIImageView!
    
    
    func configureCell(forecast : Forecast)
    {
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named:forecast.weatherType)
    }

}
