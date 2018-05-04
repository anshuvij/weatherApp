//
//  Constants.swift
//  Rainy shine
//
//  Created by Anshu Vij on 03/05/18.
//  Copyright © 2018 Anshu Vij. All rights reserved.
//

import Foundation
//let BASE_URL = "http://samples.openweathermap.org/data/2.5/weather?"
//let Latitude = "lat="
//let Longitude = "&lon="
//let APP_ID = "&appid="
//let API_KEY = "73d6e37a701d2c447867a322d7987a64"

typealias DownloadComplete = () -> ()
let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitutde!)&appid=73d6e37a701d2c447867a322d7987a64"
let FORECAST_URL = "https://samples.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitutde)&cnt=10&appid=73d6e37a701d2c447867a322d7987a64"

