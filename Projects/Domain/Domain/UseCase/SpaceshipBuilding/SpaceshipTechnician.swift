//
//  SpaceshipTechnician.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public class SpaceshipTechnician: BuildSpaceshipUseCase {
    
    public func build(from blueprint: SpaceShipBlueprint, coordinate: Coordinate) throws -> Spaceship {
        try blueprint.validate()
        
        return .init(
            name: blueprint.name,
            capacity: blueprint.capacity,
            universalSpaceTime: blueprint.speed,
            durabilityTime: Int64(blueprint.durability),
            maxHealth: 100,
            coordinate: coordinate
        )
    }
}
