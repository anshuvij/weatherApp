//
//  CurrentWeather.swift
//  Rainy shine
//
//  Created by Anshu Vij on 03/05/18.
//  Copyright © 2018 Anshu Vij. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather
{
    var _cityName : String!
    var _date : String!
    var _weatherType : String!
    var _currentTemp : Double!
    
    
    var cityName : String {
        if _cityName == nil
        {
            _cityName = ""
        }
        return _cityName
    }
    
    var date : String
    {
        if _date == nil
        {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today \(currentDate)"
        return _date
    }
    var weatherType : String {
        if _weatherType == nil
        {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp : Double {
        if _currentTemp == nil
        {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed : @escaping DownloadComplete)
    {
        //Alamofire download
        
        //let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        print(CURRENT_WEATHER_URL)
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON{
            response in
            //print(response)
            let result = response.result
            print(result)
            if let dict = result.value as? Dictionary<String,AnyObject>
            {
                if let name = dict["name"] as? String
                {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>]
                {
                    if let main = weather[0]["main"] as? String
                    {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject>
                {
                    if let currentTemp = main["temp"] as? Double
                    {
                        let kelvinToFarenheitPreDiv = (currentTemp * (9/5) - 459.67)
                        let kelvinToFarhen = Double(round(10 * kelvinToFarenheitPreDiv/10))
                        self._currentTemp = kelvinToFarhen
                        print(self._currentTemp)
                        
                        
                    }
                }
            }
        
        completed()
        }
    }
}
