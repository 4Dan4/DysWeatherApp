//
//  WeatherDetailView.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import UIKit
import SnapKit

class WeatherDetailView: UIViewController {
    
    // MARK: - Parametres
    var city: Cities!
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = (city.name ?? "") + " - " + "\(city.tempMax)" + "K"
        return label
    }()
    
    private lazy var cityVisibility: UILabel = {
        let label = UILabel()
        label.text = "Visibility - \(city.visibility) miles"
        return label
    }()
    
    private lazy var feelsLike: UILabel = {
        let label = UILabel()
        label.text = "Feels like - \(city.feelsLike)K"
        return label
    }()
    
    private lazy var tempMax: UILabel = {
        let label = UILabel()
        label.text = "Max temperature - \(city.tempMax)K"
        return label
    }()
    
    private lazy var tempMin: UILabel = {
        let label = UILabel()
        label.text = "Min temperature - \(city.tempMin)K"
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        addConstraints()
        
    }
    
    // MARK: - Add constraints
    func addConstraints() {
        
        view.addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(20)
        }
        
        view.addSubview(cityVisibility)
        cityVisibility.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel).inset(30)
            make.left.equalToSuperview().inset(20)
        }
     
        view.addSubview(feelsLike)
        feelsLike.snp.makeConstraints { make in
            make.top.equalTo(cityVisibility).inset(30)
            make.left.equalToSuperview().inset(20)
        }
        
        view.addSubview(tempMax)
        tempMax.snp.makeConstraints { make in
            make.top.equalTo(feelsLike).inset(30)
            make.left.equalToSuperview().inset(20)
        }
        
        view.addSubview(tempMin)
        tempMin.snp.makeConstraints { make in
            make.top.equalTo(tempMax).inset(30)
            make.left.equalToSuperview().inset(20)
        }
        
    }
}

