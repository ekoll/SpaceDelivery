//
//  SpaceshipTests.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import XCTest

class SpaceshipTests: XCTestCase {

    // MARK: - move
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
    
    // MARK: is OK
    func test_is_ship_ok_true_when_all_values_positive() {
        let spaceship = Spaceship(capacity: 10000, universalSpaceTime: 500, maxHealth: 100, coordinate: .zero)
        XCTAssertTrue(spaceship.isShipOK)
    }
    
    func test_is_ship_ok_false_when_UST_negative() {
        var spaceship = Spaceship(universalSpaceTime: 4, coordinate: .zero)
        spaceship.move(to: .init(x: 3, y: 4))
        
        XCTAssertFalse(spaceship.isShipOK)
    }
    
    func test_is_ship_ok_false_when_health_zero() {
        let spaceship = Spaceship(maxHealth: 0, coordinate: .zero)
        XCTAssertFalse(spaceship.isShipOK)
    }
    
    func test_is_ship_ok_false_when_stock_zero() {
        let spaceship = Spaceship(capacity: 0, coordinate: .zero)
        XCTAssertFalse(spaceship.isShipOK)
    }
    
    // MARK: do damage
    func test_do_damage_false_when_time_do_not_come() {
        var spaceship = Spaceship(durabilityTime: 10, lastDamageReceivedTime: Date().timeIntervalSince1970)
        XCTAssertFalse(spaceship.doDamage(5))
    }
    
    func test_do_damage_false_when_time_come() {
        var spaceship = Spaceship(durabilityTime: 10, lastDamageReceivedTime: Date().timeIntervalSince1970 - 20)
        XCTAssertTrue(spaceship.doDamage(5))
    }
    
    func test_do_damage_decrease_currentHealth_correctly() {
        var spaceship = Spaceship(durabilityTime: 10, maxHealth: 100, lastDamageReceivedTime: Date().timeIntervalSince1970 - 20)
        _ = spaceship.doDamage(5)
        
        let expectedHealth = 95
        XCTAssertEqual(spaceship.currentHealth, expectedHealth)
    }
    
    func test_currentHealth_does_not_fall_under_0_after_do_damage() {
        var spaceship = Spaceship(durabilityTime: 10, maxHealth: 4, lastDamageReceivedTime: Date().timeIntervalSince1970 - 20)
        _ = spaceship.doDamage(5)
        
        let expectedHealth = 0
        XCTAssertEqual(spaceship.currentHealth, expectedHealth)
    }
    
    // MARK: take from stock
    func test_take_stock_decrease_currentStock() {
        var spaceship = Spaceship(capacity: 100)
        _ = spaceship.takeFromStock(40)
        
        let expedtedResult = spaceship.capacity - 40
        XCTAssertEqual(spaceship.currentStock, expedtedResult)
    }
    
    func test_take_stock_returns_correct_stock() {
        let expedtedResult = Int64(40)
        
        var spaceship = Spaceship(capacity: 100)
        let stock = spaceship.takeFromStock(expedtedResult)
        
        XCTAssertEqual(stock, expedtedResult)
    }
    
    func test_take_more_stock_than_currentStock_returns_currentStock() {
        var spaceship = Spaceship(capacity: 10)
        let expedtedResult = spaceship.currentStock
        let stock = spaceship.takeFromStock(40)
        
        XCTAssertEqual(stock, expedtedResult)
    }
    
    func test_take_more_stock_than_currentStock_set_currentStock_to_0() {
        var spaceship = Spaceship(capacity: 10)
        _ = spaceship.takeFromStock(40)
        
        let expedtedResult = Int64(0)
        XCTAssertEqual(spaceship.currentStock, expedtedResult)
    }
}
