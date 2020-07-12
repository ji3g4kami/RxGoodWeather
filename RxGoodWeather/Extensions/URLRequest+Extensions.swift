//
//  URLRequest+Extensions.swift
//  RxGoodWeather
//
//  Created by 登秝吳 on 12/07/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct Resource<T> {
  let url: URL
}

extension URLRequest {
  static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
    return Observable.of(resource.url)
      .flatMap { url -> Observable<Data> in
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
      }
      .map { data -> T in
        return try JSONDecoder().decode(T.self, from: data)
      }
      .asObservable()
  }
}
