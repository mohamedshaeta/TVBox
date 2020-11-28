//
//  TVBoxUITests.swift
//  TVBoxUITests
//
//  Created by Mohamed Sheta on 11/26/20.
//

import XCTest

class TVBoxUITests: XCTestCase {
    
    func testListViewsSectionsNumbers() {
        let app = XCUIApplication()
        app.launch()
        let tablesQuery = XCUIApplication().tables
        sleep(3)
        XCTAssertTrue(tablesQuery.cells.count > 0)
    }
    
    func testRateButton_IsExist() {
        
        let app = XCUIApplication()
        app.launch()
        sleep(3)
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"The Mandalorian").element/*[[".cells.containing(.staticText, identifier:\"2019-11-12\").element",".cells.containing(.staticText, identifier:\"8.5\").element",".cells.containing(.staticText, identifier:\"The Mandalorian\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let rateButton = app.buttons["RateButton"]
        XCTAssertTrue(rateButton.exists)
    }
    
    func testRatePressed_ButtonDisabled() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"The Mandalorian").element/*[[".cells.containing(.staticText, identifier:\"2019-11-12\").element",".cells.containing(.staticText, identifier:\"8.5\").element",".cells.containing(.staticText, identifier:\"The Mandalorian\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let rateButton = app.buttons["RateButton"]
        rateButton.tap()
        sleep(2)
        XCTAssertTrue(rateButton.isEnabled == false)
        
    }

}
