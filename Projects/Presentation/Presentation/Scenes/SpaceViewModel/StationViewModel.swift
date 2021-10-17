//
//  StationViewModel.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain

public class StationViewModel {
    internal var station: SpaceStation
    internal var home: Location
    internal var shipLocation: Location
    
    internal init(station: SpaceStation, home: Location, shipLocation: Location) {
        self.station = station
        self.home = home
        self.shipLocation = shipLocation
        self.searchableName = station.name.lowercased()
    }
    
    public var searchableName: String
    public var name: String { station.name }
    public var isFavourite: Bool { station.isFavorite }
    public var ustCostText: String { "\(Int(station.coordinate.distance(from: shipLocation.coorditnate)))UST" }
    public var capacityText: String { station.capacity.description }
    public var stockText: String { station.stock.description }
    public var needText: String { station.need.description }
    public var distanceToHome: String { "\(Int(station.coordinate.distance(from: shipLocation.coorditnate)))UST" }
    
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
