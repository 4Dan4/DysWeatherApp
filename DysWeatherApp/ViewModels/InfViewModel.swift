//
//  InfViewModel.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import Foundation
import Alamofire

final class WeatherViewModel {
    
    var weatherData: Observable<WeatherData?> = Observable(nil)
    var cities = Cities.self
    var currentLocationCity: WeatherData?
    
    @objc func weatherByCity(name: String) {
        APIClient.weatherByCity(name: name) { result in
            switch result {
            case .success(let weather):
                self.weatherData.value = weather
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
