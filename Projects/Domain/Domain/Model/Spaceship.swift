//
//  Spaceship.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public struct Spaceship {
    public let name: String
    public let capacity: Int64
    public let universalSpaceTime: Int
    public let durabilityTime: TimeInterval
    public let maxHealth: Int
    
    private(set) public var coordinate: Coordinate = .zero
    private(set) public var currentUST: Int
    private(set) public var currentStock: Int64
    private(set) public var currentHealth: Int
    private(set) public var lastDamageReceivedTime: TimeInterval
    
    internal init(name: String = "", capacity: Int64 = 0, universalSpaceTime: Int = 0, durabilityTime: TimeInterval = 0, maxHealth: Int = 100, coordinate: Coordinate = .zero, lastDamageReceivedTime: TimeInterval = Date().timeIntervalSince1970) {
        self.name = name
        self.capacity = capacity
        self.universalSpaceTime = universalSpaceTime
        self.durabilityTime = durabilityTime
        self.maxHealth = maxHealth
        self.coordinate = coordinate
        
        currentUST = universalSpaceTime
        currentStock = capacity
        currentHealth = maxHealth
        self.lastDamageReceivedTime = lastDamageReceivedTime
    }
    
    internal mutating func resetLastDamageTime() {
        lastDamageReceivedTime = Date().timeIntervalSince1970
    }
    
    internal mutating func move(to coordinate: Coordinate) {
        let distance = coordinate.distance(from: self.coordinate)
        currentUST -= Int(distance)
        self.coordinate = coordinate
    }
    
    internal mutating func doDamage(_ damage: Int) -> Bool {
        let now = Date().timeIntervalSince1970
        guard now - lastDamageReceivedTime > durabilityTime else { return false }
        
        currentHealth = max(currentHealth - damage, 0)
        lastDamageReceivedTime = now
        
        return true
    }
    
    internal mutating func takeFromStock(_ amount: Int64) -> Int64 {
        let stock = min(amount, currentStock)
        currentStock -= stock
        
        return stock
    }
    
    internal var isShipOK: Bool {
        currentUST > 0
        && currentStock > 0
        && currentHealth > 0
    }
}
