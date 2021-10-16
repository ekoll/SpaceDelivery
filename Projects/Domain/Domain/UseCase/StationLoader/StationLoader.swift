//
//  StationLoader.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public class StationLoader {
    private let repository: StationRepository
    private let favouriteRepository: FavouriteStationRepository
    
    public init(repository: StationRepository, favouriteRepository: FavouriteStationRepository) {
        self.repository = repository
        self.favouriteRepository = favouriteRepository
    }
}

extension StationLoader: LoadStationUseCase {
    
    public func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>) {
        repository.loadStations(completion: completion)
    }
}
 
extension StationLoader: FavoriteStationUseCase {
    
    public func loadFavoriteStations(completion: @escaping QueryCompletion<[FavouriteStation]>) {
        favouriteRepository.loadStations(completion: completion)
    }
    
    public func appendStationToFavorites(_ station: SpaceStation, completion: @escaping QueryCompletion<SpaceStation>) {
        guard !station.isFavourite else {
            completion(.succes(station))
            return
        }
        
        favouriteRepository.append(station: .init(name: station.name, coordinate: station.coordinate)) { error in
            switch error {
            case .none:
                var updatedStation = station
                updatedStation.isFavourite = true
                
                completion(.succes(updatedStation))
            case .some(let error):
                completion(.error(error))
            }
        }
    }

    public func removeStationFromFavorites(_ station: SpaceStation, completion: @escaping QueryCompletion<SpaceStation>) {
        guard station.isFavourite else {
            completion(.succes(station))
            return
        }
        
        favouriteRepository.remove(station: .init(name: station.name, coordinate: station.coordinate)) { error in
            switch error {
            case .none:
                var updatedStation = station
                updatedStation.isFavourite = false
                
                completion(.succes(updatedStation))
            case .some(let error):
                completion(.error(error))
            }
        }
    }
}
