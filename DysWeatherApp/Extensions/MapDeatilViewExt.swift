//
//  MapDeatilViewExt.swift
//  DysWeatherApp
//
//  Created by dan4 on 12.06.2022.
//

import UIKit

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
