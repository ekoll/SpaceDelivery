//
//  SpaceshipTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest

class SpaceshipTests: XCTestCase {

    func test_move_changes_coordinate() {
        let expedtedResult = Coordinate(x: 5, y: 4)
        var spaceship = Spaceship(coordinate: .zero)
        spaceship.move(to: expedtedResult)
        
        XCTAssertEqual(spaceship.coordinate, expedtedResult)
    }

    func test_move_decreases_currentUST() {
        let expedtedResult = 95
        var spaceship = Spaceship(universalSpaceTime: 100, coordinate: .zero)
        spaceship.move(to: .init(x: 3, y: 4))
        
        XCTAssertEqual(spaceship.currentUST, expedtedResult)
    }
    
    func test_is_ship_ok_true_when_UST_positive() {
        let spaceship = Spaceship(universalSpaceTime: 4, coordinate: .zero)
        
        XCTAssertTrue(spaceship.isShipOK)
    }
    
    func test_is_ship_ok_false_when_UST_negative() {
        var spaceship = Spaceship(universalSpaceTime: 4, coordinate: .zero)
        spaceship.move(to: .init(x: 3, y: 4))
        
        XCTAssertFalse(spaceship.isShipOK)
    }
}
