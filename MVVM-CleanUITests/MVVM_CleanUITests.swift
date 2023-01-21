//
//  MVVM_CleanUITests.swift
//  MVVM-CleanUITests
//
//  Created by MBS on 18/01/2023.
//

import XCTest

final class MVVM_CleanUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }


    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
       let searchTextfeild =  app.textFields["Search"]
        XCTAssertTrue(searchTextfeild.exists)
        
        searchTextfeild.tap()
        searchTextfeild.typeText("login")
        
        
        let button = app.buttons["Done"]
        XCTAssertTrue(button.exists)
        button.tap()

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
                 
            }
        }
    }
}
