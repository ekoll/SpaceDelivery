//
//  SpaceshipTechnician.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public class SpaceshipTechnician: BuildSpaceshipUseCase {
    private let rules: SpaceshipCraftingRules
    
    public init(rules: SpaceshipCraftingRules) {
        self.rules = rules
    }
    
    public func build(from blueprint: SpaceshipBlueprint) throws -> Spaceship {
        try blueprint.validate()
        
        return .init(
            name: blueprint.name,
            capacity: Int64(blueprint.capacity) * rules.capacityMultiplier,
            universalSpaceTime: blueprint.speed * rules.universalSpaceTimeMultiplier,
            durabilityTime: TimeInterval(blueprint.durability) * rules.durabilityTimeMultiplier,
            maxHealth: rules.maxHealth,
            stationName: rules.homeName,
            coordinate: rules.homeCoordinate
        )
    }
}
