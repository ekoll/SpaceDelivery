//
//  FavouriteStationRepository.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol FavouriteStationRepository {
    func loadStations(completion: QueryCompletion<[FavouriteStation]>)
    func append(station: FavouriteStation, completion: CommandCompletion)
    func remove(station: FavouriteStation, completion: CommandCompletion)
}
