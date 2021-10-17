//
//  StationLoader.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public class StationLoader {
    private let repository: StationRepository
    private let favoriteRepository: FavoriteStationRepository
    
    public init(repository: StationRepository, favouriteRepository: FavoriteStationRepository) {
        self.repository = repository
        self.favoriteRepository = favouriteRepository
    }
}

extension StationLoader: LoadStationUseCase {
    
    public func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>) {
        repository.loadStations { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .succes(let stations):
                self.favoriteRepository.loadStations { result in
                    switch result {
                    case .succes(let favorites):
                        completion(.succes(self.merge(stations: stations, with: favorites)))
                        
                    case .error(let error):
                        print("Error on loading favorites:", error.message)
                        completion(.succes(self.merge(stations: stations, with: [])))
                    }
                }
                
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    private func merge(stations: [SpaceStation], with favorites: [FavoriteStation]) -> [SpaceStation] {
        guard favorites.count > 0 else {
            return stations
        }
        
        let updatedStations = stations.map { station -> SpaceStation in
            guard let favorite = favorites.first(where: { $0.name == station.name }) else {
                return station
            }
            
            var updatedStation = station
            updatedStation.isFavorite = true
            if favorite.coordinate != station.coordinate {
                updateCordinate(for: .init(name: station.name, coordinate: station.coordinate))
            }
            
            return updatedStation
        }
        
        return updatedStations
    }
}
 
extension StationLoader: FavoriteStationUseCase {
    
    public func loadFavoriteStations(completion: @escaping QueryCompletion<[FavoriteStation]>) {
        favoriteRepository.loadStations(completion: completion)
    }
    
    public func appendStationToFavorites(_ station: SpaceStation, completion: @escaping QueryCompletion<SpaceStation>) {
        guard !station.isFavorite else {
            completion(.succes(station))
            return
        }
        
        favoriteRepository.append(station: .init(name: station.name, coordinate: station.coordinate)) { error in
            switch error {
            case .none:
                var updatedStation = station
                updatedStation.isFavorite = true
                
                completion(.succes(updatedStation))
            case .some(let error):
                completion(.error(error))
            }
        }
    }

    public func removeStationFromFavorites(_ station: SpaceStation, completion: @escaping QueryCompletion<SpaceStation>) {
        guard station.isFavorite else {
            completion(.succes(station))
            return
        }
        
        favoriteRepository.remove(station: .init(name: station.name, coordinate: station.coordinate)) { error in
            switch error {
            case .none:
                var updatedStation = station
                updatedStation.isFavorite = false
                
                completion(.succes(updatedStation))
            case .some(let error):
                completion(.error(error))
            }
        }
    }
    
    internal func updateCordinate(for station: FavoriteStation) {
        favoriteRepository.update(station: station)
    }
}
