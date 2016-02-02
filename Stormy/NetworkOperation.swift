//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Kellen Pierson on 1/29/16.
//  Copyright © 2016 Kellen Pierson. All rights reserved.
//

import Foundation
import UIKit

class NetworkOperation {

    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL : NSURL

    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void

    init(url: NSURL) {
        self.queryURL = url
    }

    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {

        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in

            // 1. Check HTTP response for successful GET request

            if let httpResponse = response as? NSHTTPURLResponse {

                switch(httpResponse.statusCode) {
                case 200:
                    // 2. Create JSON object with data
                    do {
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                        completion(jsonDictionary)
                    } catch {
                        print(error)

                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                            let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
                            alertController.addAction(action)
                            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
                        })
                    }

                default:
                    print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")

                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let alertController = UIAlertController(title: "Error", message: "Request not successful. HTTP status code: \(httpResponse.statusCode)", preferredStyle: .Alert)
                        let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
                        alertController.addAction(action)
                        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
                    })
                }

            } else {
                print("Error: Not a valid HTTP response")

                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alertController = UIAlertController(title: "Error", message: "Not a valid HTTP response", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
                    alertController.addAction(action)
                    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
                })
            }
        }

        dataTask.resume()
    }

}