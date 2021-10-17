//
//  ShipLocation.swift
//  Presentation
//
//  Created by Ekrem Duvarbasi on 17.10.2021.
//

import Domain

public class ShipLocation {
    internal var name: String
    internal var coorditnate: Coordinate
    
    public init(name: String, coorditnate: Coordinate) {
        self.name = name
        self.coorditnate = coorditnate
    }
}
