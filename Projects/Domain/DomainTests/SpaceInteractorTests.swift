//
//  SpaceInteractorTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest

class SpaceInteractorTests: XCTestCase {

    func test_move_ship() throws {
        let station = SpaceStation(coordinate: .init(x: 1, y: 1))
        let spaceShip = Spaceship(coordinate: .zero)
        
        let updatedShip = try SpaceInteractor().move(ship: spaceShip, to: station)
        
        XCTAssertEqual(updatedShip.coordinate, station.coordinate)
    }

    func test_move_ship_when_already_at_target() throws {
        let coordinate = Coordinate(x: 5, y: 4)
        let station = SpaceStation(coordinate: coordinate)
        let spaceShip = Spaceship(coordinate: coordinate)
        
        XCTAssertThrowsError(try SpaceInteractor().move(ship: spaceShip, to: station), "Ship is already at station.") { error in
            XCTAssertEqual(error as? SpaceInteractor.DomainError, SpaceInteractor.DomainError.alreadyThere)
        }
    }
    
    func test_delivery() throws {
        let coordinate = Coordinate.zero
        let station = SpaceStation(coordinate: coordinate, capacity: 100, stock: 0, need: 100)
        let spaceship = Spaceship(capacity: 100, coordinate: coordinate)
        
        let (updatedShip, updatedStation) = try SpaceInteractor().makeDelivery(from: spaceship, to: station)
        
        XCTAssertEqual(updatedShip.currentStock, 0)
        XCTAssertEqual(updatedStation.stock, 100)
        XCTAssertEqual(updatedStation.need, 0)
    }
    
    func test_delivery_for_different_coordinates_not_work() throws {
        let station = SpaceStation(coordinate: .zero)
        let spaceship = Spaceship(coordinate: .init(x: 5, y: 2))
        
        XCTAssertThrowsError(try SpaceInteractor().makeDelivery(from: spaceship, to: station), "Ship is not at this station.") { error in
            XCTAssertEqual(error as? SpaceInteractor.DomainError, SpaceInteractor.DomainError.shipIsNotHere)
        }
    }
    
    func test_do_damage() {
        let damage = 10
        let spaceShip = Spaceship(maxHealth: 100)
        
        let updatedSpaceShip = SpaceInteractor(damageByTime: damage).tryToDamage(ship: spaceShip)
        
        let expectedHealth = spaceShip.currentHealth - damage
        XCTAssertEqual(updatedSpaceShip.currentHealth, expectedHealth)
    }
}
