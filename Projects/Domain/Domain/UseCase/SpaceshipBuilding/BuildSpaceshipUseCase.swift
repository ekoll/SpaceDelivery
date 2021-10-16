//
//  BuildSpaceshipUseCase.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol BuildSpaceshipUseCase {
    func build(from blueprint: SpaceShipBlueprint, coordinate: Coordinate) throws -> Spaceship
}
