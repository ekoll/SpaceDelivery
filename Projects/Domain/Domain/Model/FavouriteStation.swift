//
//  FavouriteStation.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public struct FavouriteStation {
    public var name: String
    public var coordinate: Coordinate
}

extension FavouriteStation: Equatable {
    public static func == (lhs: FavouriteStation, rhs: FavouriteStation) -> Bool {
        lhs.name == rhs.name
    }
}
