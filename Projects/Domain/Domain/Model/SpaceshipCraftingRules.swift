//
//  SpaceshipCraftingRules.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public struct SpaceshipCraftingRules {
    public var homeName: String = ""
    public var homeCoordinate: Coordinate = .zero
    
    public var maxHealth: Int = 100
    public var capacityMultiplier: Int64 = 10000
    public var universalSpaceTimeMultiplier: Int = 20
    public var durabilityTimeMultiplier: TimeInterval = 10
}
