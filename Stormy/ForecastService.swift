//
//  ForecastService.swift
//  Stormy
//
//  Created by Kellen Pierson on 1/29/16.
//  Copyright © 2016 Kellen Pierson. All rights reserved.
//

import Foundation

struct ForecastService {

    let forecastAPIKey: String
    let forecastBaseURL: NSURL?

    init(APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }

    func getForecast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)) {
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL) {

            let networkOperation = NetworkOperation(url: forecastURL)

            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
                completion(currentWeather)
            }

        } else {
            print("Could not contruct a valid URL")
        }
    }

    func currentWeatherFromJSON(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        } else {
            print("JSON object returned nil for 'currently' key")
            return nil
        }
    }

}