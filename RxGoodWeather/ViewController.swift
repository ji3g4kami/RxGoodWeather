//
//  ViewController.swift
//  RxGoodWeather
//
//  Created by 登秝吳 on 12/07/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
  
  private var disposeBag = DisposeBag()

  @IBOutlet weak var cityNameTextField: UITextField!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.cityNameTextField.rx.value
      .subscribe(onNext: { [unowned self] city in
        if let city = city {
          if city.isEmpty {
            self.displayWeather(nil)
          } else {
            self.fetchWeather(by: city)
          }
        }
      })
      .disposed(by: disposeBag)
  }
  
  private func displayWeather(_ weather: Weather?) {
    if let weather = weather {
      temperatureLabel.text = "\(weather.temp) ℉"
      humidityLabel.text = "\(weather.humidity)"
    } else {
      temperatureLabel.text = "🙈"
      humidityLabel.text = "⍉"
    }
  }

  private func fetchWeather(by city: String) {
    guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
      let url = URL.urlForWeatherAPI(city: cityEncoded) else {
      return
    }
    let resource = Resource<WeatherResult>(url: url)
    URLRequest.load(resource: resource)
      .observeOn(MainScheduler.instance)
      .catchErrorJustReturn(WeatherResult.empty)
      .subscribe(onNext: { result in
        let weather = result.main
        self.displayWeather(weather)
      })
      .disposed(by: disposeBag)
  }
  
}

