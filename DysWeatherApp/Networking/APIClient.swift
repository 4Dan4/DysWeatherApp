//
//  APIClient.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import Alamofire

class APIClient {
    static func weatherByCity(name: String, completion:@escaping (Result<WeatherData, AFError>)->Void) {
        AF.request(APIRouter.weatherByCity(name: name))
                 .responseDecodable { (response: DataResponse<WeatherData, AFError>) in
            completion(response.result)
        }
    }
}
