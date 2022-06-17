//
//  MapDetailView.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapDeatilView: UIViewController, MKMapViewDelegate {
    
    // MARK: - Parameters
    let mapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(button.tintColor, for: .normal)
        button.addTarget(self, action: #selector(stepBack), for: .touchUpInside)
        return button
    }()
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addConstraints()
        
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(0)
            make.left.right.equalToSuperview().inset(0)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(45)
            make.left.equalToSuperview().inset(20)
        }
        
    }
    
    // MARK: - Steps to other view controllers
    @objc private func stepBack() {
        dismiss(animated: true)
    }
    
}

// MARK: CLLocatiuonManagerDelegate
extension MapDeatilView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mapView.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Your location"
        annotation.subtitle = "Current location"
        mapView.addAnnotation(annotation)
        
    }

}
