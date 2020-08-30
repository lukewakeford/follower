//
//  FStatsTest.swift
//  follower-tests
//
//  Created by Luke Wakeford on 30/08/2020.
//

import XCTest

class FStatsTest: XCTestCase {

    override func setUp() {}
    
    override func tearDown() {}
    
    // MARK: - Distance

    func testGetTotalDistance() {
        // normal
        let totalDistance = FStatsHelper.getTotalDistance(forLocations: FTestData.locations)
        XCTAssertTrue(totalDistance == "0.54 miles")
        // single location
        let single = FStatsHelper.getTotalDistance(forLocations: [
            FTestData.locations.first!
        ])
        XCTAssertTrue(single == "0.00 miles")
        // empty
        let empty = FStatsHelper.getTotalDistance(forLocations: [])
        XCTAssertTrue(empty == "0.00 miles")
    }

    // MARK: - Duration
    
    func testGetDuration() {
        // normal
        let duration = FStatsHelper.getDuration(forLocations: FTestData.locations)
        XCTAssertTrue(duration == "0 hr 18 mins 20 secs")
        // single location
        let single = FStatsHelper.getDuration(forLocations: [
            FTestData.locations.first!
        ])
        XCTAssertTrue(single == "0 hr 0 min 0 sec")
        // empty
        let empty = FStatsHelper.getDuration(forLocations: [])
        XCTAssertTrue(empty == "0 hr 0 min 0 sec")
    }
    
    // MARK: - Speed
    
    func testGetAverageSpeed() {
        // normal
        let speed = FStatsHelper.getAverageSpeed(forLocations: FTestData.locations)
        XCTAssertTrue(speed == "4 mph")
        // single location
        let single = FStatsHelper.getAverageSpeed(forLocations: [
            FTestData.locations.first!
        ])
        XCTAssertTrue(single == "2 mph")
        // empty
        let empty = FStatsHelper.getAverageSpeed(forLocations: [])
        XCTAssertTrue(empty == "0 mph")
    }

}
