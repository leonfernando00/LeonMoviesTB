//
//  LeonMoviesTBUITests.swift
//  LeonMoviesTBUITests
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import XCTest

class LeonMoviesTBUITests: XCTestCase {
    
    func testMainComponents() {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.tables[LMConstants.AccessibilityIdentifier.tableView].exists)
        XCTAssert(app.tables[LMConstants.AccessibilityIdentifier.tableView].cells[LMConstants.AccessibilityIdentifier.secondCell].exists)
        XCTAssert(app.navigationBars.buttons[LMConstants.AccessibilityIdentifier.navBarRightButton].exists)
    }
    
    func testRouteToMovieDetails() {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables[LMConstants.AccessibilityIdentifier.tableView]
        tableView.cells[LMConstants.AccessibilityIdentifier.firstCell].tap()
        XCTAssert(app.buttons[LMConstants.AccessibilityIdentifier.playVideoButton].exists)
    }
    
    func testRouteToDifferentMovies() {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables[LMConstants.AccessibilityIdentifier.tableView]
        tableView.cells[LMConstants.AccessibilityIdentifier.firstCell].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        tableView.swipeUp()
        tableView.cells.element(matching: .cell, identifier: LMConstants.AccessibilityIdentifier.fifthCell).tap()
        XCTAssert(app.buttons[LMConstants.AccessibilityIdentifier.playVideoButton].exists)
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func testChangeCategory() {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars.buttons[LMConstants.AccessibilityIdentifier.navBarRightButton].tap()
        app.sheets.firstMatch.tap()
        let tableView = app.tables[LMConstants.AccessibilityIdentifier.tableView]
        tableView.swipeUp()
        XCTAssert(tableView.cells[LMConstants.AccessibilityIdentifier.sixthCell].exists)
    }
    
    func testRouteToOtherCategory() {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars.buttons[LMConstants.AccessibilityIdentifier.navBarRightButton].tap()
        app.sheets.firstMatch.tap()
        app.tables[LMConstants.AccessibilityIdentifier.tableView].cells[LMConstants.AccessibilityIdentifier.firstCell].tap()
        XCTAssert(app.buttons[LMConstants.AccessibilityIdentifier.playVideoButton].exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
