//
//  FavoriteStation.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public struct FavoriteStation {
    public var name: String
    public var coordinate: Coordinate
    
    public init(name: String, coordinate: Coordinate) {
        self.name = name
        self.coordinate = coordinate
    }

}

extension FavoriteStation: Equatable {
    public static func == (lhs: FavoriteStation, rhs: FavoriteStation) -> Bool {
        lhs.name == rhs.name
    }
}
