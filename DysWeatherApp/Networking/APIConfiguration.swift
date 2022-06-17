//
//  APIConfiguration.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
