//
//  FTestData.swift
//  follower
//
//  Created by Luke Wakeford on 30/08/2020.
//

import MapKit

class FTestData {
    static let locations = [
        CLLocation(
            coordinate: CLLocationCoordinate2D(
                latitude: 50.736751,
                longitude: -1.880278
            ),
            altitude: 0.0,
            horizontalAccuracy: 5.0,
            verticalAccuracy: 5.0,
            course: 0.0,
            speed: 0.89, // 2mph
            timestamp: Date(timeIntervalSinceNow: 0.0)
        ),
        CLLocation(
            coordinate: CLLocationCoordinate2D(
                latitude: 50.738448,
                longitude: -1.879870
            ),
            altitude: 0.0,
            horizontalAccuracy: 5.0,
            verticalAccuracy: 5.0,
            course: 0.0,
            speed: 1.34, // 3mph
            timestamp: Date(timeIntervalSinceNow: 300)
        ),
        CLLocation(
            coordinate: CLLocationCoordinate2D(
                latitude: 50.740516,
                longitude: -1.879424
            ),
            altitude: 0.0,
            horizontalAccuracy: 5.0,
            verticalAccuracy: 5.0,
            course: 0.0,
            speed: 1.79, // 4mph
            timestamp: Date(timeIntervalSinceNow: 700)
        ),
        CLLocation(
            coordinate: CLLocationCoordinate2D(
                latitude: 50.744456,
                longitude: -1.878575
            ),
            altitude: 0.0,
            horizontalAccuracy: 5.0,
            verticalAccuracy: 5.0,
            course: 0.0,
            speed: 2.24, // 5mph
            timestamp: Date(timeIntervalSinceNow: 1100)
        )
    ]
}
