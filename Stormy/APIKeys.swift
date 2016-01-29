//
//  APIKeys.swift
//  Stormy
//
//  Created by Kellen Pierson on 1/28/16.
//  Copyright © 2016 Kellen Pierson. All rights reserved.
//

import Foundation

func valueForAPIKey(keyname keyname: String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("APIKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)

    let value: String = plist?.objectForKey(keyname) as! String
    return value
}