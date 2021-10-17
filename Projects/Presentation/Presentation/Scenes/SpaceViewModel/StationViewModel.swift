//
//  StationViewModel.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain

public class StationViewModel {
    internal var station: SpaceStation
    internal var shipLocation: ShipLocation
    
    internal init(station: SpaceStation, shipLocation: ShipLocation) {
        self.station = station
        self.shipLocation = shipLocation
    }
    
    public var name: String { station.name }
    public var isFavourite: Bool { station.isFavorite }
    public var capacityText: String { station.capacity.description }
    public var stationText: String { station.stock.description }
    public var needText: String { station.need.description }
    
    public var operation: Operation {
        guard station.coordinate == shipLocation.coorditnate else {
            return .travel
        }

        return station.canDoploy ? .deploy : .nothing
    }
}

extension StationViewModel {
    public enum Operation {
        case travel
        case deploy
        case nothing
        
        public var description: String {
            switch self {
            case .travel: return "Travel"
            case .deploy: return "Deploy"
            case .nothing: return "Disabled"
            }
        }
    }
}

fileprivate extension SpaceStation {
    var canDoploy: Bool {
        capacity > stock && need > 0
    }
}
