//
//  APIRouter.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case weatherByCity(name: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .weatherByCity:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .weatherByCity(let name):
            return "/weather?q=\(name)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .weatherByCity:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try (UrlAndKey.ProductionServer.baseURL + path + UrlAndKey.ProductionServer.apiKey).asURL()
        
        var urlRequest = URLRequest(url: url )
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
 
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
