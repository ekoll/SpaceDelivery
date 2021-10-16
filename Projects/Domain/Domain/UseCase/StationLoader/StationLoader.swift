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
 
extension StationLoader: FavouriteStationUseCase {
    
    public func loadFavouriteStations(completion: @escaping QueryCompletion<[FavouriteStation]>) {
        favouriteRepository.loadStations(completion: completion)
    }
    
    public func append(favouriteStation: FavouriteStation, completion: @escaping CommandCompletion) {
        favouriteRepository.append(station: favouriteStation, completion: completion)
    }
    
    public func remove(favouriteStation: FavouriteStation, completion: @escaping CommandCompletion) {
        favouriteRepository.remove(station: favouriteStation, completion: completion)
    }
}
