//
//  FLocationManager.swift
//  follower
//
//  Created by Luke Wakeford on 28/08/2020.
//

import MapKit

protocol FLocationManagerDelegate: AnyObject {
    func locationPermissionGranted()
    func locationPermissionsLimited()
    func locationChanged(location:CLLocation)
    func shapeDataUpdated(shape:MKPolyline)
}

class FLocationManager:NSObject, CLLocationManagerDelegate {
    
    static let shared = FLocationManager()
    let locationManager = CLLocationManager()
    weak var delegate:FLocationManagerDelegate?
    var locations = [CLLocation]() {
        didSet {
            guard let del = self.delegate else {
                return
            }
            let coordinatesArray = locations.map { location in
                return location.coordinate
            }
            let shape = MKPolyline(
                coordinates: coordinatesArray,
                count: coordinatesArray.count
            )
            del.shapeDataUpdated(shape: shape)
        }
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.distanceFilter = 1
    }
    
    func checkAuthorisationStatus() {
        guard let del = self.delegate else {
            return
        }
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            del.locationPermissionGranted()
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
        default:
            del.locationPermissionsLimited()
        }
    }
    
    func startMonitoring() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopMonitoring() {
        self.locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Location Manager Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorisationStatus()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // store all locations for generating the polyline and stats
        self.locations.append(contentsOf: locations)
        // pass the last location back to the delegate
        guard let lastLocation = locations.last else {
            return
        }
        if let del = self.delegate {
            del.locationChanged(location: lastLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
    
    
}
