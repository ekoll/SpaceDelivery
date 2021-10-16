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
    
    internal init(name: String = "", capacity: Int64 = 0, universalSpaceTime: Int = 0, durabilityTime: TimeInterval = 0, maxHealth: Int = 100, coordinate: Coordinate = .zero) {
        self.name = name
        self.capacity = capacity
        self.universalSpaceTime = universalSpaceTime
        self.durabilityTime = durabilityTime
        self.maxHealth = maxHealth
        self.coordinate = coordinate
        
        currentUST = universalSpaceTime
    }
    
    internal mutating func move(to coordinate: Coordinate) {
        let distance = coordinate.distance(from: self.coordinate)
        currentUST -= Int(distance)
        self.coordinate = coordinate
    }
    
    internal var isShipOK: Bool {
        currentUST > 0
    }
}
