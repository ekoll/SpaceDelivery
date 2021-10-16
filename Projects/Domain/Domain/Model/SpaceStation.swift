//
//  SpaceStation.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public struct SpaceStation {
    public var name: String
    public var coordinate: Coordinate
    public var capacity: Int64
    public var stock: Int64
    public var need: Int64
}

extension SpaceStation: Equatable {
    public static func == (lhs: SpaceStation, rhs: SpaceStation) -> Bool {
        lhs.name == rhs.name
    }
}
