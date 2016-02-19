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
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?

    private let forecastAPIKey = valueForAPIKey(keyname: "API_CLIENT_ID")
    let coordinate: (lat: Double, long: Double) = (40.576436,-122.324904)

    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveWeatherForecast()

    }

    func retrieveWeatherForecast() {
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

                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }

                    if let summary = currentWeather.summary {
                        self.currentWeatherSummary?.text = summary
                    }

                    self.toggleRefreshAnimation(false)
                }
            }
        }
    }

    @IBAction func refreshWeather() {
        retrieveWeatherForecast()
        toggleRefreshAnimation(true)
    }

    func toggleRefreshAnimation(on: Bool) {
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }


}

