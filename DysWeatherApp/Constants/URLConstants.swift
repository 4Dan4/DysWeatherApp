//
//  URLConstants.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import Foundation

struct UrlAndKey {
    // MARK: URL constants for city
    struct ProductionServer {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
        static let apiKey = "&appid=f7068f7aea2edf395ed544035d7ddf36"
    }
    // MARK: URL constants for cordinates
    struct ProductionServerForLocation {
        static let baseURLLat = "https://api.openweathermap.org/data/2.5/weather?lat="
        static let baseURLLon = "&lon="
        static let apiKey = "&appid=f7068f7aea2edf395ed544035d7ddf36"
    }
    // MARK: for login/password
    struct APIParameterKey {
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
