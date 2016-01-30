//
//  ViewController.swift
//  Stormy
//
//  Created by Kellen Pierson on 1/25/16.
//  Copyright © 2016 Kellen Pierson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var humidityPercentageLabel: UILabel?
    @IBOutlet weak var rainPercentageLabel: UILabel?

    private let forecastAPIKey = valueForAPIKey(keyname: "API_CLIENT_ID")
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)


    override func viewDidLoad() {
        super.viewDidLoad()

        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) {
            (let currently) in
            if let currentWeather = currently {
                // Update UI
                dispatch_async(dispatch_get_main_queue()) {
                    // Execute closure
                    if let temperature = currentWeather.temperature {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    if let humidity = currentWeather.humidity {
                        self.humidityPercentageLabel?.text = "\(humidity)%"
                    }
                    if let precipitation = currentWeather.precipProbability {
                        self.rainPercentageLabel?.text = "\(precipitation)%"
                    }
                }
            }
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

