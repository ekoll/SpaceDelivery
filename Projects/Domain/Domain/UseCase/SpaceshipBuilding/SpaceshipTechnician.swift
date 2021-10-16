//
//  SpaceshipTechnician.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public class SpaceshipTechnician: BuildSpaceshipUseCase {
    private let rules: SpaceShipCraftingRules
    
    public init(rules: SpaceShipCraftingRules) {
        self.rules = rules
    }
    
    public func build(from blueprint: SpaceShipBlueprint, coordinate: Coordinate) throws -> Spaceship {
        try blueprint.validate()
        
        return .init(
            name: blueprint.name,
            capacity: blueprint.capacity * rules.capacityMultiplier,
            universalSpaceTime: blueprint.speed * rules.universalSpaceTimeMultiplier,
            durabilityTime: TimeInterval(blueprint.durability) * rules.durabilityTimeMultiplier,
            maxHealth: rules.maxHealth,
            coordinate: coordinate
        )
    }
}
