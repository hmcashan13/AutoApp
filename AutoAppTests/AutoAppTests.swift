//
//  CoxAutoAppTests.swift
//  CoxAutoAppTests
//
//  Created by Hudson Mcashan on 5/19/19.
//  Copyright © 2019 Guardian Angel. All rights reserved.
//

import XCTest
@testable import CoxAutoApp

class AutoAppTests: XCTestCase {
    var vehicleIds: [Int] = []
    
    override func setUp() {
        vehicleIds = [2014790487,1506295682,920250319,2127637793,1837731320,289131667,1310468730,305555626,1484380533]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testRetrieveVehicleIds() {
        let rxCallBackExpectation = self.expectation(description: "value was received")
        var fetchedVehicleIds: [Int] = []
        let dataFetcher = DataFetcher()
        
        dataFetcher.fetchVehicleIds { (ids) in
            if let ids = ids {
                fetchedVehicleIds = ids
                rxCallBackExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        wait(for: [rxCallBackExpectation], timeout: 10)
        XCTAssertEqual(vehicleIds.count, fetchedVehicleIds.count)
    }
    
    func testRetrieveVehicle() {
        let rxCallBackExpectation = self.expectation(description: "value was received")
        let dataFetcher = DataFetcher()
        dataFetcher.fetchVehicles(with: 1595947075) { (vehicle, _) in
            if let _ = vehicle?.vehicleId {
                rxCallBackExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        wait(for: [rxCallBackExpectation], timeout: 10)
    }
    
    func testRetrieveDealership() {
        let rxCallBackExpectation = self.expectation(description: "value was received")
        let dataFetcher = DataFetcher()
        dataFetcher.fetchVehicles(with: 1595947075) { (_, dealershipId) in
            if let dealerId = dealershipId {
                dataFetcher.fetchDealership(with: dealerId, completion: { (dealer) in
                    if let _ = dealer {
                        rxCallBackExpectation.fulfill()
                    } else {
                        XCTFail()
                    }
                })
            } else {
                XCTFail()
            }
        }
        wait(for: [rxCallBackExpectation], timeout: 10)
    }

}
