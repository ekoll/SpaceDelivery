//
//  SpaceInteractor.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public class SpaceInteractor: SpaceUseCase {
    private let damageByTime: Int
    
    public init(damageByTime: Int = 10) {
        self.damageByTime = damageByTime
    }
    
    public func move(ship: Spaceship, to station: SpaceStation) throws -> Spaceship {
        guard ship.coordinate != station.coordinate else {
            throw DomainError.alreadyThere
        }
        
        var updatedShip = ship
        updatedShip.move(to: station.coordinate)
        
        return updatedShip
    }
    
    public func makeDelivery(from ship: Spaceship, to station: SpaceStation) throws -> (Spaceship, SpaceStation) {
        guard ship.coordinate == station.coordinate else {
            throw DomainError.shipIsNotHere
        }
        
        var updatedShip = ship
        var updatedStation = station
        
        let stockToDeliver = updatedShip.takeFromStock(station.need)
        updatedStation.add(stock: stockToDeliver)
        
        return (updatedShip, updatedStation)
    }
    
    public func tryToDamage(ship: Spaceship) -> Spaceship {
        var updatedShip = ship
        guard updatedShip.doDamage(damageByTime) else {
            return ship
        }
        
        return updatedShip
    }
}

extension SpaceInteractor {
    enum DomainError: String, AppError {
        case alreadyThere = "Ship is already at this station"
        case shipIsNotHere = "In order to make delivery, Ship must be at this station"
        
        var message: String { rawValue }
    }
}
