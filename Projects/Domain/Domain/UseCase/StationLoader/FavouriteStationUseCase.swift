//
//  FavouriteStationUseCase.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public protocol FavouriteStationUseCase {
    func append(favouriteStation: FavouriteStation, completion: @escaping CommandCompletion)
    func remove(favouriteStation: FavouriteStation, completion: @escaping CommandCompletion)
}
