//
//  SpaceshipTechnicianTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest
@testable import Domain

class SpaceshipTechnicianTests: XCTestCase {
    
    func test_craft_when_blueprint_name_invalid() {
        let blueprint = SpaceShipBlueprint(name: "")
        let technician = SpaceshipTechnician(rules: .init())
        
        XCTAssertThrowsError(try technician.build(from: blueprint, coordinate: .init(x: 0, y: 0)))
    }
    
    func test_craft_when_blueprint_stats_invalid() throws {
        let blueprint = try SpaceShipBlueprint(name: "a_valid_name", maxAbilityPoints: 10, durability: 4, speed: 3, capacity: 2)
        let technician = SpaceshipTechnician(rules: .init())
        
        XCTAssertThrowsError(try technician.build(from: blueprint, coordinate: .init(x: 0, y: 0)))
    }
    
    func test_craft_with_valid_blueprint() throws {
        let blueprint = try SpaceShipBlueprint(name: "a_valid_name", maxAbilityPoints: 10, durability: 4, speed: 3, capacity: 3)
        let technician = SpaceshipTechnician(rules: .init())
        
        XCTAssertNoThrow(try technician.build(from: blueprint, coordinate: .init(x: 0, y: 0)))
    }
    
    func test_spaceship_coordinate_is_given() throws {
        let blueprint = SpaceShipBlueprint(name: "a_valid_name")
        let expedtedCoordinate = Coordinate(x: 5, y: 2)
        
        let technician = SpaceshipTechnician(rules: .init())
        let spaceship = try technician.build(from: blueprint, coordinate: expedtedCoordinate)
        
        XCTAssertEqual(spaceship.coordinate, expedtedCoordinate)
    }
    
    func test_spaceship_max_health() throws {
        let expectedHealth = 100
        let blueprint = SpaceShipBlueprint(name: "a_valid_name")
        let rules = SpaceShipCraftingRules(maxHealth: expectedHealth)
        let technician = SpaceshipTechnician(rules: rules)
        
        let ship = try technician.build(from: blueprint, coordinate: .zero)
        
        XCTAssertEqual(ship.maxHealth, expectedHealth)
    }
    
    func test_spaceship_capacity() throws {
        let expectedCapacity = 5 * 10000
        let blueprint = try SpaceShipBlueprint(name: "a_valid_name", maxAbilityPoints: 5, capacity: 5)
        let rules = SpaceShipCraftingRules(capacityMultiplier: 10000)
        let technician = SpaceshipTechnician(rules: rules)
        
        let ship = try technician.build(from: blueprint, coordinate: .zero)
        
        XCTAssertEqual(ship.capacity, expectedCapacity)
    }
    
    func test_spaceship_universal_spacetime() throws {
        let expectedUniversalSpaceTime = 20 * 5
        let blueprint = try SpaceShipBlueprint(name: "a_valid_name", maxAbilityPoints: 5, speed: 5)
        let rules = SpaceShipCraftingRules(universalSpaceTimeMultiplier: 20)
        let technician = SpaceshipTechnician(rules: rules)
        
        let ship = try technician.build(from: blueprint, coordinate: .zero)
        
        XCTAssertEqual(ship.universalSpaceTime, expectedUniversalSpaceTime)
    }
    
    func test_spaceship_durability_time() throws {
        let expectedDurabilityTime: TimeInterval = 5 * 10
        let blueprint = try SpaceShipBlueprint(name: "a_valid_name", maxAbilityPoints: 5, durability: 5)
        let rules = SpaceShipCraftingRules(durabilityTimeMultiplier: 10)
        let technician = SpaceshipTechnician(rules: rules)
        
        let ship = try technician.build(from: blueprint, coordinate: .zero)
        
        XCTAssertEqual(ship.durabilityTime, expectedDurabilityTime)
    }
    
    func test_spaceship_name() throws {
        let expectedName = "expected_name"
        let blueprint = SpaceShipBlueprint(name: expectedName)
        let technician = SpaceshipTechnician(rules: .init())
        
        let ship = try technician.build(from: blueprint, coordinate: .zero)
        
        XCTAssertEqual(ship.name, expectedName)
    }
    
    func test_spaceship_coordinate() throws {
        let expectedCoordinate = Coordinate(x: 5, y: 4)
        let blueprint = SpaceShipBlueprint(name: "a_valid_name")
        let technician = SpaceshipTechnician(rules: .init())
        
        let ship = try technician.build(from: blueprint, coordinate: expectedCoordinate)
        
        XCTAssertEqual(ship.coordinate, expectedCoordinate)
    }
}
