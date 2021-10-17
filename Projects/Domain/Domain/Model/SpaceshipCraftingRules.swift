//
//  SpaceshipCraftingRules.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public struct SpaceshipCraftingRules {
    public var homeName: String
    public var homeCoordinate: Coordinate
    
    public var maxHealth: Int
    public var capacityMultiplier: Int64
    public var universalSpaceTimeMultiplier: Int
    public var durabilityTimeMultiplier: TimeInterval
    
    public init(homeName: String = "", homeCoordinate: Coordinate = .zero, maxHealth: Int = 100, capacityMultiplier: Int64 = 10000, universalSpaceTimeMultiplier: Int = 20, durabilityTimeMultiplier: TimeInterval = 10) {
        self.homeName = homeName
        self.homeCoordinate = homeCoordinate
        self.maxHealth = maxHealth
        self.capacityMultiplier = capacityMultiplier
        self.universalSpaceTimeMultiplier = universalSpaceTimeMultiplier
        self.durabilityTimeMultiplier = durabilityTimeMultiplier
    }
}
