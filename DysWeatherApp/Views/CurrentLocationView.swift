//
//  CurrentLocationView.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

class CurrentLocationWeather: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Parametrs
    let locationManager = CLLocationManager()
    var models = [Cities]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather app"
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.addTarget(self, action: #selector(stepToSettings), for: .touchUpInside)
        return button
    }()
    
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "No data"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "No data"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var visibilityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "No data"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var feelsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "No data"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var weatherType: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Sunny"
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sun.max.fill"))
        image.tintColor = .orange
        return image
    }()
    
    private lazy var mapStepButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "map"), for: .normal)
        button.addTarget(self, action: #selector(stepToMap), for: .touchUpInside)
        return button
    }()
    
    var lon: Double = 0
    
    private var viewModel: WeatherViewModel = WeatherViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        addConstraints()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        setupBinding()
        
    }
    
    // MARK: - Binding
    func setupBinding() {
        
        viewModel.weatherData.bind { [weak self] data in
            guard let self = self else { return }
            
            DispatchQueue.main.async { [self] in
                
                self.tempLabel.text = "Temperature - \(self.viewModel.weatherData.value?.main.temp ?? 0)K"
                self.visibilityLabel.text = "Visibility - \(self.viewModel.weatherData.value?.visibility ?? 0) miles"
                self.feelsLabel.text = "Feels like - \(self.viewModel.weatherData.value?.main.feelsLike ?? 0)K"
            
            }
            
        }
    
    }
    
    // MARK: - Location
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {

        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(
                       placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error
            )
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location: CLLocation = manager.location else { return }
        fetchCityAndCountry(from: location) { [self] city, country, error in
            
            guard let city = city, let country = country, error == nil else { return }
            print(city + ", " + country)
            self.cityName.text = "Current city - \(city)"
            self.viewModel.weatherByCity(name: city)
        
        }
    
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45)
            make.left.equalToSuperview().inset(20)
        }
    
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(20)
        }
    
        view.addSubview(cityName)
        cityName.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).inset(100)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityName).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(visibilityLabel)
        visibilityLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(feelsLabel)
        feelsLabel.snp.makeConstraints { make in
            make.top.equalTo(visibilityLabel).inset(35)
            make.centerX.equalTo(view.center.x)
        }
        
        view.addSubview(weatherType)
        weatherType.snp.makeConstraints { make in
            make.top.equalTo(feelsLabel).inset(35)
            make.centerX.equalTo(view.center.x - 10)
        }
        
        view.addSubview(weatherImage)
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(feelsLabel).inset(40)
            make.centerX.equalTo(view.center.x + 40)
        }
        
        view.addSubview(mapStepButton)
        mapStepButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(25)
        }
        
    }
    
    // MARK: - Steps to other view controllers
    @objc private func stepToSettings() {
        let settingsVC = SettingsView()
        settingsVC.modalPresentationStyle = .fullScreen
        present(settingsVC, animated: true)
    }
    
    @objc private func stepToListVC() {
        let listVC = CitiesListView()
        listVC.modalPresentationStyle = .fullScreen
        present(listVC, animated: true)
    }
    
    @objc private func stepToMap() {
        let mapVC = MapDeatilView()
        mapVC.modalPresentationStyle = .fullScreen
        present(mapVC, animated: true)
    }
    
}
