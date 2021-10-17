//
//  SpaceStationTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest

class SpaceStationTests: XCTestCase {

    func test_add_stock_increase_stock_correctly() throws {
        var station = SpaceStation(capacity: 100, stock: 10, need: 90)
        let expectedResult = station.stock + 80
        
        station.add(stock: 80)
        
        XCTAssertEqual(station.stock, expectedResult)
    }
    
    func test_add_stock_decrease_need_correctly() throws {
        var station = SpaceStation(capacity: 100, stock: 10, need: 90)
        let expectedResult = station.need - 80
        
        station.add(stock: 80)
        
        XCTAssertEqual(station.need, expectedResult)
    }
    
    func test_add_stock_does_not_add_more_than_need() throws {
        var station = SpaceStation(capacity: 100, stock: 10, need: 60)
        let expedtedNeed = Int64(0)
        let expedtedStock = Int64(70)
        
        station.add(stock: 80)
        
        XCTAssertEqual(station.need, expedtedNeed)
        XCTAssertEqual(station.stock, expedtedStock)
    }
    
    func test_add_stock_does_not_add_more_than_current_capacity() throws {
        var station = SpaceStation(capacity: 100, stock: 10, need: 100)
        let expedtedNeed = Int64(10)
        let expedtedStock = Int64(100)
        
        station.add(stock: 100)
        
        XCTAssertEqual(station.need, expedtedNeed)
        XCTAssertEqual(station.stock, expedtedStock)
    }
}
