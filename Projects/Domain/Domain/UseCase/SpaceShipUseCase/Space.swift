//
//  Space.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

import Foundation

public class Space {
    
    public func move(ship: Spaceship, to station: SpaceStation) throws -> Spaceship {
        guard ship.coordinate != station.coordinate else {
            throw DomainError.alreadyThere
        }
        
        var updatedShip = ship
        updatedShip.coordinate = station.coordinate
        return updatedShip
    }
}

extension Space {
    enum DomainError: String, AppError {
        case alreadyThere = "Ship is already at this station"
        
        var message: String { rawValue }
    }
}
