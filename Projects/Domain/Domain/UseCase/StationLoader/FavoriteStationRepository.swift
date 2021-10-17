//
//  FavoriteStationRepository.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol FavoriteStationRepository {
    func loadStations(completion: @escaping QueryCompletion<[FavoriteStation]>)
    func append(station: FavoriteStation, completion: @escaping CommandCompletion)
    func remove(station: FavoriteStation, completion: @escaping CommandCompletion)
    func update(station: FavoriteStation)
}
