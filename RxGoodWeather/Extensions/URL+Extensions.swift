//
//  URL+Extensions.swift
//  RxGoodWeather
//
//  Created by 登秝吳 on 12/07/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation

extension URL {
  static func urlForWeatherAPI(city: String) -> URL? {
    return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city )&appid=05425d97024c65fcefc5c7e7a5beb6ae")
  }
}
