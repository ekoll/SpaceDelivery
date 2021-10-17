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

struct FakeFavoriteStationRepository: FavoriteStationRepository {
    var stationsResult: AppResult<[FavoriteStation]> = .succes([])
    var appendStation: (FavoriteStation) -> AppError? = { _ in nil }
    var removeStation: (FavoriteStation) -> AppError? = { _ in nil }
    var updateStation: (FavoriteStation) -> Void = { _ in }
    
    func loadStations(completion: @escaping (AppResult<[FavoriteStation]>) -> Void) {
        completion(stationsResult)
    }
    
    func append(station: FavoriteStation, completion: @escaping (AppError?) -> Void) {
        completion(appendStation(station))
    }
    
    func remove(station: FavoriteStation, completion: @escaping (AppError?) -> Void) {
        completion(removeStation(station))
    }
    
    func update(station: FavoriteStation) {
        updateStation(station)
    }
}
