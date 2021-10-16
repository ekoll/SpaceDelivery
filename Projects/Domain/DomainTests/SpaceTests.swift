//
//  SpaceTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest

class SpaceTests: XCTestCase {

    func test_move_ship() throws {
        let station = SpaceStation(coordinate: .init(x: 1, y: 1))
        let spaceShip = Spaceship(coordinate: .zero)
        
        let updatedShip = try Space().move(ship: spaceShip, to: station)
        
        XCTAssertEqual(updatedShip.coordinate, station.coordinate)
    }

    func test_move_ship_when_already_at_target() throws {
        let coordinate = Coordinate(x: 5, y: 4)
        let station = SpaceStation(coordinate: coordinate)
        let spaceShip = Spaceship(coordinate: coordinate)
        
        XCTAssertThrowsError(try Space().move(ship: spaceShip, to: station), "Ship is already at station.") { error in
            XCTAssertEqual(error as? Space.DomainError, Space.DomainError.alreadyThere)
        }
    }
}
