//
//  FakeStationRepository.swift
//  DomainTests
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

struct FakeStationRepository: StationRepository {
    var stationsResult: AppResult<[SpaceStation]> = .succes([])
    
    func loadStations(completion: @escaping QueryCompletion<[SpaceStation]>) {
        completion(stationsResult)
    }
}

struct FakeFavoriteStationRepository: FavouriteStationRepository {
    var stationsResult: AppResult<[FavouriteStation]> = .succes([])
    var appendStation: (FavouriteStation) -> AppError? = { _ in nil }
    var removeStation: (FavouriteStation) -> AppError? = { _ in nil }
    
    func loadStations(completion: (AppResult<[FavouriteStation]>) -> Void) {
        completion(stationsResult)
    }
    
    func append(station: FavouriteStation, completion: (AppError?) -> Void) {
        completion(appendStation(station))
    }
    
    func remove(station: FavouriteStation, completion: (AppError?) -> Void) {
        completion(removeStation(station))
    }
}
