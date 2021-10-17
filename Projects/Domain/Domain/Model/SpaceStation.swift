//
//  SpaceStation.swift
//  Domain
//
//  Created by Ekrem Duvarbasi on 16.10.2021.
//

public struct SpaceStation {
    private(set) public var name: String
    private(set) public var coordinate: Coordinate
    private(set) public var capacity: Int64
    private(set) public var stock: Int64
    private(set) public var need: Int64
    internal(set) public var isFavorite: Bool
    
    public init(name: String = "", coordinate: Coordinate = .zero, capacity: Int64 = 0, stock: Int64 = 0, need: Int64 = 0, isFavorite: Bool = false) {
        self.name = name
        self.coordinate = coordinate
        self.capacity = capacity
        self.stock = stock
        self.need = need
        self.isFavorite = isFavorite
    }
    
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
