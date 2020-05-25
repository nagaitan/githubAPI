//
//  GitbubAPIUITests.swift
//  GitbubAPIUITests
//
//  Created by Adi Wibowo on 24/05/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import XCTest

class HomeScreenUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func test_home_screen_component() {
        let app = XCUIApplication()

        let goButton = app.buttons["Load Repo"]
        goButton.tap()
        
        let inProgressActivityIndicator = app.activityIndicators["In progress"]
        
        while inProgressActivityIndicator.exists {
            sleep(1)
        }
        
        sleep(1);
        //hit first row
        let itemCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(itemCell.exists)
        itemCell.tap()
        
        sleep(3);

    }
    
    override func tearDown() {
        super.tearDown()
           
    }
}
