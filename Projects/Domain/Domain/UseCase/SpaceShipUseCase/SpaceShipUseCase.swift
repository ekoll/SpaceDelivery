//
//  SpaceShipUseCase.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol SpaceShpUseCase {
    func move(ship: Spaceship, to station: SpaceStation) throws -> Spaceship
}
