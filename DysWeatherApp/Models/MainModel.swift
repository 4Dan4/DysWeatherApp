//
//  MainModel.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let base: String
    let id, dt: Int
    let main: Main
    let coord: Coord
    let wind: Wind
    let sys: Sys
    let weather: [Weather]
    let visibility: Int
    let clouds: Clouds
    let timezone, cod: Int
    let name: String
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let tempMax: Double
    let humidity: Int
    let feelsLike, tempMin, temp: Double
    let pressure: Int

    enum CodingKeys: String, CodingKey {
        case tempMax = "temp_max"
        case humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case temp, pressure
    }
}

// MARK: - Sys
struct Sys: Codable {
    let id: Int
    let country: String
    let sunset, type, sunrise: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, icon, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case weatherDescription = "description"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
