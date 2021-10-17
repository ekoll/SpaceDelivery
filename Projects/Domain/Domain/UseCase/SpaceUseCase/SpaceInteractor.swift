//
//  SpaceInteractor.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public class SpaceInteractor: SpaceUseCase {
    private let damageByTime: Int
    private let homeName: String
    private let homeCoordinate: Coordinate
    
    public init(damageByTime: Int = 10, homeName: String = "", home: Coordinate = .zero) {
        self.damageByTime = damageByTime
        self.homeName = homeName
        self.homeCoordinate = home
    }
    
    public func move(ship: Spaceship, to station: SpaceStation) throws -> SpaceOperationResult<Spaceship> {
        guard ship.coordinate != station.coordinate else {
            throw DomainError.alreadyThere
        }
        
        var updatedShip = ship
        updatedShip.move(to: station.coordinate, name: station.name)
        let status = updatedShip.goHomeIfNeeded(home: homeCoordinate, name: homeName)
        
        return .init(shipStatus: status, updated: updatedShip)
    }
    
    public func makeDelivery(from ship: Spaceship, to station: SpaceStation) throws -> SpaceOperationResult<(ship: Spaceship, station: SpaceStation)> {
        guard ship.coordinate == station.coordinate else {
            throw DomainError.shipIsNotHere
        }
        
        var updatedShip = ship
        var updatedStation = station
        
        let stockToDeliver = updatedShip.takeFromStock(station.need)
        updatedStation.add(stock: stockToDeliver)
        
        let status = updatedShip.goHomeIfNeeded(home: homeCoordinate, name: homeName)
        
        return .init(shipStatus: status, updated: (updatedShip, updatedStation))
    }
    
    public func tryToDamage(ship: Spaceship) -> SpaceOperationResult<Spaceship> {
        var updatedShip = ship
        updatedShip.doDamage(damageByTime)
        let status = updatedShip.goHomeIfNeeded(home: homeCoordinate, name: homeName)
        
        return .init(shipStatus: status, updated: updatedShip)
    }
    
}

extension SpaceInteractor {
    enum DomainError: String, AppError {
        case alreadyThere = "Ship is already at this station"
        case shipIsNotHere = "In order to make delivery, Ship must be at this station"
        
        var message: String { rawValue }
    }
}
