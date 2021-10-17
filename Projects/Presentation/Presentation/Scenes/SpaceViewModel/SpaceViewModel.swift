//
//  SpaceViewModel.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain

public class SpaceViewModel {
    private var spaceShip: Spaceship
    public let stations: [StationViewModel]
    private let shipLocation: ShipLocation
    private let spaceUsecase: SpaceUseCase
    private let favoriteUsecase: FavoriteStationUseCase
    private weak var view: Renderer?
    
    public init(spaceShip: Spaceship, shipLocation: ShipLocation, stations: [SpaceStation], spaceUsecase: SpaceUseCase, favoriteUsecase: FavoriteStationUseCase, view: Renderer? = nil) {
        self.spaceShip = spaceShip
        self.shipLocation = shipLocation
        self.stations = stations.map { .init(station: $0, shipLocation: shipLocation) }
        self.spaceUsecase = spaceUsecase
        self.favoriteUsecase = favoriteUsecase
        self.view = view
    }
}

// MARK: - view model
extension SpaceViewModel {
    public var stockText: String {
        "\(spaceShip.currentStock)/\(spaceShip.capacity)"
    }
    
    public var universalSpaceTimeText: String {
        "\(spaceShip.currentUST)/\(spaceShip.universalSpaceTime)"
    }
    
    public var durabilityTimeText: String {
        Int64(spaceShip.durabilityTime * 1000).description
    }
    
    public var healthText: String {
        "\(spaceShip.currentHealth)/\(spaceShip.maxHealth)"
    }
    
    public var healthRation: Double {
        Double(spaceShip.currentHealth) / Double(spaceShip.maxHealth)
    }
 
    public var stationList: [StationViewModel] { stations }
}
