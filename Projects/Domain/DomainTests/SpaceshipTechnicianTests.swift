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
        let blueprint = SpaceshipBlueprint(name: "")
        let technician = SpaceshipTechnician(rules: .init())
        
        XCTAssertThrowsError(try technician.build(from: blueprint))
    }
    
    func test_craft_when_blueprint_stats_invalid() throws {
        let blueprint = try SpaceshipBlueprint(name: "a_valid_name", maxAbilityPoints: 10, durability: 4, speed: 3, capacity: 2)
        let technician = SpaceshipTechnician(rules: .init())
        
        XCTAssertThrowsError(try technician.build(from: blueprint))
    }
    
    func test_craft_with_valid_blueprint() throws {
        let blueprint = try SpaceshipBlueprint(name: "a_valid_name", maxAbilityPoints: 10, durability: 4, speed: 3, capacity: 3)
        let technician = SpaceshipTechnician(rules: .init())
        
        XCTAssertNoThrow(try technician.build(from: blueprint))
    }
    
    func test_spaceship_coordinate_is_given() throws {
        let blueprint = SpaceshipBlueprint(name: "a_valid_name")
        let expedtedCoordinate = Coordinate(x: 5, y: 2)
        
        let technician = SpaceshipTechnician(rules: .init(home: expedtedCoordinate))
        let spaceship = try technician.build(from: blueprint)
        
        XCTAssertEqual(spaceship.coordinate, expedtedCoordinate)
    }
    
    func test_spaceship_max_health() throws {
        let expectedHealth = 100
        let blueprint = SpaceshipBlueprint(name: "a_valid_name")
        let rules = SpaceshipCraftingRules(maxHealth: expectedHealth)
        let technician = SpaceshipTechnician(rules: rules)
        
        let ship = try technician.build(from: blueprint)
        
        XCTAssertEqual(ship.maxHealth, expectedHealth)
    }
    
    func test_spaceship_capacity() throws {
        let expectedCapacity: Int64 = 5 * 10000
        let blueprint = try SpaceshipBlueprint(name: "a_valid_name", maxAbilityPoints: 5, capacity: 5)
        let rules = SpaceshipCraftingRules(capacityMultiplier: 10000)
        let technician = SpaceshipTechnician(rules: rules)
        
        let ship = try technician.build(from: blueprint)
        
        XCTAssertEqual(ship.capacity, expectedCapacity)
    }
    
    func test_spaceship_universal_spacetime() throws {
        let expectedUniversalSpaceTime = 20 * 5
        let blueprint = try SpaceshipBlueprint(name: "a_valid_name", maxAbilityPoints: 5, speed: 5)
        let rules = SpaceshipCraftingRules(universalSpaceTimeMultiplier: 20)
        let technician = SpaceshipTechnician(rules: rules)
        
        let ship = try technician.build(from: blueprint)
        
        XCTAssertEqual(ship.universalSpaceTime, expectedUniversalSpaceTime)
    }
    
    func test_spaceship_durability_time() throws {
        let expectedDurabilityTime: TimeInterval = 5 * 10
        let blueprint = try SpaceshipBlueprint(name: "a_valid_name", maxAbilityPoints: 5, durability: 5)
        let rules = SpaceshipCraftingRules(durabilityTimeMultiplier: 10)
        let technician = SpaceshipTechnician(rules: rules)
        
        let ship = try technician.build(from: blueprint)
        
        XCTAssertEqual(ship.durabilityTime, expectedDurabilityTime)
    }
    
    func test_spaceship_name() throws {
        let expectedName = "expected_name"
        let blueprint = SpaceshipBlueprint(name: expectedName)
        let technician = SpaceshipTechnician(rules: .init())
        
        let ship = try technician.build(from: blueprint)
        
        XCTAssertEqual(ship.name, expectedName)
    }
}
