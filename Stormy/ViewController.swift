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


    override func viewDidLoad() {
        super.viewDidLoad()

        if let plistPath = NSBundle.mainBundle().pathForResource("CurrentWeather", ofType: "plist"),
        let weatherDictionary = NSDictionary(contentsOfFile: plistPath),
        let currentWeatherDictionary = weatherDictionary["currently"] as? [String: AnyObject] {

            let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)

            currentTemperatureLabel?.text = "\(currentWeather.temperature)º"
            humidityPercentageLabel?.text = "\(currentWeather.humidity)%"
            rainPercentageLabel?.text = "\(currentWeather.precipProbability)%"

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

