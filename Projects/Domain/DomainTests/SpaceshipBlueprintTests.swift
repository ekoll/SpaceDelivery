//
//  SpaceshipBlueprintTests.swift
//  SpaceshipBlueprintTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest
@testable import Domain

class SpaceshipBlueprintInitializationTests: XCTestCase {

    // MARK: - init
    func testAbilityPointsDistributedEqually() throws {
        let blueprint = SpaceShipBlueprint(maxAbilityPoints: 15)
        let expectedAbilityPoints = 5
        
        XCTAssertEqual(blueprint.durability, expectedAbilityPoints)
        XCTAssertEqual(blueprint.speed, expectedAbilityPoints)
        XCTAssertEqual(blueprint.capacity, expectedAbilityPoints)
    }
    
    func testAbilityPointsDistributedEquallyWhenThereIsArbitrartyPoint() throws {
        let blueprint = SpaceShipBlueprint(maxAbilityPoints: 16)
        let expectedDurability = 6
        let expectedSpeed = 5
        let expectedCapacity = 5
        
        XCTAssertEqual(blueprint.durability, expectedDurability)
        XCTAssertEqual(blueprint.speed, expectedSpeed)
        XCTAssertEqual(blueprint.capacity, expectedCapacity)
    }
    
    func testAbilityPointsDistributedEquallyWhenThereAreTwoArbitrartyPoints() throws {
        let blueprint = SpaceShipBlueprint(maxAbilityPoints: 17)
        let expectedDurability = 6
        let expectedSpeed = 6
        let expectedCapacity = 5
        
        XCTAssertEqual(blueprint.durability, expectedDurability)
        XCTAssertEqual(blueprint.speed, expectedSpeed)
        XCTAssertEqual(blueprint.capacity, expectedCapacity)
    }
}

class SpaceshipBlueprintFunctionTests: XCTestCase {

    // MARK: decrease
    func test_decrease_durability() throws {
        let blueprint = try SpaceShipBlueprint(durability: 3)
        let expectedResult = 2
        
        blueprint.decreaseDurability()
        
        XCTAssertEqual(blueprint.durability, expectedResult)
    }
    
    func test_decrease_durability_when_it_is_0() throws {
        let blueprint = try SpaceShipBlueprint(durability: 0)
        let expectedResult = 0
        
        blueprint.decreaseDurability()
        XCTAssertEqual(blueprint.durability, expectedResult)
    }
    
    func test_decrease_speed() throws {
        let blueprint = try SpaceShipBlueprint(speed: 3)
        let expectedResult = 2
        
        blueprint.decreaseSpeed()
        
        XCTAssertEqual(blueprint.speed, expectedResult)
    }
    
    func test_decrease_speed_when_it_is_0() throws {
        let blueprint = try SpaceShipBlueprint(speed: 0)
        let expectedResult = 0
        
        blueprint.decreaseSpeed()
        XCTAssertEqual(blueprint.speed, expectedResult)
    }
    
    func test_decrease_capacity() throws {
        let blueprint = try SpaceShipBlueprint(capacity: 3)
        let expectedResult = 2
        
        blueprint.decreaseCapacity()
        
        XCTAssertEqual(blueprint.capacity, expectedResult)
    }
    
    func test_decrease_capacity_when_it_is_0() throws {
        let blueprint = try SpaceShipBlueprint(capacity: 0)
        let expectedResult = 0
        
        blueprint.decreaseCapacity()
        XCTAssertEqual(blueprint.capacity, expectedResult)
    }
    
    // MARK: increase
    func test_increase_durability() throws {
        let blueprint = try SpaceShipBlueprint(maxAbilityPoints: 5, durability: 3)
        let expectedResult = 4
        
        blueprint.increaseDurability()
        
        XCTAssertEqual(blueprint.durability, expectedResult)
    }
    
    func test_increase_durability_when_there_is_no_arbitrary_ability_point() throws {
        let blueprint = try SpaceShipBlueprint(maxAbilityPoints: 5, durability: 5)
        let expectedResult = 5
        
        blueprint.increaseDurability()
        XCTAssertEqual(blueprint.durability, expectedResult)
    }
    
    func test_increase_speed() throws {
        let blueprint = try SpaceShipBlueprint(maxAbilityPoints: 5, speed: 3)
        let expectedResult = 4
        
        blueprint.increaseSpeed()
        
        XCTAssertEqual(blueprint.speed, expectedResult)
    }
    
    func test_increase_speed_when_there_is_no_arbitrary_ability_point() throws {
        let blueprint = try SpaceShipBlueprint(maxAbilityPoints: 5, speed: 5)
        let expectedResult = 5
        
        blueprint.increaseSpeed()
        
        XCTAssertEqual(blueprint.speed, expectedResult)
    }
    
    func test_increase_capacity() throws {
        let blueprint = try SpaceShipBlueprint(maxAbilityPoints: 5, capacity: 3)
        let expectedResult = 4
        
        blueprint.increaseCapacity()
        
        XCTAssertEqual(blueprint.capacity, expectedResult)
    }
    
    func test_increase_capacity_when_there_is_no_arbitrary_ability_point() throws {
        let blueprint = try SpaceShipBlueprint(maxAbilityPoints: 5, capacity: 5)
        let expectedResult = 5
        
        blueprint.increaseCapacity()
        
        XCTAssertEqual(blueprint.capacity, expectedResult)
    }
}
