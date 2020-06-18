//
//  NaPopravku_Test_UITests.swift
//  NaPopravku Test UITests
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import XCTest

class NaPopravku_Test_UITests: XCTestCase {

    // MARK: - Properties
    
    var application: XCUIApplication!
    
    // MARK: - XCTestCase preparations
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        application = XCUIApplication()
        application.launch()
    }

    // MARK: - Tests

    func testPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testInitialStateIsCorrect() {
        XCTAssertEqual(application.tables.count, 1)
        
        let tableView = application.tables.element
        XCTAssertNotNil(tableView)
        /// By default there are should 100 entities fetched.
        XCTAssertEqual(tableView.cells.count, 100)
    }
    
    func testUserTapsFirstCell() {
        let tableView = application.tables.element
        let firstCell = tableView.cells.firstMatch
        XCTAssertNotNil(firstCell)
        
        let repositoryInfoNavigationBar = application.navigationBars["NaPopravku_Test.RepositoryInfoView"]
        XCTAssertFalse(repositoryInfoNavigationBar.exists)
        XCTAssertEqual(application.tables.count, 1)
        XCTAssertNotEqual(application.images.count, 1)
        
        firstCell.tap()
        
        /// After tapping any cell screen with detailed info should appear
        if !repositoryInfoNavigationBar.waitForExistence(timeout: 1) {
            XCTFail()
        }
        XCTAssertTrue(repositoryInfoNavigationBar.exists)
        XCTAssertEqual(application.tables.count, 0)
        XCTAssertEqual(application.images.count, 1)
        
        /// After tapping "Back" we should return back
        let back = repositoryInfoNavigationBar.buttons["Back"]
        XCTAssertTrue(back.exists)
        
        back.tap()
        
        XCTAssertFalse(back.exists)
        XCTAssertFalse(repositoryInfoNavigationBar.exists)
        XCTAssertEqual(application.tables.count, 1)
        XCTAssertNotEqual(application.images.count, 1)
    }
    
}
