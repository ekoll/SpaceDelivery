//
//  SpaceshipUseCase.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol SpaceUseCase {
    func move(ship: Spaceship, to station: SpaceStation) throws -> Spaceship
    func makeDelivery(from ship: Spaceship, to station: SpaceStation) throws -> (Spaceship, SpaceStation)
    func tryToDamage(ship: Spaceship) -> Spaceship
}
