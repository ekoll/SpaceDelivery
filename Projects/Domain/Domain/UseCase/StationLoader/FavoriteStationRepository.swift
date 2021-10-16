//
//  FavoriteStationRepository.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol FavoriteStationRepository {
    func loadStations(completion: QueryCompletion<[FavoriteStation]>)
    func append(station: FavoriteStation, completion: CommandCompletion)
    func remove(station: FavoriteStation, completion: CommandCompletion)
    func update(station: FavoriteStation)
}
