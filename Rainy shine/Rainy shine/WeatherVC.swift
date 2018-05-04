//
//  WeatherVC
//  Rainy shine
//
//  Created by Anshu Vij on 02/05/18.
//  Copyright © 2018 Anshu Vij. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var currentLoctaionlabel: UILabel!
    @IBOutlet var currentTmpLabel: UILabel!
    
    @IBOutlet var currentWeatherTypeLabel: UILabel!
    @IBOutlet var currentWeatherImage: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    var currentWeather = CurrentWeather()
    var foreCast : Forecast!
    var forecasts = [Forecast]()
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = 80;
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        //foreCast = Forecast()
       // print(CURRENT_WEATHER_URL)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitutde = currentLocation.coordinate.longitude
            print("Current value \(currentLocation)")
            currentWeather.downloadWeatherDetails {
                // setup Ui
                self.downloadForecastData {
                    self.updateMainUI()
                }
                
                
            }
        }
        else
        {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    func downloadForecastData(completed:@escaping DownloadComplete)
    {
       // let forecastUrl = URL(string:FORECAST_URL)
        print(FORECAST_URL)
        Alamofire.request(FORECAST_URL).responseJSON
            {
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>
            {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]
                {
                    for obj in list
                    {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()

        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        else
        {
        return WeatherCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func updateMainUI()
    {
        dateLabel.text = currentWeather.date
        currentTmpLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentLoctaionlabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

