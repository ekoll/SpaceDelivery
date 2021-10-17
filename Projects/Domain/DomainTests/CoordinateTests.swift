//
//  CoordinateTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest

class CoordinateTests: XCTestCase {

    func test_distance() throws {
        let point1 = Coordinate.zero
        let point2 = Coordinate(x: 3, y: 4)
        
        let expectedDistance = 5.0
        let distance = point1.distance(from: point2)
        
        XCTAssertEqual(distance, expectedDistance)
    }
}
