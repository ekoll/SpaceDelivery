//
//  SpaceStation.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public struct SpaceStation {
    private(set) public var name: String = ""
    private(set) public var coordinate: Coordinate = .zero
    private(set) public var capacity: Int64 = 0
    private(set) public var stock: Int64 = 0
    private(set) public var need: Int64 = 0
    internal(set) public var isFavorite: Bool = false
    
    internal mutating func add(stock: Int64) {
        let stockToAdd = min(stock, need, capacity - self.stock)
        need -= stockToAdd
        self.stock += stockToAdd
    }
}

extension SpaceStation: Equatable {
    public static func == (lhs: SpaceStation, rhs: SpaceStation) -> Bool {
        lhs.name == rhs.name
    }
}
