//
//  FavoriteStationUseCase.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol FavoriteStationUseCase {
    func appendStationToFavorites(_ station: SpaceStation, completion: @escaping QueryCompletion<SpaceStation>)
    func removeStationFromFavorites(_ station: SpaceStation, completion: @escaping QueryCompletion<SpaceStation>)
}
