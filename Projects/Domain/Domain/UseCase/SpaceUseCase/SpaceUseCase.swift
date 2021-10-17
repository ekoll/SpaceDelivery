//
//  SpaceshipUseCase.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol SpaceUseCase {
    func move(ship: Spaceship, to station: SpaceStation) throws -> SpaceOperationResult<Spaceship>
    func makeDelivery(from ship: Spaceship, to station: SpaceStation) throws -> SpaceOperationResult<(ship: Spaceship, station: SpaceStation)>
    func tryToDamage(ship: Spaceship) -> SpaceOperationResult<(ship: Spaceship, didDamage: Bool)>
}
