//
//  SpaceViewModel.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain

public class SpaceViewModel {
    private var spaceship: Spaceship
    private let stations: [StationViewModel]
    private let shipLocation: ShipLocation
    private let spaceUsecase: SpaceUseCase
    private let favoriteUsecase: FavoriteStationUseCase
    private weak var view: Renderer?
    
    public init(spaceship: Spaceship, shipLocation: ShipLocation, stations: [SpaceStation], spaceUsecase: SpaceUseCase, favoriteUsecase: FavoriteStationUseCase, view: Renderer? = nil) {
        self.spaceship = spaceship
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
        "\(spaceship.currentStock)/\(spaceship.capacity)"
    }
    
    public var universalSpaceTimeText: String {
        "\(spaceship.currentUST)/\(spaceship.universalSpaceTime)"
    }
    
    public var durabilityTimeText: String {
        Int64(spaceship.durabilityTime * 1000).description
    }
    
    public var healthText: String {
        "\(spaceship.currentHealth)/\(spaceship.maxHealth)"
    }
    
    public var healthRation: Double {
        Double(spaceship.currentHealth) / Double(spaceship.maxHealth)
    }
 
    public var stationList: [StationViewModel] { stations }
}


// MARK: - funcs
extension SpaceViewModel {
    public func operationForStation(at index: Int) {
        guard stations.count > index else { return }
        let station = stations[index]
        
        do {
            switch station.operation {
            case .travel:
                try travel(to: station.station)
            case .deploy:
                break
            case .nothing:
                return
            }
        }
        catch let error as AppError {
            view?.present(error: error.message)
        }
        catch {
            print(error.localizedDescription)
            view?.present(error: "Something happened")
        }
    }
    
    public func tryToDamage() {
        let result = spaceUsecase.tryToDamage(ship: spaceship)
        spaceship = result.updated
        
        view?.updateUI()
        warnViewIfNeeded(forShipStatus: result.shipStatus)
    }
    
    public func toggleFavourite(of station: StationViewModel) {
        let compleiton: QueryCompletion<SpaceStation> = { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .succes(let updatedStation):
                    station.station = updatedStation
                    self.view?.updateUI()
                case .error(let error):
                    self.view?.present(error: error.message)
                }
            }
        }
        
        station.isFavourite
            ? favoriteUsecase.removeStationFromFavorites(station.station, completion: compleiton)
            : favoriteUsecase.appendStationToFavorites(station.station, completion: compleiton)
    }
}

// MARK: - private
private extension SpaceViewModel {
    func travel(to station: SpaceStation) throws {
        let result = try spaceUsecase.move(ship: spaceship, to: station)
        spaceship = result.updated
        shipLocation.coorditnate = spaceship.coordinate
        shipLocation.name = spaceship.name
        
        view?.updateUI()
        warnViewIfNeeded(forShipStatus: result.shipStatus)
    }
    
    func deploy(to station: StationViewModel) throws {
        let result = try spaceUsecase.makeDelivery(from: spaceship, to: station.station)
        spaceship = result.updated.ship
        shipLocation.coorditnate = spaceship.coordinate
        shipLocation.name = spaceship.name
        
        station.station = result.updated.station
        view?.updateUI()
        warnViewIfNeeded(forShipStatus: result.shipStatus)
    }
    
    func warnViewIfNeeded(forShipStatus shipStatus: Spaceship.Status) {
        switch shipStatus {
        case .broken:
            view?.present(alert: "Ship is broken and returned to home")
        case .noStock:
            view?.present(alert: "Ship has sold all of it's stock and returned to home")
        case .timeIsUp:
            view?.present(alert: "Ship's time is over and retuned to home")
        default:
            break
        }
    }
}
