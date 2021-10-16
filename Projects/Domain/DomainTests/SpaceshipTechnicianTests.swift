//
//  SpaceshipTechnicianTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest
@testable import Domain

class SpaceshipTechnicianTests: XCTestCase {
    let technician = SpaceshipTechnician()
    
    func test_craft_when_blueprint_name_invalid() {
        let blueprint = SpaceShipBlueprint(name: "")
        
        XCTAssertThrowsError(try technician.build(from: blueprint, coordinate: .init(x: 0, y: 0)))
    }
    
    func test_craft_when_blueprint_stats_invalid() throws {
        let blueprint = try SpaceShipBlueprint(name: "a_valid_name", maxAbilityPoints: 10, durability: 4, speed: 3, capacity: 2)
        
        XCTAssertThrowsError(try technician.build(from: blueprint, coordinate: .init(x: 0, y: 0)))
    }
    
    func test_craft_with_valid_blueprint() throws {
        let blueprint = try SpaceShipBlueprint(name: "a_valid_name", maxAbilityPoints: 10, durability: 4, speed: 3, capacity: 3)
        
        XCTAssertNoThrow(try technician.build(from: blueprint, coordinate: .init(x: 0, y: 0)))
    }
    
    func test_spaceship_coordinate_is_given() throws {
        let blueprint = SpaceShipBlueprint(name: "a_valid_name")
        let expedtedCoordinate = Coordinate(x: 5, y: 2)
        
        let spaceship = try technician.build(from: blueprint, coordinate: expedtedCoordinate)
        
        XCTAssertEqual(spaceship.coordinate, expedtedCoordinate)
    }
}
