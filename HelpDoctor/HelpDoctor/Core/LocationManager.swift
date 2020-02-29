//
//  LocationManager.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 28.01.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import CoreLocation
import UIKit

protocol LocationManagerDelegate: AnyObject {
    func didBeginLocationUpdate()
}

final class LocationManager: NSObject {
    
    static let instance = LocationManager()
    weak var delegate: LocationManagerDelegate?
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 59.939095, longitude: 30.315868)
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    func locationManagerRequestLocation(withPermission permission: CLAuthorizationStatus? = nil) {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            guard let permission = permission else {
                return
            }
            switch permission {
            case .authorizedAlways:
                locationManager.requestAlwaysAuthorization()
            case .authorizedWhenInUse:
                locationManager.requestWhenInUseAuthorization()
            default:
                break
            }
        case .denied:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                      options: [:]) { [weak self] _ in
                                        switch CLLocationManager.authorizationStatus() {
                                        case .authorizedAlways, .authorizedWhenInUse:
                                            self?.locationManager.requestLocation()
                                        default:
                                            break
                                        }
            }
        default:
            break
        }
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        stopUpdatingLocation()
        userLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
