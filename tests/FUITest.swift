//
//  FUITest.swift
//  follower-tests
//
//  Created by Luke Wakeford on 30/08/2020.
//

import XCTest

class FUITest: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }

    override func tearDown() {}
    
    func tapMapToDismissLocationPrompt() {
        let app = XCUIApplication()
        let map = app.otherElements["map"]
        map.tap()
    }

    func testMapViewControllerLoad() {
        
        let app = XCUIApplication()
        
        tapMapToDismissLocationPrompt()
        
        let map = app.otherElements["map"]
        map.tap()
        XCTAssertTrue(map.isHittable)
               
        let startFollowingButton = app.buttons["Start Following"]
        XCTAssertTrue(startFollowingButton.isHittable)
        
        let statsButton = app.buttons["View Stats"]
        XCTAssertTrue(statsButton.isHittable)
        
        let clearButton = app.buttons["Clear Session"]
        XCTAssertTrue(clearButton.isHittable)
        
    }
    
    func testOpeningStatsViewController() {
        
        let app = XCUIApplication()
        
        tapMapToDismissLocationPrompt()
        
        let statsButton = app.buttons["View Stats"]
        statsButton.tap()
        
        let title = app.navigationBars["Stats"].staticTexts["Stats"]
        XCTAssertTrue(title.isHittable)

        let distance = app.staticTexts["0.00 miles"]
        XCTAssertTrue(distance.isHittable)
        
        let duration = app.staticTexts["0 hr 0 min 0 sec"]
        XCTAssertTrue(duration.isHittable)
        
        let speed = app.staticTexts["0 mph"]
        XCTAssertTrue(speed.isHittable)
        
    }

}
