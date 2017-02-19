//
//  AppsTrackerTests.swift
//  AppsTrackerTests
//
//  Created by Sofia Stanescu-Bellu on 1/21/17.
//  Copyright © 2017 sofiastb. All rights reserved.
//

import XCTest
@testable import AppsTracker

class AppsTrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: School Class Tests
    func testSchoolInitializationSucceeds() {
        // Confirm that the School initialier returns nil when passed a negative essay number or an empty name.
        func testMealInitializationFails() {
            // Negative rating
            let negativeEssayNumber = School.init(name: "Negative", date: "Negative", numOfEssays: -1, picture: nil)
            XCTAssertNil(negativeEssayNumber)
            
            
            // Empty String
            let emptyStringSchool = School.init(name: "", date: "Negative", numOfEssays: 0, picture: nil)
            XCTAssertNil(emptyStringSchool)
        }

    }
    
}
