//
//  LocationManager.swift
//  Legio
//
//  Created by Mikhail Semerikov on 09.11.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationManagerDelegate {
    func locationManager(didUpdateLocations locations: [CLLocation])
    func locationManager(didFailWithError error: NSError)
    func locationManager(authorizationStatusChanged status: CLAuthorizationStatus)
}

extension LocationManagerDelegate {
    func locationManager(didFailWithError error: NSError) {
        print("locationManager:didFailWithError: " + error.description)
    }
    
    func locationManager(authorizationStatusChanged status: CLAuthorizationStatus) {
        print(status)
    }
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private struct Constants {
        static let metresInKm: Double = 1000
        static let secondsInHour: Double = 3600
        static let secondsInMinutes: Double = 60
    }
    
    static let sharedManager = LocationManager()
    var userLocation: CLLocation?
    let locationManager = CLLocationManager()
    var delegate: LocationManagerDelegate?
    var authorizationStatus = CLAuthorizationStatus.notDetermined
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.activityType = CLActivityType.automotiveNavigation
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func start() -> Bool {
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            return true
        }
        return false
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let delegate = self.delegate {
            delegate.locationManager(didUpdateLocations: locations)
        }
        else {
            let startLocation = locations.last
            self.userLocation = startLocation
            print("latitude: " + (startLocation?.coordinate.latitude.description)! + ", longitude: " + (startLocation?.coordinate.longitude.description)!)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        
        if let delegate = self.delegate {
            delegate.locationManager(authorizationStatusChanged: authorizationStatus)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let delegate = self.delegate {
            delegate.locationManager(didFailWithError: error as NSError)
        }
        else {
            print("locationManager:didFailWithError: " + error.localizedDescription)
        }
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        print("paused location updates")
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        print("resumed location updates")
    }
    
    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    func getWalkingDistance(destination: [String], completion: @escaping (String?, Double?) -> Void) {
        guard let currentCoordinate = userLocation?.coordinate,
            let latitude = Double(destination[0]),
            let longitude = Double(destination[1]),
            authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways  else {
            completion(nil, nil)
            return
        }
        
        let destinationCoordinate = CLLocationCoordinate2D(latitude: latitude,
                                                           longitude: longitude)
        let request = buildDirectionRequest(source: currentCoordinate, destination: destinationCoordinate)
        let directionRequest = MKDirections(request: request)
        makeDirectionsRequest(directionRequest, completion: completion)
    }
    
    private func buildDirectionRequest(source: CLLocationCoordinate2D,
                                       destination: CLLocationCoordinate2D) -> MKDirections.Request {
        let request = MKDirections.Request()
        let sourcePlacemark = MKPlacemark(coordinate: source)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile
        return request
    }
    
    private func makeDirectionsRequest(_ directionRequest: MKDirections, completion: @escaping (String?, Double?) -> Void) {
        directionRequest.calculateETA { [weak self] (directions, error) in
            guard let directions = directions, error == nil else {
                completion(nil, nil)
                return
            }
            guard let distance = self?.convertDistanceToKilometers(directions.distance),
                let travelTime = self?.convertTravelTimeToMinutes(directions.expectedTravelTime) else {
                completion(nil, nil)
                return
            }
            let travelInfoString = "\(travelTime)"
            completion(travelInfoString, directions.distance)
        }
    }
    
    private func convertDistanceToKilometers(_ distance: CLLocationDistance) -> String {
        let kilometers = distance / Constants.metresInKm
        return "\(String(format: "%.2f", kilometers))км"
    }
    
    private func convertTravelTimeToMinutes(_ travelTime: TimeInterval) -> String {
        let hours = Int(travelTime / Constants.secondsInHour)
        var timeString = hours > 0 ? "\(hours) ч " : ""
        let minutes = Int(travelTime.truncatingRemainder(dividingBy: Constants.secondsInHour) / Constants.secondsInMinutes)
        timeString += minutes > 0 ? "\(minutes) мин" : ""
        return timeString
    }

}
