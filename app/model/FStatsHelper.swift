//
//  FStatsUtils.swift
//  follower
//
//  Created by Luke Wakeford on 29/08/2020.
//

import Foundation
import MapKit

class FStatsHelper {
    
    class func getTotalDistance(forLocations locations: [CLLocation]) -> String {
        var totalDistance:Double = 0
        var previous:CLLocation?
        for location in locations {
            if let p = previous {
                totalDistance += location.distance(from: p)
            }
            previous = location
        }
        let conversion = Measurement(
            value: totalDistance,
            unit: UnitLength.meters
        )
        let miles = conversion.converted(to: .miles)
        return String(format: "%.02f miles", miles.value)
    }
    
    class func getDuration(forLocations locations: [CLLocation]) -> String {
        guard let start = locations.first,
            let end = locations.last else {
                return "0 hr 0 min 0 sec"
        }
        let cal = Calendar.current
        let components = cal.dateComponents([
            Calendar.Component.hour,
            Calendar.Component.minute,
            Calendar.Component.second
        ], from: start.timestamp, to: end.timestamp)
        var durationParts = [String]()
        if let hours = components.hour {
            durationParts.append(hours > 1 ? "\(hours) hrs" : "\(hours) hr")
        }
        if let minutes = components.minute {
            durationParts.append(minutes > 1 ? "\(minutes) mins" : "\(minutes) min")
        }
        if let seconds = components.second {
            durationParts.append(seconds > 1 ? "\(seconds) secs" : "\(seconds) sec")
        }
        return durationParts.joined(separator: " ")
    }
    
    class func getAverageSpeed(forLocations locations: [CLLocation]) -> String {
        guard locations.count >= 1 else {
            return "0 mph"
        }
        let speeds = locations.map { location in
            return location.speed
        }
        var total = 0.0
        for speed in speeds {
            total += speed
        }
        let mean = total / Double(speeds.count)
        let conversion = Measurement(
            value: mean,
            unit: UnitSpeed.metersPerSecond
        )
        let mph = conversion.converted(to: .milesPerHour)
        return String(format: "%.0f mph", mph.value)
    }
    
}
