//
//  WeatherResult.swift
//  RxGoodWeather
//
//  Created by 登秝吳 on 12/07/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation

struct WeatherResult: Decodable {
  let main: Weather
}

extension WeatherResult {
  static let empty = WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
}

struct Weather: Decodable {
  let temp: Double
  let humidity: Double
}
