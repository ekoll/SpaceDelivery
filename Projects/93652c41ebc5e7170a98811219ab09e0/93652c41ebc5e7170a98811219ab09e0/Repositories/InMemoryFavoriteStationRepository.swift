//
//  InMemoryFavoriteStationRepository.swift
//  93652c41ebc5e7170a98811219ab09e0
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Foundation
import Domain

public class InMemoryFavoriteStationRepository: FavoriteStationRepository {
    private var stations: [FavoriteStation] = []
    
    public func loadStations(completion: (AppResult<[FavoriteStation]>) -> Void) {
        completion(.succes(stations))
    }
    
    public func append(station: FavoriteStation, completion: (AppError?) -> Void) {
        guard !stations.contains(station) else { return }
        stations.append(station)
        completion(nil)
    }
    
    public func remove(station: FavoriteStation, completion: (AppError?) -> Void) {
        stations.removeAll(where: { $0 == station })
        completion(nil)
    }
    
    public func update(station: FavoriteStation) {
        guard let index = stations.firstIndex(where: { $0 == station }) else { return }
        stations[index] = station
    }
}
